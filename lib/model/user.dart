import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String bairro;
  final String cep;
  final String cidade;
  final String complement;
  final String cpf;
  final String logradouro;
  final String userID;
  final String firstName;
  final String email;
  final String profilePictureURL;
  final String providerId;
  final String number;
  final String numero;
  final int st_cnh; //0 - Aguardando envio 1 - Imagem inválida 2 - Imagem válida

  User({
    this.bairro,
    this.cep,
    this.cidade,
    this.complement,
    this.cpf,
    this.logradouro,
    this.userID,
    this.firstName,
    this.email,
    this.profilePictureURL,
    this.providerId,
    this.number,
    this.numero,
    this.st_cnh
  });

  Map<String, Object> toJson() {
    return {
      'bairro' : bairro,
      'cep' : cep,
      'cidade' : cidade,
      'complement' : complement,
      'cpf' : cpf,
      'logradouro' : logradouro,
      'userID': userID,
      'firstName': firstName,
      'email': email,
      'profilePictureURL': profilePictureURL,
      'number': number,
      'numero': numero,
      'st_cnh': st_cnh,
    };
  }

  factory User.fromJson(Map<String, Object> doc) {
    User user = new User(
      bairro: doc['bairro'],
      cep: doc['cep'],
      cidade: doc['cidade'],
      complement: doc['complement'],
      cpf: doc['cpf'],
      logradouro: doc['logradouro'],
      userID: doc['userID'],
      firstName: doc['firstName'],
      email: doc['email'],
      number: doc['number'],
      profilePictureURL: doc['profilePictureURL'],
      st_cnh : doc['st_cnh'],
    );
    return user;
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}
