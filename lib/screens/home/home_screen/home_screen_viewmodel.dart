import 'package:flutter/foundation.dart';

class HomeScreenViewModel extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  setPage(int page) {
    _currentPage = page;

    notifyListeners();
  }
}
