import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirius_tracker_contratante/business/auth.dart';
import 'package:sirius_tracker_contratante/business/validator.dart';
import 'package:sirius_tracker_contratante/myhomepage.dart';
import 'package:sirius_tracker_contratante/sign_up_screen.dart';
import 'package:sirius_tracker_contratante/widget/custom_alert_dialog.dart';
import 'package:sirius_tracker_contratante/widget/custom_flat_button.dart';
import 'package:sirius_tracker_contratante/widget/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  CustomTextField _emailField;
  CustomTextField _passwordField;

  @override
  void initState() {
    super.initState();

    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _email,
      hint: "E-mail",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );
    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _password,
      obscureText: true,
      hint: "Senha",
      validator: Validator.validatePassword,
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((id){
          SharedPreferences.getInstance().then((prefs){
            prefs.setString('userID', id);
          });
        }).catchError((er){
          print(er);
          _showErrorAlert(title: 'Erro', content: er.toString());
        }).whenComplete(() =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return MyHomePage(title: 'ST - Contratante');
              }
        )));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /*Widget _signInButtonFacebook() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(duration: new Duration(seconds: 4), content:
            new Row(
              children: <Widget>[
                new CircularProgressIndicator(),
                new Text("  Entrando...")
              ],
            ),
            ));
        signInWithFacebook().then((id){
          SharedPreferences.getInstance().then((prefs){
            prefs.setString('userID', id);
          });
        }).catchError((er){
          _showErrorAlert(title: 'Erro', content: er.toString());
        }).whenComplete(() => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return HomePage();
            }
        )));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/facebook_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Facebook',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                    child: Text(
                      "Entrar",
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(212, 20, 15, 1.0),
                        decoration: TextDecoration.none,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 10.0, left: 15.0, right: 15.0),
                    child: _emailField,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 20.0, left: 15.0, right: 15.0),
                    child: _passwordField,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          CustomFlatButton(
                            title: "Cadastrar",
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  SignUpScreen()));
                            },
                            splashColor: Colors.black12,
                            borderColor: Colors.white,
                            borderWidth: 0,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 10.0, left: 15.0, right: 15.0),
                      ),
                      Column(
                        children: <Widget>[
                          CustomFlatButton(
                            title: "Entrar",
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                            onPressed: () {
                              _emailLogin(email: _email.text, password: _password.text, context: context)
                                  .then((value){
                                if (value != null){
                                  print(value);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return MyHomePage(title: 'ST - Contratante',);}));
                                }
                              });
                            },
                            splashColor: Colors.black12,
                            borderColor: Color.fromRGBO(212, 20, 15, 1.0),
                            borderWidth: 0,
                            color: Color.fromRGBO(212, 20, 15, 1.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "OU",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _signInButtonFacebook(),
                      ],
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _signInButton(),
                      ],
                    ),
                  ),
                ],
              ),
              /*SafeArea(
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: onBackPress,
                ),
              ),*/
            ],
          ),
          Offstage(
            offstage: true,
            child: GestureDetector(
              onTap: () {},
              child: AnimatedOpacity(
                opacity: true ? 1.0 : 0.0,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult retur = await _auth.signInWithCredential(credential);
    final FirebaseUser user = retur.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user.uid;
  }

  /*void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
  }*/

  /*Future<FirebaseUser> _handleSignIn() async {
    var _googleSignIn;
    var _auth;

    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + user.displayName);
    return user;
  }*/

  Future<String> _emailLogin( {String email, String password, BuildContext context}) async {
    if (Validator.validateEmail(email) &&
        Validator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        String id = await Auth.signIn(email, password);
        SharedPreferences.getInstance().then((prefs){
          prefs.setString('userID', id);
        });
        return id;
      } catch (e) {
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Login falhou",
          content: exception,
          onPressed: (){
          },
        );
      }
    }
  }

  /*Future<String> signInWithFacebook({BuildContext context}) async {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      final facebookLogin = FacebookLogin();
      final result = await facebookLogin.logInWithReadPermissions(['email']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          break;
        case FacebookLoginStatus.cancelledByUser:
          break;
        case FacebookLoginStatus.error:
          break;
      }
    } catch (e) {
      print("Error in facebook sign in: $e");
      String exception = Auth.getExceptionText(e);
      _showErrorAlert(
        title: "Login failed",
        content: exception,
        //onPressed: _changeBlackVisible,
      );
    }
  }*/

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }

}
