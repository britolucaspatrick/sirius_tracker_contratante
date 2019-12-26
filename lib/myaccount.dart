import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:sirius_tracker_contratante/widget/alert.dart';
import 'business/auth.dart';
import 'model/user.dart';

class MyAccount extends StatefulWidget {
  final String userId;

  const MyAccount({Key key, this.userId}) : super(key: key);


  @override
  _MyAccountState createState() => new _MyAccountState(this.userId);
}

class _MyAccountState extends State<MyAccount> {
  final _formKey = GlobalKey<FormState>();
  bool validate = false;
  final String userId;

  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _cpf = new MaskedTextController(mask: '000.000.000-00');

  final GlobalKey<FormFieldState<String>> _passwordFieldKey = new GlobalKey<FormFieldState<String>>();
  String _password;

  _MyAccountState(this.userId);

  @override
  void initState() {
    super.initState();

    Auth.getUser(userId).forEach((f){
      setState(() {
        _name.text = f.firstName;
        _email.text = f.email;
        _cpf.text = f.cpf;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Minha conta'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 12),
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(Icons.person),
                  labelText: "Nome"
              ),
              controller: _name,
              enabled: false,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(Icons.email),
                  labelText: "E-mail"
              ),
              controller: _email,
              enabled: false,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(Icons.call_to_action),
                  labelText: "CPF"
              ),
              controller: _cpf,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Auth.addUser(new User(
                        userID: userId,
                        firstName: _name.text,
                        email: _email.text,
                        cpf: _cpf.text,
                    ));
                    Alert.showAlertDialog(context, "Salvo com sucesso");
                  }
                },
                child: Text('Salvar'),
              ),
            ),
          ],
        ),
      ),

    );
  }

  String validateField(String value){
    if (value.length == 0){
      return "Informe campo!";
    }
    return "";
  }
}