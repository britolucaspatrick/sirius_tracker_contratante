import 'package:flutter/material.dart';

class Configuration extends StatefulWidget {

  @override
  _ConfigurationState createState() => new _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
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
        title: Text('Configuração'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Checkbox(
                value: notifEnableServiceAppOff,
                onChanged: (bool value) {
                  setState(() {
                    notifEnableServiceAppOff = value;
                  });
                },
              ),
              Expanded(
                child: Text("Receber serviços com app em \n"
                    "segundo plano ou fechado"),
              ),
            ],
          )
        ],
      )
    );
  }

}