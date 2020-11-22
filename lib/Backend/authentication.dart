import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oyla/Backend/firestore.dart';
import 'package:oyla/Objeler/KullaniciObjesi.dart';
import 'package:http/http.dart' as http;
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object
  KullaniciObjesi _userFromFirebaseUser(User user) {
    return user != null ? KullaniciObjesi(uid: user.uid) : null;
  }

  // Auth change
  Stream<KullaniciObjesi> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Register
  Future registerWithEmailandPassword(String email, String password,
      String name, String surname, String age) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user;
      await Firestore(uid: user.uid).updateUserData(name, surname, age);
      var url='http://www.taybtu.com/deneme.php?uid='+user.uid+'&isim='+name+'&soyisim='+surname+'&yas='+age;
      http.Response response = await http.get(url);

      user.sendEmailVerification();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Login
  Future loginWithEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Logout
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
