import 'dart:io';

import '../../models/accounts/register.dart';

abstract class AccountsService {
  Future<RegisterResponseModel> register();
  Future<void> initializeProfile(String name, File profilePhoto);
}
