import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oyla/Backend/authentication.dart';
import 'package:http/http.dart' as http;
import 'package:oyla/Objeler/KullaniciObjesi.dart';
import 'package:oyla/Screens/Kal%C4%B1pWidgetlar/Drawer.dart';
import 'package:oyla/Screens/Layers/layer_1.dart';
import 'package:oyla/Screens/Layers/custom_slider.dart';
import 'package:provider/provider.dart';

class AnaSayfa extends StatefulWidget {
  @override
  BuildContext context;

  AnaSayfa(this.context);

  _AnaSayfaState createState() => _AnaSayfaState(context);
}

class _AnaSayfaState extends State<AnaSayfa> {
  BuildContext context;

  _AnaSayfaState(this.context);
  double baslangic =0;
  List KategorilerListesi = [];
  List UserRatesList = [];
  List KontrolListesi=[];

  List ikonlarListesi = [
    "assignment",
    "assignment",
    "assignment",
    "assignment",
  ];
  List altKategoriChecker = ["1", "0", "1", "0"];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = Provider.of<KullaniciObjesi>(context);
    getData(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<KullaniciObjesi>(context);

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
                      children: [ KontrolListesi.contains(KategorilerListesi[index]['kategori_isim'])?
                      Text('güncelle'):
                        GestureDetector(
                          onTap: (){
                            showInformationDialog(context,user.uid,'kategoriler',KategorilerListesi[index]['kategori_isim'],KategorilerListesi[index]['rate_value'],KategorilerListesi[index]['total_num_of_rates']).then((_)=>

                                getData(user.uid));

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

  Future<void> showInformationDialog  (BuildContext context,String uid,String top_category_name,String rate_name,String rate_value,String total_num_of_rates) async {
    return await showDialog(
        context: context,
        builder: (context)  {
          return  CupertinoAlertDialog(
            content: CustomSlider(context, baslangic,uid,top_category_name,rate_name,rate_value,total_num_of_rates),
          );
        });
  }

  Future getData(String uid) async {
    var url = 'http://www.taybtu.com/oyla/GetMainCategory.php';
    http.Response response = await http.get(url);
    var url2 = 'http://www.taybtu.com/oyla/GetUserInfo.php?uid='+uid;
    http.Response response2 = await http.get(url2);
    setState(() {
      KategorilerListesi = jsonDecode(response.body);
      UserRatesList= jsonDecode(response2.body);

      UserRatesList.forEach((element) {
        KontrolListesi.add(element['rate_name']);});

      print(KontrolListesi.contains('sdfsdf'));
    });
  }




}
