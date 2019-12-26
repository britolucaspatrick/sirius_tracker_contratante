import 'package:flutter/material.dart';
import 'package:sirius_tracker_contratante/business/contactbusiness.dart';
import 'package:sirius_tracker_contratante/model/contact.dart';
import 'package:sirius_tracker_contratante/widget/alert.dart';

class ContactScreen extends StatefulWidget{
 final String useID;

  const ContactScreen({Key key, this.useID}) : super(key: key);

  @override
  _ContactState createState() => new _ContactState();

}

class _ContactState extends State<ContactScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contato'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                height: 200,
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
                child: TextField(
                  controller: this._controller,
                  maxLength: 299,
                  maxLines: 30,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Informe o motivo do contato',
                    hintText: 'Digite algo...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                            color: Colors.black26
                        )
                    ),
                  ),
                  onChanged: (text) => setState((){}),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(
                            color: Colors.black12,
                            width: 100,
                          ),
                        ),
                        elevation: 5,
                        onPressed: (){
                          ContactBusiness.post(new Contact(userID: widget.useID, msg: this._controller.text, app: 1, st_atendimento: 0)).then((value){
                            this._controller.text = '';
                            Alert.showAlertDialog(context, 'Enviado com sucesso. Estaremos entrando em contato por e-mail.');
                          }).catchError((error){
                            Alert.showAlertDialog(context, 'Erro ao enviar.');
                          });
                        },
                        icon: Icon(
                          Icons.send,
                          size: 30,
                        ),
                        label: Text('Enviar',)
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}