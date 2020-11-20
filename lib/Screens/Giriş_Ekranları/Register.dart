import 'package:oyla/Backend/authentication.dart';

import 'Login.dart';

import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _email = '', _password = '', _name = '', _surname = '';
  String _age = '';
  String snackBarText = "Lütfen girdiğiniz bilgileri kontrol edin.";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final GlobalKey<ScaffoldState> scKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red.shade900,
      content: Text(snackBarText),
      duration: Duration(seconds: 2),
    );
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        key: scKey,
        appBar: AppBar(
          title: Text('Kayıt'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      onChanged: (input) {
                        input.trim();
                        setState(() => _email = input);
                        snackBarArranger();
                      },
                      decoration: InputDecoration(labelText: 'Email',),
                    ),
                    TextFormField(
                      onChanged: (input) {
                        input.trim();
                        setState(() => _password = input);
                        snackBarArranger();
                      },
                      decoration: InputDecoration(labelText: 'Şifre'),
                      obscureText: true,
                    ),
                    TextFormField(
                      onChanged: (input) {
                        input.trim();
                        setState(() => _name = input);
                        snackBarArranger();
                      },
                      decoration: InputDecoration(labelText: 'İsim'),
                    ),
                    TextFormField(
                      onChanged: (input) {
                        input.trim();
                        setState(() => _surname = input);
                        snackBarArranger();
                      },
                      decoration: InputDecoration(labelText: 'Soyisim'),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (input) {
                        input.trim();
                        setState(() => _age = input);
                        snackBarArranger();
                      },
                      decoration: InputDecoration(labelText: 'Yaş'),
                    ),
                    SizedBox(height: 15,),
                    RaisedButton(
                      onPressed: () async {
                        if (_name.length < 3 ||
                            _surname.length < 3 ||
                            int.tryParse(_age) <= 7 ||
                            int.tryParse(_age) >= 100) {
                          scKey.currentState.showSnackBar(snackBar);
                        } else {
                          dynamic result =
                          await _authService.registerWithEmailandPassword(
                              _email, _password, _name, _surname, _age);
                          if (result == null) {
                            snackBarText = "Bu mail adresi ile kayıtlı bir hesap mevcut.";
                            setState(() {
                            });
                            scKey.currentState.showSnackBar(snackBar);
                            print('error');
                          } else {
                            scKey.currentState.showSnackBar(snackBar);
                            print('sign in');
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Login()));
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${Emojis.checkBoxWithCheck}"),
                          SizedBox(width: 10,),
                          Text('Kaydı Tamamla'),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  snackBarArranger() {
    setState(() {});
    if (_email.length < 3 || !_email.contains("@")) {
      setState(() {
        snackBarText = "Lütfen geçerli bir mail adresi giriniz";
      });
    } else if (_password.length < 6) {
      setState(() {
        snackBarText = "Lütfen 5 karakterden uzun bir şifre belirleyin.";
      });
    } else if (_name.length < 2) {
      setState(() {
        snackBarText = "Lütfen geçerli bir isim giriniz";
      });
    } else if (_surname.length < 3) {
      setState(() {
        snackBarText = "Lütfen geçerli bir soyisim giriniz";
      });
    } else if (_age.contains(" ") ||
        _age.contains(",") ||
        _age.contains(".") ||
        _age.contains("-") ||
        _age.startsWith("0") ||
        _age.isEmpty ||
        _age.length < 2 ||
        _age.length > 2 ||
        _age.contains(new RegExp(r'[A-Z]'))) {
      setState(() {
        snackBarText = "Lütfen geçerli bir yaş giriniz";
      });
    } else {
      setState(() {
        snackBarText = "Lütfen size gelen mailden hesabınızı doğrulayın.";
      });
    }
  }
}
