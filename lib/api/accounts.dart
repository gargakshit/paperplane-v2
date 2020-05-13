import 'package:dio/dio.dart';

import 'package:paperplane/constants/api.dart';
import 'package:paperplane/models/accounts/register.dart';

class AccountsApi {
  static Future<RegisterResponseModel> register(
    RegisterRequestModel req,
  ) async {
    final dio = Dio();

    final response = await dio.post(
      "$directoryUrl/register",
      data: req.toJson(),
      options: Options(
        headers: {"Content-Type": "application/json"},
        responseType: ResponseType.json,
      ),
    );

    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(response.data);
    } else {
      throw new Exception("Error registering the user!");
    }
  }
}
