import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:fimii/enums/view_state.dart';
import 'package:fimii/models/player.dart';
import 'package:fimii/scoped_models/base_model.dart';
import 'package:fimii/service_locator.dart';
import 'package:fimii/services/api.dart';
import 'package:fimii/ui/views/account/edit_account_view.dart';
import 'package:fimii/ui/views/auth/sign_up_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  String error = '';

  String email = '';

  Player player;

  onModelReady() async {
    final prefs = await SharedPreferences.getInstance();

    email = prefs.getString('email');

    setState(ViewState.busy);
    player = await apiService.fetchAccount(email).catchError((e) {
      error = e.toString();

      if (kDebugMode) {
        print(error);
      }

      setState(ViewState.error);
    });

    if (state == ViewState.error) return false;


    setState(ViewState.retrieved);

    return true;
  }

  signOut(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpView()));

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
  }

  moveToEditView(context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditAccountView()));

    onModelReady();
  }

  editProfile(context) async {
    setState(ViewState.busy);
    player = await apiService.editAccount(player).catchError((e) {
      error = e.toString();

      if (kDebugMode) {
        print(error);
      }

      setState(ViewState.error);
    });

    if (state == ViewState.error) return false;


    setState(ViewState.retrieved);

    Navigator.pop(context);
  }


  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  onPasswordChange(String text) {
    player.password = generateMd5(text);
  }
}