import 'package:flutter/material.dart';

enum ViewState {
  Idle,
  Busy,
}

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  String _errorMessage;

  ViewState get state => _state;
  String get errorMessage => _errorMessage;
  bool get hasErrorMessage => _errorMessage != null && _errorMessage.isNotEmpty;

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
