import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/login/LoginMember.dart';
import 'package:medical_app/login/SigUpMem.dart';
import 'package:sizer/sizer.dart';


Color color = Colors.red;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuth auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (BuildContext context, orientation, devicetype) {
      return MaterialApp(
        title: 'Health App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        
        home:auth.currentUser!.email!=null? LoginMember():SignUpMeme(),
      );
    });
  }
}
