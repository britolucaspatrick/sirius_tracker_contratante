import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sirius_tracker_contratante/model/servicesbyuser.dart';

class ServicesByUserBusiness{

  static Future<DocumentReference> post(ServicesByUser servicesByUser){
    servicesByUser.Status = 0;
    servicesByUser.Dt_abertura = Timestamp.now();
    return Firestore.instance.collection("servicesByUser").add(servicesByUser.toJson());
  }

  static Future<void> cancelService(ServicesByUser servicesByUser) {
    servicesByUser.Status = 4; //CANCELADO
    servicesByUser.Dt_cancelamento = Timestamp.now();
    return Firestore.instance.collection("servicesByUser").document(servicesByUser.documentID).updateData(servicesByUser.toJson());
  }

  static void updateDocumentId(String documentID, ServicesByUser servicesByUser, List<File> file){
    servicesByUser.documentID = documentID;
    servicesByUser.Status = 0;
    servicesByUser.Dt_abertura = Timestamp.now();
    Firestore.instance.collection("servicesByUser").document(documentID).updateData(servicesByUser.toJson());

    int i = 0;
    file.forEach((f){
      uploadFile(f, documentID, i, servicesByUser);
      i++;
    });
  }

  static uploadFile(File _image, String documentID, int i, ServicesByUser servicesByUser) async {
    String path = 'services/${documentID}/${i}';
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(path);
    StorageUploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((v){
      updateUrlImagemVeiculo(documentID, servicesByUser, v);
    });
  }

  static updateUrlImagemVeiculo(String documentID, ServicesByUser servicesByUser, String value) async{
    if (servicesByUser.UrlImagemVeiculo == null)
      servicesByUser.UrlImagemVeiculo = new List<String>();
    servicesByUser.UrlImagemVeiculo.add(value);
    Firestore.instance.collection("servicesByUser").document(documentID).updateData(servicesByUser.toJson());
  }

}