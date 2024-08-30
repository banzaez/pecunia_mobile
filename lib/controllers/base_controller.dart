import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final _isLoading = RxBool(false);
  final _error = RxnString();

  bool get isLoading => _isLoading();

  set isLoading(bool value) => _isLoading.value = value;

  String? get error => _error();

  set error(String? value) {
    _error.value = value;
    if(value != null) debugPrint(value);
  }
}
