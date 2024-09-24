import 'package:flutter/material.dart';
import 'package:rs_productapp_project/services/auth_services.dart';

class LoginViewModel extends ChangeNotifier {

  bool isLoading = false;
  
  // email and passowrd auth part
  Future<String> loginUser(String email,String password) async {
    isLoading = true;
    // signup user using our authmethod
    String res = await AuthMethod().loginUser(
        email: email, password: password );
    if (res == "success") {
      isLoading = false;
    } else {
        isLoading = false;
    }
    return res;
  }

  Future<String> signupUser(String email, String password, String name) async {
      isLoading = true;
    // signup user using our authmethod
    String res = await AuthMethod().signupUser(
        email: email,
        password: password,
        name: name);
    if (res == "success") {
        isLoading = false;
    } else {
        isLoading = false;
    }
    return res;
  }

}