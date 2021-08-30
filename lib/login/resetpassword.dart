import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical_app/login/LoginMember.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  FirebaseAuth? auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  dialoge(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            backgroundColor: Colors.indigo[900],
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            title: Text(
              'Go Your Mail Box And Reset Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  try {
                    var user = auth!
                        .sendPasswordResetEmail(email: email.text)
                        .then((value) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (contex) => LoginMember(),
                        ),
                      );
                    }).catchError((onError) {
                     toatMsg('Enter valid e-mail');
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
toatMsg( var msg){
return  Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
}
  final _formKey = GlobalKey<FormState>();
  var boolmail = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                NeumorphicText(
                  "Reset Password",
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        dialoge(context);
                      }
                    },
                    child: Text(
                      "Reset password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Back To Login",
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
      ),
    );
  }
}
