import 'package:flutter/material.dart';
import 'package:sirius_tracker_contratante/model/servicesbyuser.dart';
import '../chatscreen.dart';

class Chat extends StatelessWidget {
  final ServicesByUser service;

  Chat({Key key, @required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Chat'),
      ),
      body: new ChatScreen(
        serv: service,
      ),
    );
  }
}