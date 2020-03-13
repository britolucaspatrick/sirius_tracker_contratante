import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sirius_tracker_contratante/model/partner.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;

class PartnerBusiness{

  static Future<void> post(Partner partner, File _image) async {
    Firestore.instance.collection("partner").add(partner.toJson()).then((ref){
      partner.documentID = ref.documentID;
      Firestore.instance.collection("partner").document(ref.documentID).updateData(partner.toJson());

      return saveImage(_image, ref.documentID, partner);
    });
  }

  static Future<String> saveImage(File _image, String documentID, Partner partner) async {
    String path = 'partnerLogos/${documentID}';
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(path);
    StorageUploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((v){
      updateUrlImagem(documentID, partner, v);
    });
    return '';
  }

  static updateUrlImagem(String documentID, Partner partner, String value) async{
    partner.url_logo = value;
    Firestore.instance.collection("partner").document(documentID).updateData(partner.toJson());
  }
}