import 'package:flutter/foundation.dart';

/// Provider for managing main bottom navigation state
class MainProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  /// Change the current tab index
  void changeTab(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  /// Reset to home tab
  void resetToHome() {
    _currentIndex = 0;
    notifyListeners();
  }
}
