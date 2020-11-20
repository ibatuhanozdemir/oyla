
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Objeler/KullaniciObjesi.dart';
import 'Screens/AnaSayfa.dart';
import 'Screens/Giriş_Ekranları/LoginRegister.dart';



class Chooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<KullaniciObjesi>(context);
    User fbUser = FirebaseAuth.instance.currentUser;

    if (user == null || fbUser.emailVerified == false) {

      return LoginRegister();
    } else {

      return AnaSayfa();

    }
  }
}