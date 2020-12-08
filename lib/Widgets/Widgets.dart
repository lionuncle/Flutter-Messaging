import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoastalert/FlutterToastAlert.dart';

class ApplicationToast {
  static getErrorToast({@required String msg}) async {
    await FlutterToastAlert.showToastAndAlert(
      toastDuration: 3,
      toastShowIcon: false,
      type: Type.Error,
      androidToast: msg,
      iosTitle: "Error",
      iosSubtitle: msg,
    );
  }

  static getSuccessToast(
      {
        @required String msg}) async {
    await FlutterToastAlert.showToastAndAlert(
      toastDuration: 3,
      toastShowIcon: true,
      type: Type.Success,
      androidToast: msg,
      iosTitle: "Success",
      iosSubtitle: msg,
    );
  }

  static getInfoToast(
      {@required int durationTime,
        @required String heading,
        @required String msg}) async {
    await FlutterToastAlert.showToastAndAlert(
      toastDuration: 3,
      toastShowIcon: true,
      type: Type.Info,
      androidToast: msg,
      iosTitle: "info",
      iosSubtitle: msg,
    );
  }
}