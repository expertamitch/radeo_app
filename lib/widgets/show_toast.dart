import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg, context, {bool centerToast = false}) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.grey[900]),
      child: Text(msg,
          style: const TextStyle(
              fontFamily: 'FuturaNext', color: Colors.white, fontSize: 14)));

  fToast.showToast(
      child: toast,
      gravity: centerToast ? ToastGravity.CENTER : ToastGravity.BOTTOM);
}
