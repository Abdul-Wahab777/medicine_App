import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:medical_app/firebaseAuth.dart';
import 'package:sizer/sizer.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  FirebaseService service = FirebaseService();
  TextEditingController adminEml = TextEditingController();
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic id;
  dynamic ID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: Text(
        //   "Med Donor",
        //   style: TextStyle(color: Colors.white, fontSize: 15.sp),
        // ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NeumorphicText(
                "Admin Login",
                style: NeumorphicStyle(
                  shadowLightColor: Colors.blueGrey,
                  lightSource: LightSource.topRight,
                  depth: 3.5,
                  intensity: 5,
                  color: Colors.indigo[900],
                ),
                textStyle: NeumorphicTextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 8.h),
                child: Neumorphic(
                  style: NeumorphicStyle(
                      lightSource: LightSource.bottom,
                      oppositeShadowLightSource: true,
                      color: Colors.white,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(35.0)),
                      intensity: 10,
                      border: NeumorphicBorder(
                        color: Colors.white,
                        isEnabled: true,
                      )),
                  child: TextFormField(
                    controller: adminEml,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.person,
                            size: 3.h,
                            color: Colors.indigo[900],
                          ),
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Colors.indigo[900], fontSize: 14.h),
                        border: OutlineInputBorder(
                            // borderSide: BorderSide(color: Color(0xff1A237A)),
                            borderRadius: BorderRadius.circular(35))),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 6.h),
                width: MediaQuery.of(context).size.width,
                height: 3.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Color(0xff1A237A))),
                child: Text("$id"),
              ),
              Container(
                margin: EdgeInsets.only(top: 4.h, bottom: 3.5.h),
                width: 55.w,
                height: 7.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(10.0),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.greenAccent),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff1A237A)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ))),
                  onPressed: () {
                    // print(reference);
                    if (adminEml.text == service.currntEmail) {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 7),
                        content: const Text('Successfully login'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // print(ref);
                      FirebaseFirestore.instance
                          .collection('Admin')
                          .get()
                          .then((QuerySnapshot querySnapshot) {
                        querySnapshot.docs.forEach((doc) async {
                          setState(() {
                            id = doc["ID"];
                            print(doc["ID"]);
                          });
                        });
                      });
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('error'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
