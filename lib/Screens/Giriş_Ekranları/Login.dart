import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart';
import 'package:oyla/Backend/authentication.dart';
import 'package:oyla/Screens/Giri%C5%9F_Ekranlar%C4%B1/reser_password.dart';

import '../../Chooser.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String _email = '', _password = '';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool loading = false;
  final GlobalKey<ScaffoldState> scKey = GlobalKey<ScaffoldState>();
  String snackBarText = "Şifre yanlış ya da mail adresiniz doğrulanmamış";
  User fbUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
        content: Text(snackBarText),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.shade900);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        key: scKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Giriş'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Form(
                key: _formkey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (input) {
                            setState(() => _email = input);
                          },
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (input) {
                            setState(() => _password = input);
                          },
                          decoration: InputDecoration(labelText: 'Şifre'),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.3,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () async {
                          setState(() => loading = true);
                          dynamic result = await _authService
                              .loginWithEmailandPassword(_email, _password);

                          if (result == null) {
                            setState(() => loading = false);
                            scKey.currentState.showSnackBar(snackBar);
                            print('error');
                          } else {
                            print('sign in');
                            setState(() => loading = false);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Chooser()));
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${Emojis.unlocked}"),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Giriş'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Şifrenizi mi unuttunuz?",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF15202B)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        color: Colors.amber.shade400,
                        textColor: Colors.white,
                        onPressed: () async {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${Emojis.key}"),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Şifremi Sıfırla'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hesabınız yok mu? Şimdi kaydolun.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF15202B)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${Emojis.writingHand}"),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Kayıt ol"),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeAnimatedTextKit(
                            text: ["${Emojis.warning}"],
                            textStyle: TextStyle(fontSize: 20),
                            repeatForever: true,
                          ),
                          FadeAnimatedTextKit(
                            text: [
                              "Hesabınızı doğrulamadan giriş yapamazsınız"
                            ],
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                backgroundColor: Colors.red.shade900,
                                decorationStyle: TextDecorationStyle.solid),
                            repeatForever: true,
                          ),
                          FadeAnimatedTextKit(
                            text: ["${Emojis.warning}"],
                            textStyle: TextStyle(fontSize: 20),
                            repeatForever: true,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
