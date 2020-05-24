import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:pinenacl/secret.dart';
import 'package:uuid/uuid.dart';

import 'accounts_service.dart';
import '../locator.dart';
import '../key_value/key_value_service.dart';
import '../media/media_service.dart';
import '../nacl/nacl_service.dart';
import '../../constants/api.dart';
import '../../constants/onboarding_state.dart';
import '../../models/accounts/register.dart';

class AccountsServiceHttp extends AccountsService {
  @override
  Future<RegisterResponseModel> register() async {
    final storage = new FlutterSecureStorage();

    Dio dio = locator<Dio>();
    KeyValueService prefs = locator<KeyValueService>();
    NaClService nacl = locator<NaClService>();

    PrivateKey myKeys = nacl.generateKeyPair();
    PublicKey pubKey = myKeys.publicKey;

    await storage.write(key: "myPrivateKey", value: myKeys.join(","));

    Response response = await dio.post(
      "$directoryUrl/register",
      data: {
        "public_key": Base64Encoder().convert(pubKey),
      },
      options: Options(
        headers: {"Content-Type": "application/json"},
        responseType: ResponseType.json,
      ),
    );

    if (response.statusCode == 200) {
      RegisterResponseModel registerResponse =
          RegisterResponseModel.fromJson(response.data);

      await prefs.setString("myId", registerResponse.id);
      await prefs.setString("authKey", registerResponse.token);
      await prefs.setString("authKeyTime", DateTime.now().toString());
      await prefs.setString("refreshToken", registerResponse.refreshToken);
      await prefs.setBool("onBoardingComplete", false);
      await prefs.setInt("onBoardingState", OnBoardingState.ID_GENERATED.index);

      return registerResponse;
    } else {
      throw Exception("Error registering the user!");
    }
  }

  Future<void> initializeProfile(String name, File profilePhoto) async {
    MediaService mediaService = locator<MediaService>();
    KeyValueService prefs = locator<KeyValueService>();

    await prefs.setBool("hasPfp", false);

    if (profilePhoto != null) {
      String docsDir = (await getApplicationDocumentsDirectory()).path;

      await File(join(docsDir, "pfp.png")).writeAsBytes(
        await profilePhoto.readAsBytes(),
      );

      String password = "${Random.secure().nextInt(9999999)}-${Uuid().v4()}";

      String mediaId = await mediaService.uploadMedia(
        profilePhoto,
        password,
        prefs.getString("authKey"),
      );

      await prefs.setString("pfpPass", password);
      await prefs.setBool("hasPfp", true);
      await prefs.setString(
        "pfpMediaId",
        mediaId,
      );
    }

    await prefs.setString(
      "myName",
      name,
    );
    await prefs.setBool("onBoardingComplete", true);
    await prefs.setInt(
      "onBoardingState",
      OnBoardingState.ABOUT_UPDATED.index,
    );
  }

  Future<String> getUserPublicKey(String id) async {
    Dio dio = locator<Dio>();
    Response<String> response = await dio.get("$directoryUrl/$id");

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Error pulling the public keys!");
    }
  }

  Future<String> refreshToken() async {
    KeyValueService prefs = locator<KeyValueService>();

    DateTime oldTokenIssueTime = DateTime.parse(prefs.getString("authKeyTime"));
    if (oldTokenIssueTime.add(Duration(minutes: 50)).isBefore(DateTime.now())) {
      // fetch new token
      Dio dio = locator<Dio>();
      String refreshToken = prefs.getString("refreshToken");

      Response<String> response = await dio.post(
        "$authUrl/refresh",
        options: Options(
          headers: {
            "X-Refresh-Token": refreshToken,
          },
        ),
      );

      if (response.statusCode == 200) {
        await prefs.setString("authKey", response.data);
        await prefs.setString("authKeyTime", DateTime.now().toString());

        return response.data;
      } else {
        throw Exception("Error refreshing the token!");
      }
    } else {
      return prefs.getString("authKey");
    }
  }
}
