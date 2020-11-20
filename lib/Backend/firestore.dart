
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oyla/Objeler/UserInfoObjesi.dart';

class Firestore {
  // collection reference
  final String uid;

  Firestore({this.uid});

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('Users');
  final CollectionReference userCollection1 =
  FirebaseFirestore.instance.collection('belediyeler');
  final CollectionReference userCollection2 =
  FirebaseFirestore.instance.collection('belediyelerinfo');

  Future updateUserData(String name, String surname, String age) async {
    try {
      return await userCollection.doc(uid).set({
        'name': name,
        'surname': surname,
        'age': age,
        'uid': uid,
        'follow': FieldValue.arrayUnion([]),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future update2UserData(String name, String surname, String age) async {
    try {
      return await userCollection.doc(uid).update({
        'name': name,
        'surname': surname,
        'age': age,
        'uid': uid,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  List<UserInfoObjesi> userfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInfoObjesi(
        name: doc.get('name'),
        surname: doc.get('surname'),
        age: doc.get('age'),
        uid: doc.get('uid'),
      );
    }).toList();
  }

  Stream<List<UserInfoObjesi>> get Users {
    return userCollection.snapshots().map(userfromsnapshot);
  }

  DocumentSnapshot usersfollow(DocumentSnapshot snapshot) {

    return snapshot;
  }

  Stream<DocumentSnapshot> get follow {
    return userCollection.doc(uid).snapshots().map(usersfollow);
  }






}