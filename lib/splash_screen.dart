import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirius_tracker_contratante/business/auth.dart';
import 'package:sirius_tracker_contratante/sign_in_screen.dart';
import 'package:sirius_tracker_contratante/widget/custom_alert_dialog.dart';
import 'myhomepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Auth.getCurrentFirebaseUser()
        .then((value){
      if (value != null){
        SharedPreferences.getInstance().then((pref){
          pref.setString('userID', value.uid);
          pref.setString('email', value.email);
          pref.setString('nome', value.displayName);
        });

        Future.delayed(Duration(seconds: 5)).then((v){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return MyHomePage(title: 'ST - Contratante');
              }));
        });
      }else{
        Future.delayed(Duration(seconds: 5)).then((v){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return SignInScreen();
              }));
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Image(image: AssetImage("assets/icon/app.gif"), height: 200.0, width: 200.0,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Center(
                        child: Text(
                          "Sirius Tracker p/ Contratantes",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        )
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}