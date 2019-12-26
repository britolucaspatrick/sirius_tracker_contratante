import 'dart:io';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirius_tracker_contratante/aboutApp.dart';
import 'package:sirius_tracker_contratante/business/auth.dart';
import 'package:sirius_tracker_contratante/business/servicesbuyserbusiness.dart';
import 'package:sirius_tracker_contratante/configuration.dart';
import 'package:sirius_tracker_contratante/contactscreen.dart';
import 'package:sirius_tracker_contratante/myaccount.dart';
import 'package:sirius_tracker_contratante/sign_in_screen.dart';
import 'package:sirius_tracker_contratante/widget/alert.dart';
import 'package:sirius_tracker_contratante/widget/question.dart';
import 'model/servicesbyuser.dart';
import 'service.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {
  List<File> _image = new List<File>();
  var _formKey = GlobalKey<FormState>();
  TextEditingController _descricao = new TextEditingController();
  TextEditingController _titulo = new TextEditingController();
  TextEditingController _latitude = new MaskedTextController(mask: '-00.000000');
  TextEditingController _longitude = new MaskedTextController(mask: '-00.000000');
  TextEditingController _valor = new TextEditingController();
  String uid;
  String email;
  String nome;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((pref){
      uid = pref.get('userID');
      email = pref.get('email');
      nome = pref.get('nome');

      setState(() {
        email;
        nome;
        uid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(nome == null ? '' : nome),
                accountEmail: Text(email == null ? '' : email),
                currentAccountPicture: Image(image: AssetImage("assets/images/default.png"), height: 35.0),
              ),
              ListTile(
                title: Text('Serviços'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      Services(userId: uid,)));
                },
              ),
              ListTile(
                title: Text('Dados pessoais'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      MyAccount(userId: uid)));
                },
              ),
              ListTile(
                title: Text('Configuração'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      Configuration()));
                },
              ),
              ListTile(
                title: Text('Sobre'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      AboutApp()));
                },
              ),
              ListTile(
                title: Text('Contato'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ContactScreen(useID: uid)));
                },
              ),
              ListTile(
                title: Text('Sair'),
                onTap: (){
                  _logOut(context);
                },
              ),
            ],
          )
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 10, right: 10),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    labelText: "Titulo"
                ),
                controller: _titulo,
                maxLength: 20,
                maxLines: 1,
                validator: (value){
                  if (value == null || value.isEmpty)
                    return 'Obrigatório informar título';
                  else if (value.length < 3)
                    return 'Mínimo 3 caracteres';
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    labelText: "Descrição"
                ),
                controller: _descricao,
                maxLength: 299,
                validator: (value){
                  if (value == null || value.isEmpty)
                    return 'Obrigatório informar descrição';
                  else if (value.length < 15)
                    return 'Mínimo 15 caracteres';
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    labelText: "Latitude"
                ),
                controller: _latitude,
                validator: (value){
                  if (value == null || value.isEmpty)
                    return 'Obrigatório informar latitude';
                  else if (value.length != 10)
                    return 'Latitude inválida';
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    labelText: "Longitude"
                ),
                controller: _longitude,
                validator: (value){
                  if (value == null || value.isEmpty)
                    return 'Obrigatório informar longitude';
                  else if (value.length != 10)
                    return 'Longitude inválida';
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    prefixText: 'R\$ ',
                    labelText: "Valor"
                ),
                controller: _valor,
                maxLines: 1,
                validator: (value){
                  if (value == null || value.isEmpty)
                    return 'Informe valor';
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                  'Anexar imagens'
              ),
            ),

            Row(
              children: <Widget>[
                Container(
                  width: 65,
                  height: 65,
                  child: Card(
                    elevation: 3.0,
                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    child:Center(
                      child: Text('${_image == null ? 0 : _image.length}', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Adicionar'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  onPressed: chooseFile,
                ),
                SizedBox(height: 5.0, width: 5.0,),
                RaisedButton(
                  child: Text('Limpar'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  onPressed: (){
                    setState(() {
                      _image.clear();
                    });
                  },
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: Text('Cancelar', style: TextStyle(color: Colors.white),),
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    onPressed: _question,
                  ),
                ),
                SizedBox(height: 5.0, width: 5.0,),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    child: Text('Enviar', style: TextStyle(color: Colors.white),),
                    color: Colors.lightGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    onPressed: (){
                      if (_image == null ||_image.length == 0){
                        Toast.show("Obrigatório pelo menos uma imagem", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                      }
                      else if (_formKey.currentState.validate() && _image.length > 0){
                        ServicesByUserBusiness.post(new ServicesByUser(
                            InfoWindow: _titulo.text,
                            Description: _descricao.text,
                            Latitude: _latitude.text,
                            Longitude: _longitude.text,
                            Valor: double.parse(_valor.text),
                            OperadorPartnerId: uid
                        )).then((value){
                          Alert.showAlertDialog(context, 'Salvo com sucesso');
                          ServicesByUserBusiness.updateDocumentId(value.documentID, new ServicesByUser(
                              InfoWindow: _titulo.text,
                              Description: _descricao.text,
                              Latitude: _latitude.text,
                              Longitude: _longitude.text,
                              Valor: double.parse(_valor.text),
                              OperadorPartnerId: uid
                          ), _image);
                          _titulo.text = '';
                          _descricao.text = '';
                          _latitude.text = '';
                          _longitude.text = '';
                          _valor.text = '';
                          _image.clear();
                        }).catchError((v){
                          Alert.showAlertDialog(context, 'Erro ao salvar');
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _logOut(BuildContext context) async {
    SharedPreferences.getInstance().then((prefs) {
      Auth.signOut();
      //Auth.signOutGoogle();
      prefs.setString('userID', "");
      prefs.setString('email', "");
      prefs.setString('nome', "");

      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          SignInScreen()));
    });
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image.add(image);
      });
    });
  }

  void _question() {
    Question(onPressed: (){
      setState(() {
        _titulo.clear();
        _descricao.clear();
        _latitude.clear();
        _longitude.clear();
        _valor.clear();
        _image.clear();
      });
    }).showAlertDialog(context, 'Confirma o cancelamento do serviço?');
  }
}