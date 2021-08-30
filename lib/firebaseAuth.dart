import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseService{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  var userid;
  CollectionReference reference =
      FirebaseFirestore.instance.collection("userInfo");
    
 

  Future login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
    } catch (e) {print(e);}
  }
  String? currntEmail= FirebaseAuth.instance.currentUser!.email;
  
}
