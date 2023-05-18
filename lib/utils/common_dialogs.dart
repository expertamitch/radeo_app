import 'package:flutter/material.dart';

import '../styling/font_style_globle.dart';

showDeleteConfirmation(BuildContext context, String message) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Yes"),
    onPressed: () async {
      Navigator.of(context).pop();


    },
  );

  Widget noButton = TextButton(
    child: Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Confirm",
      style: w900_16(),
    ),
    content: Text(message, style: w600_14()),
    actions: [okButton, noButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}