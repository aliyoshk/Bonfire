import 'package:flutter/material.dart';

class ServiceFactory extends ChangeNotifier {
  bool useMockData = false;

  ServiceFactory();

  void toggleEnvironment() {
    useMockData = !useMockData;
    notifyListeners();
  }

  void setEnvironment(bool useMock) {
    useMockData = useMock;
    notifyListeners();
  }
}