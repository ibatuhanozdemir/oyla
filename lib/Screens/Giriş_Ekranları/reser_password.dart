import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:emojis/emojis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oyla/Backend/authentication.dart';

import '../../chooser.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String _email = '', _password = '';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool loading = false;
  final GlobalKey<ScaffoldState> scKey = GlobalKey<ScaffoldState>();
  String snackBarText = "İşleminiz yapılıyor";
  User fbUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
        content: Text(snackBarText),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.red.shade900);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        key: scKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Şifre Sıfırlama'),
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

                      SizedBox(
                        height: MediaQuery.of(context).size.width*0.15,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(24))),
                        color: Colors.amber.shade400,
                        textColor: Colors.white,
                        onPressed: () async {
                          scKey.currentState.showSnackBar(snackBar);
                          await _authService.resetPassword(_email);
                          Duration(seconds: 2);



                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chooser()));

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${Emojis.key}"),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Şifre Sıfırla'),
                          ],
                        ),
                      ),





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
