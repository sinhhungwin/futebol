import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/base_model.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:fimii/service_locator.dart';
import 'package:fimii/services/api.dart';
import 'package:fimii/ui/views/home_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AuthModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  String error = 'Something wrong';

  String email = '';
  String password = '';

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  signUp(context) async{
    setState(ViewState.busy);
    String returnEmail = await apiService.signUp(email, generateMd5(password)).catchError((e) {
      error = e.toString();
      if (kDebugMode) {
        print(error);
      }
      setState(ViewState.error);
    });

    if (state == ViewState.error) {
      ToastContext().init(context);

      if(error.contains('duplicate')) {
        Toast.show("User exists", duration: Toast.lengthShort, gravity:  Toast.bottom);
      } else {
        Toast.show(error, duration: Toast.lengthShort, gravity:  Toast.bottom);
      }

      return false;
    }
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', returnEmail);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeView()));

    setState(ViewState.retrieved);

    return true;
  }

  signIn(context) async{
    setState(ViewState.busy);
    String returnEmail = await apiService.signIn(email, generateMd5(password)).catchError((e) {
      error = e.toString();
      if (kDebugMode) {
        print(error);
      }
      setState(ViewState.error);
    });

    if (state == ViewState.error || returnEmail.isEmpty) {
      ToastContext().init(context);

      if(returnEmail?.isEmpty ?? true) {
        setState(ViewState.error);
        Toast.show('Wrong email or password. Try again.', duration: Toast.lengthShort, gravity:  Toast.bottom);
      } else {
        Toast.show(error, duration: Toast.lengthShort, gravity:  Toast.bottom);
      }

      return false;
    }

      if (kDebugMode) {
        print(returnEmail);
      }
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', returnEmail);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeView()));

    setState(ViewState.retrieved);

      return true;
    }
  }