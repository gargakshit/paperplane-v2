import '../../models/accounts/register.dart';

abstract class AccountsService {
  Future<RegisterResponseModel> register(RegisterResponseModel request);
}
