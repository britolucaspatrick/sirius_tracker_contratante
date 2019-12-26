import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sirius_tracker_contratante/model/contact.dart';

class ContactBusiness{
  static Future<void> post(Contact contact){
    return Firestore.instance.collection("contact").document().setData(contact.toJson());
  }
}