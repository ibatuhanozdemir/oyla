import 'package:flutter/material.dart';
import 'package:oyla/Backend/authentication.dart';

class AnaSayfa extends StatelessWidget {

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      endDrawer: Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("deneme"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: RaisedButton(
                  child: Text("sign out"),
                  onPressed: (){
                    authService.signOut();
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
