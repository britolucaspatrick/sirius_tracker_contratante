import 'package:flutter/material.dart';
import 'package:sirius_tracker_contratante/values/string.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatefulWidget {

  @override
  _AboutAppState createState() => new _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool validate = false;
  bool notifEnableServiceAppOff = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(15),
          child: new Form(
            key: _key,
            autovalidate: validate,
            child: buildScreen(context),
          ),
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context){
    return new Column(
      children: <Widget>[
        ListTile(
          title: Text(APP_NAME),
          subtitle: Text('v.$APP_VERSION'),
        ),
        Divider(
          height: 5,
          endIndent: 10,
          indent: 10,
        ),
        ListTile(
          title: Text('Avalie-nos no Google Play'),
        ),
        ListTile(
          title: Text('Linkedin'),
          onTap: () => _launchURL('https://www.linkedin.com/in/sirius-tracker-6736a7195/'),
        ),
        ListTile(
          title: Text('Youtube'),
        ),
        ListTile(
          title: Text('Facebook'),
          onTap: () => _launchURL('https://www.facebook.com/Sirius-Tracker-103697484378957/'),
        ),
        ListTile(
          title: Text('Twitter'),
        ),
        ListTile(
          title: Text('Visite nosso site'),
          onTap: () => _launchURL('http://siriustracker.com/'),
        ),
        ListTile(),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Erro ao iniciar: $url';
    }
  }

  String validateField(String value){
    if (value.length == 0){
      return "Informe campo!";
    }
    return "";
  }
}