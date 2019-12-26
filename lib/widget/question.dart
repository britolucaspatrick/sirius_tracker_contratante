import 'package:flutter/material.dart';
class Question {
  VoidCallback onPressed;

  Question({this.onPressed});

  void showAlertDialog(final BuildContext context, final String msg) {

    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        onPressed();
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () { Navigator.pop(context); },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Pergunta"),
      content: Text(msg),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}