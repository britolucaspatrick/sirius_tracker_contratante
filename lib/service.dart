
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sirius_tracker_contratante/animations/move_animation.dart';
import 'package:sirius_tracker_contratante/business/servicesbuyserbusiness.dart';
import 'package:sirius_tracker_contratante/main.dart';
import 'package:sirius_tracker_contratante/model/servicesbyuser.dart';
import 'package:sirius_tracker_contratante/utils/functions.dart';
import 'package:sirius_tracker_contratante/widget/chat.dart';
import 'package:sirius_tracker_contratante/widget/custom_alert_dialog.dart';
import 'package:sirius_tracker_contratante/widget/nodata.dart';
import 'package:sirius_tracker_contratante/widget/question.dart';

class Services extends StatefulWidget {
  final userId;

  const Services({this.userId});

  @override
  _ServicesState createState() => new _ServicesState();
}

class _ServicesState extends State<Services> {
  List<ServicesByUser> listServicesByUser = new List();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Serviços'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              if (listServicesByUser.length > 0)
                Expanded(
                  child: ListView.builder(
                    itemBuilder: _buildServicesByUser,
                    itemCount: listServicesByUser.length,
                    scrollDirection: Axis.vertical,
                  ),
                )
              else
                NoData(labelText: 'Nenhum serviço!',)
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.find_replace),
        onPressed: (){
          _getServices(widget.userId);
        },
      ),
    );
  }

  Widget _buildServicesByUser(BuildContext context, int index) {
    return MoveAnimation(
      duration: Duration(seconds: 3),
      child: Container(
          padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Card(
              elevation: 3.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          listServicesByUser[index].InfoWindow,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Dt. Abertura: ${DateTime.fromMillisecondsSinceEpoch(listServicesByUser[index].Dt_abertura?.millisecondsSinceEpoch).day}/"
                              "${DateTime.fromMillisecondsSinceEpoch(listServicesByUser[index].Dt_abertura?.millisecondsSinceEpoch).month}/"
                              "${DateTime.fromMillisecondsSinceEpoch(listServicesByUser[index].Dt_abertura?.millisecondsSinceEpoch).year} "
                              "\u00B7 "
                              "${DateTime.fromMillisecondsSinceEpoch(listServicesByUser[index].Dt_abertura?.millisecondsSinceEpoch).hour}:"
                              "${DateTime.fromMillisecondsSinceEpoch(listServicesByUser[index].Dt_abertura?.millisecondsSinceEpoch).minute}",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Latitude: ${listServicesByUser[index].Latitude} Longitude: ${listServicesByUser[index].Longitude}',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Valor: R${Functions.formatDoubleToMoney(listServicesByUser[index].Valor)}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        Text(
                          "Status: ${(listServicesByUser[index].Status_desc)}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      children: <Widget>[
                        if (listServicesByUser[index].Status == 1)
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: RaisedButton.icon(
                              onPressed: (){
                                _callChat(listServicesByUser[index]);
                              },
                              icon: Icon(Icons.chat),
                              color: Colors.white,
                              label: Text("Chat"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black54)
                              ),
                            ),
                          ),
                        if (listServicesByUser[index].Status == 0)  //CANCELAR
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: RaisedButton.icon(
                              onPressed: (){
                                Question(onPressed: (){
                                  ServicesByUserBusiness.cancelService(listServicesByUser[index]);
                                  _getServices(widget.userId);
                                }).showAlertDialog(context, 'Confirma o cancelamento do serviço?');
                              },
                              icon: Icon(Icons.chat, color: Colors.white,),
                              color: Colors.red,
                              label: Text("Cancelar", style: TextStyle(color: Colors.white),),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }

  void _getServices(String userID) async{
    setState(() {
      listServicesByUser.clear();
    });
    await Firestore.instance
        .collection("servicesByUser")
        .where("OperadorPartnerId", isEqualTo: userID)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((f) {
        setState(() {
          f.data["documentID"] = f.documentID;
          listServicesByUser.add(ServicesByUser.fromJson(f.data));
        });
      });
    });
  }

  void _callChat(ServicesByUser servicesByUser) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        Chat(service: servicesByUser)));
  }

  /*void _callCracha(ServicesByUser servicesByUser) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        Cracha(service: servicesByUser)));
  }

  void _callPayment(ServicesByUser servicesByUser) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        Payment(service: servicesByUser)));
  }*/
}