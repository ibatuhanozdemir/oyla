
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class KalipDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Column(
            children: [
              _createHeader(),
              _createDrawerItem(text: "Neleri Takip Ediyorum?",onTap: (){
              }, icon: Icons.assignment)
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
          ),
          Column(
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                color: Colors.red,
                textColor: Colors.white,
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                },
                child: Text("${Emojis.door} Çıkış Yap"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                    "images/business-163464_1280.jpg"))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              right: 20,
              child: Text("Seçenekler",
                  style: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
