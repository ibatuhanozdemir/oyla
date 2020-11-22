import 'dart:convert';

import 'package:emojis/emojis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oyla/Backend/Kategoriler.dart';
import 'package:oyla/Backend/authentication.dart';
import 'package:http/http.dart' as http;
class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List KategorilerListesi=[];

  AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {

  return KategorilerListesi.isEmpty?

  Container():
  Scaffold(
      endDrawer: Drawer(child:RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24))),
        color: Colors.red,
        textColor: Colors.white,
        onPressed: (){
          FirebaseAuth.instance.signOut();
        },
        child: Text("${Emojis.door} Çıkış Yap"),
      )),
      appBar: AppBar(
        centerTitle: true,
        title: Text("deneme"),
      ),
      body: SafeArea(
        child: Center(
          child: ListView.builder(itemBuilder: (_, index){
            return Text(KategorilerListesi[index]['kategori_isim']) ;
          },
            itemCount: KategorilerListesi.length,
          ),
        ),
      ),
    );
  }
    Future getData() async{
      var url='http://www.taybtu.com/get.php';
      http.Response response = await http.get(url);
      setState(() {
        KategorilerListesi = jsonDecode(response.body);
        print(KategorilerListesi[2]['kategori_isim']);

      });




    }
}
