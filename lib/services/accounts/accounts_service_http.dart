import 'package:dio/dio.dart';

import 'accounts_service.dart';
import '../locator.dart';
import '../../constants/api.dart';
import '../../models/accounts/register.dart';

class AccountsServiceHttp extends AccountsService {
  @override
  Future<RegisterResponseModel> register(RegisterResponseModel request) async {
    Dio dio = locator<Dio>();

    Response response = await dio.post(
      "$directoryUrl/register",
      data: request.toJson(),
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
