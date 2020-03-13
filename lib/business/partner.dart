import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sirius_tracker_contratante/model/partner.dart';

class PartnerBusiness{

  static Future<void> post(Partner partner){
    return Firestore.instance.collection("partner").add(partner.toJson());
  }
}