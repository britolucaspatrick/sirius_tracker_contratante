

import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {

  String userID;
  String msg;
  int app; //0 agente //1 contratante
  int st_atendimento; //0 aberto 1 em atendimento 2 atendido

  Contact({
  this.userID,
  this.msg,
  this.app,
  this.st_atendimento});

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'msg': msg,
      'app': app,
      'st_atendimento': st_atendimento,
    };
  }

  factory Contact.fromJson(Map<dynamic, dynamic> doc) {
    Contact contact = new Contact(
      userID: doc['userID'],
      msg: doc['msg'],
      app: doc['app'],
      st_atendimento: doc['st_atendimento'],
    );
  }

  factory Contact.fromDocument(DocumentSnapshot doc) {
    return Contact.fromJson(doc.data);
  }

}