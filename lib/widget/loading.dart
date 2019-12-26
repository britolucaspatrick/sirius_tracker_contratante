import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String msg;

  const Loading({Key key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(msg)
      ],
    );
  }

}