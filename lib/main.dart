
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Backend/authentication.dart';
import 'Chooser.dart';
import 'Objeler/KullaniciObjesi.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return StreamProvider<KullaniciObjesi>.value(
            value: AuthService().user,
            child: MaterialApp(
              theme: ThemeData(
                backgroundColor: Colors.white,
                primaryColor: Color(0xFF15202B),
              ),
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Chooser(),
              ),
            ),
          );
        });
  }
}
