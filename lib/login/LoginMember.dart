import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical_app/bottomBarUser.dart';
import 'package:medical_app/login/SigUpMem.dart';
import 'package:medical_app/login/resetpassword.dart';
import 'package:medical_app/main_page.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LoginMember extends StatefulWidget {
  @override
  _LoginMemberState createState() => _LoginMemberState();
}

class _LoginMemberState extends State<LoginMember> {
  // FirebaseService service = FirebaseService();
  FirebaseAuth? auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  var boolmail = false;
  var boolpass = false;

  FirebaseStorage? storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();
  Uint8List? imageBytes;

  String? errorMsg;
  Future getPic(BuildContext context) async {
    storage!
        .ref()
        .child('profile_photo/${auth!.currentUser!.uid}')
        .getData(10000000)
        .then((data) => setState(() {
              imageBytes = data;
            }))
        .catchError((e) => setState(() {
              errorMsg = e.error;
            }));
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    pass.dispose();
  }

  @override
  void initState() {
    super.initState();
    getPic(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: imageBytes != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(imageBytes!),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 5.h),
                  child: Neumorphic(
                    style: boolmail == false
                        ? NeumorphicStyle(
                            oppositeShadowLightSource: true,
                            color: Colors.white,
                            shape: NeumorphicShape.flat,
                            lightSource: LightSource.bottom,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(35.0)),
                            intensity: 10,
                            border: NeumorphicBorder(
                              color: Colors.white,
                              isEnabled: true,
                            ),
                          )
                        : null,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.isEmpty) {
                          setState(() {
                            boolmail = true;
                          });
                          return 'mail is not empty';
                        } else {
                          setState(() {
                            boolmail = false;
                          });
                        }
                      },
                      controller: email,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.person,
                              size: 3.5.h,
                              color: Colors.indigo[900],
                            ),
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Colors.indigo[900], fontSize: 14.sp),
                          border: boolmail == false
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                )
                              : null),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 5.h),
                  child: Neumorphic(
                    style: boolpass == false
                        ? NeumorphicStyle(
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
                            ))
                        : null,
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          setState(() {
                            boolpass = true;
                          });
                          return 'Password is not empty';
                        } else if (val.length < 6) {
                          setState(() {
                            boolpass = true;
                          });
                          return "Password length must be greater than six letter ";
                        } else if (val.length > 15) {
                          setState(() {
                            boolpass = true;
                          });
                          return "Password length must be lesser than 15 letter";
                        } else {
                          setState(() {
                            boolpass = false;
                          });
                        }
                      },
                      controller: pass,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[900],
                          fontSize: 14.sp),
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Icon(
                              Icons.lock,
                              size: 3.h,
                              color: Colors.indigo[900],
                            ),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.indigo[900], fontSize: 14.sp),
                          border: boolpass == false
                              ? OutlineInputBorder(
                                  // borderSide: BorderSide(color: Color(0xff1A237A)
                                  // ),
                                  borderRadius: BorderRadius.circular(35.0))
                              : null),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResetPassword()));
                    },
                    child: Text(
                      "Forget Password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2.h, bottom: 1.5.h),
                  width: 50.w,
                  height: 7.h,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(10.0),
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.greenAccent),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff1A237A)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    child: Text(
                      "LogIn",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account?",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpMeme()));
                      },
                      child: Text(
                        "Sign up here",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future login() async {
    try {
      auth!
          .signInWithEmailAndPassword(email: email.text, password: pass.text)
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AliMola(),
          ),
        );
      }).catchError((onError) {
        if (onError.code == 'user-not-found') {
          toastMsg("User is not exist, please signIn");
        } else if (onError.code == 'wrong-password') {
          toastMsg("Wrong Password");
        } else {
          toastMsg('Check e-mail formate');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  toastMsg(msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
