import 'package:flutter/foundation.dart';

import '../../../models/accounts/register.dart';
import '../../../services/locator.dart';
import '../../../services/accounts/accounts_service.dart';

class NewAccountScreenViewModel extends ChangeNotifier {
  bool _idGenerated = false;
  bool get idGenerated => _idGenerated;

  String _id;
  String get id => _id;

  bool _error = false;
  bool get error => _error;

  register() async {
    await Future.delayed(
      Duration(
        seconds: 3,
      ),
    );

    try {
      RegisterResponseModel registerResponse =
          await locator<AccountsService>().register();

      _idGenerated = true;
      _id = registerResponse.id;

      notifyListeners();
    } catch (e) {
      _idGenerated = true;
      _error = true;

      notifyListeners();
    }
  }
}
