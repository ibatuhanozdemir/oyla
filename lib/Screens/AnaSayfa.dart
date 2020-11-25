import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oyla/Backend/authentication.dart';
import 'package:http/http.dart' as http;
import 'package:oyla/Screens/Kal%C4%B1pWidgetlar/Drawer.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List KategorilerListesi = [
    "Ürünler",
    "Kişiler",
    "Yerler",
    "Düşünceler",
  ];
  List ikonlarListesi = [
    "assignment",
    "assignment",
    "assignment",
    "assignment",
  ];
  List altKategoriChecker = ["1", "0", "1", "0"];

  AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: KalipDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Ana Kategoriler"),
      ),
      body: SafeArea(
        child: Center(
          child: ListView.builder(
            itemBuilder: (_, index) {
              return Card(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("100"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.assignment),
                        Text(KategorilerListesi[index]),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Oy ver",style: TextStyle(color: Colors.blue.shade700),),
                        SizedBox(
                          width: 20,
                        ),
                        altKategoriChecker[index] == "1"
                            ? Icon(
                                Icons.arrow_drop_down,
                                color: Colors.red,
                                size: 30,
                              )
                            : Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black26,
                                size: 30,
                              ),
                      ],
                    ),
                  ],
                ),
              ));
            },
            itemCount: KategorilerListesi.length,
          ),
        ),
      ),
    );
  }

/*
  Future getData() async {
    var url = 'http://www.taybtu.com/get.php?isim=ali';
    http.Response response = await http.get(url);
    setState(() {
      KategorilerListesi = jsonDecode(response.body);
      print(KategorilerListesi[2]['kategori_isim']);
    });
  }
  */

}
