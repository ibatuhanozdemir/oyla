
import 'package:animated_text_kit/animated_text_kit.dart';
import 'Login.dart';

import 'package:emojis/emojis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Register.dart';


class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: TypewriterAnimatedTextKit(
          isRepeatingAnimation: false,
          text: ["OYLA"],
          speed: Duration(milliseconds: 200),
          textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //Image(image:  AssetImage("images/giris.gif")),
              SizedBox(height: 40,),
              SizedBox(
                height: 48,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("${Emojis.unlocked}"),
                      Text(
                        'Giriş Yap',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Opacity(opacity: 0, child: Icon(Icons.assignment_ind)),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 48,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("${Emojis.writingHand}"),
                      Text(
                        'Kayıt Ol',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Opacity(opacity: 0, child: Icon(Icons.assignment_ind)),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
