import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oyla/Backend/authentication.dart';
import 'package:http/http.dart' as http;
import 'package:oyla/Screens/Kal%C4%B1pWidgetlar/Drawer.dart';
import 'package:oyla/Screens/Layers/layer_1.dart';
import 'package:oyla/Screens/Layers/custom_slider.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  double baslangic =0;
  List KategorilerListesi = [];
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
    getData();
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
            itemExtent: MediaQuery.of(context).size.width / 6,
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
                        Text(KategorilerListesi[index]['rate_value']),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.assignment),
                        Text(KategorilerListesi[index]['kategori_isim']),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showInformationDialog(context);
                          },
                          child: Text(
                            "Oy ver",
                            style: TextStyle(color: Colors.blue.shade700),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        KategorilerListesi[index]['sub_category_exist'] == "1"
                            ? GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Layer1(KategorilerListesi[index]['kategori_isim'])));
                              },
                              child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.red,
                                  size: 20,
                                ),
                            )
                            : Icon(
                                Icons.arrow_forward,
                                color: Colors.black26,
                                size: 20,
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

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: CustomSlider(context, baslangic),
          );
        });
  }

  Future getData() async {
    var url = 'http://www.taybtu.com/oyla/GetMainCategory.php';
    http.Response response = await http.get(url);
    setState(() {
      KategorilerListesi = jsonDecode(response.body);
      print(KategorilerListesi);
    });
  }


}
