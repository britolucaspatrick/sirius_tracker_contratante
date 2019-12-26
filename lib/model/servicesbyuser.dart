import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesByUser{

  String userID;
  int Status;
  final double Valor;
  List<dynamic> UrlImagemVeiculo;
  final String MarkerID;
  final String Latitude;
  final String Longitude;
  final String InfoWindow;
  Timestamp Dt_abertura;
  Timestamp Dt_cancelamento;
  final String Description;
  String documentID;
  Timestamp Dt_inicioatendimento;
  Timestamp Dt_terminoatend;
  String clientUserID;
  String OperadorPartnerId;
  String PartnerId;

  String get Status_desc{
    if (Status == 0)
      return "Aberto";
    else if (Status == 1)
      return "Em atendimento";
    else if (Status == 2)
      return "Em pagamento";
    else if (Status == 3)
      return "Finalizado";
    else if (Status == 4)
      return "Cancelado";
  }

  ServicesByUser({
    this.userID,
    this.Status,
    this.Valor,
    this.UrlImagemVeiculo,
    this.MarkerID,
    this.Latitude,
    this.Longitude,
    this.InfoWindow,
    this.Dt_abertura,
    this.Description,
    this.documentID,
    this.Dt_inicioatendimento,
    this.Dt_terminoatend,
    this.clientUserID,
    this.OperadorPartnerId,
    this.PartnerId,
    this.Dt_cancelamento,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'Status': Status,
      'Valor': Valor,
      'UrlImagemVeiculo': UrlImagemVeiculo,
      'MarkerID': MarkerID,
      'Latitude': Latitude,
      'Longitude': Longitude,
      'InfoWindow': InfoWindow,
      'Dt_abertura': Dt_abertura,
      'Description': Description,
      'Dt_inicioatendimento': Dt_inicioatendimento,
      'Dt_terminoatend': Dt_terminoatend,
      'clientUserID': clientUserID,
      'OperadorPartnerId': OperadorPartnerId,
      'PartnerId': PartnerId,
      'Dt_cancelamento': Dt_cancelamento,
      'documentID': documentID,
    };
  }

  factory ServicesByUser.fromJson(Map<dynamic, dynamic> doc) {
    ServicesByUser service = new ServicesByUser(
      userID: doc['userID'],
      Status: doc['Status'],
      Valor: doc['Valor'],
      UrlImagemVeiculo: doc['UrlImagemVeiculo'],
      MarkerID: doc['MarkerID'],
      Latitude: doc['Latitude'],
      Longitude: doc['Longitude'],
      InfoWindow: doc['InfoWindow'],
      Dt_abertura: doc['Dt_abertura'],
      Description: doc['Description'],
      Dt_inicioatendimento: doc['Dt_inicioatendimento'],
      Dt_terminoatend: doc['Dt_terminoatend'],
      documentID: doc['documentID'],
      clientUserID: doc['clientUserID'],
      OperadorPartnerId: doc['OperadorPartnerId'],
      PartnerId: doc['PartnerId'],
      Dt_cancelamento: doc['Dt_cancelamento'],
    );
    return service;
  }

  factory ServicesByUser.fromDocument(DocumentSnapshot doc) {
    return ServicesByUser.fromJson(doc.data);
  }
}