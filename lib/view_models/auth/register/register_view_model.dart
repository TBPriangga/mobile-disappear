import 'package:dio/dio.dart';
import 'package:disappear/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool _isPasswordObscured = true;

  set isPasswordObscured(bool isPasswordObscured) {
    _isPasswordObscured = isPasswordObscured;
    notifyListeners();
  }

  bool get isPasswordObscured => _isPasswordObscured;

  void togglePasswordObscure() {
    isPasswordObscured = !isPasswordObscured;
  }

  bool _isLoading = false;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  String? _message;

  set message(String? message) {
    _message = message;
    notifyListeners();
  }

  String? get message => _message;

  bool? _isEmailSent;

  set isEmailSent(bool? isEmailSent) {
    _isEmailSent = isEmailSent;
    notifyListeners();
  }

  bool? get isEmailSent => _isEmailSent;

  Future<void> sendEmail() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      isEmailSent = null;

      try {
        final authService = AuthService();

        final response = await authService.register(
          emailController.text,
          passwordController.text
        );
        message = response['message'];

        isEmailSent = true;
      } on DioException catch (error) {
        if (error.response != null) {
          if ([400, 401, 404, 409, 500].contains(error.response!.statusCode)) {
            message = error.response!.data['message'];
          } else {
            message = 'Terjadi kesalahan pada server';
          }

          isEmailSent = false;
        }
      } finally {
        isLoading = false;
      }
    }
  }
  
  String? validateEmail(value) {
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value!)) {
      return 'Email tidak valid';
    }

    return null;
  }

  String? validatePassword(value) {
    if (value!.length < 8) {
      return 'Kata sandi mininal harus berisi 8 karakter';
    }

    if (value!.trim().isEmpty) {
      return 'Kata sandi mininal harus berisi 8 karakter';
    }

    return null;
  }
}