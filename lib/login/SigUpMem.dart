import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app/chatSc/chat_message.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical_app/login/LoginMember.dart';
import 'package:medical_app/main.dart';
import 'package:sizer/sizer.dart';

class SignUpMeme extends StatefulWidget {
  @override
  _SignUpMemeState createState() => _SignUpMemeState();
}

class _SignUpMemeState extends State<SignUpMeme> {
  var nameU;
  var emaiU;
  var passu;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  FirebaseAuth? auth = FirebaseAuth.instance;
  CollectionReference? reference =
      FirebaseFirestore.instance.collection("userInfo");
  var userid;
  var boolname = false;
  var boolpass = false;
  var boolmail = false;
  var boolConfermPass = false;
  final _formKey = GlobalKey<FormState>();

  XFile? _image;
  XFile? _camra;
  final _picker = ImagePicker();

  String? retrieveDataError;

  imgFromGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type != null) {
          setState(() {
            _image = response.file!;
          });
        } else {
          retrieveDataError = response.exception!.code;
        }
      });
    }
  }

  Future uploadPic(BuildContext context) async {
    String fileName = _image!.path;
    final filename2 = File(_image!.path);
    try {
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("profile_photo/${auth!.currentUser!.uid}");
      UploadTask uploadTask = firebaseStorageRef.putFile(filename2);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
        print("image is send");
      });

      setState(() {
        print("Profile Picture uploaded");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile Picture Uploaded'),
          ),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  Future SignIn() async {}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SignIn();
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    pass.dispose();
    cpass.dispose();
    email.dispose();
  }

  toatMsg(var msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    // print("data is"+data.toString());
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Fluttertoast.showToast(
      //         msg: "Arhamsarwar",
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.TOP,
      //         backgroundColor: Colors.red,
      //         textColor: Colors.white,
      //         fontSize: 16.0);
      //   },
      // ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.indigo[900],
            )),
        // backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: _image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(_image!.path)),
                        )
                      : Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.camera,
                                size: 30.sp,
                                color: Colors.indigo[900],
                              ),
                              onPressed: () {
                                imgFromGallery();
                              }),
                        ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.h),
                  child: Neumorphic(
                    style: boolname == false
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
                      onChanged: (val1) {
                        nameU = val1;
                      },
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: name,
                      textAlignVertical: TextAlignVertical.bottom,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            boolname = true;
                          });
                          return "Name is Empty";
                        } else if (value.length < 3) {
                          setState(() {
                            boolname = true;
                          });
                          return 'Name must be more than 2 charater';
                        } else {
                          setState(() {
                            boolname = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Icon(
                            Icons.person,
                            size: 3.h,
                            color: Colors.indigo[900],
                          ),
                        ),
                        hintText: "Name",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.indigo[900],
                        ),
                        border: boolname == false
                            ? OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35))
                            : null,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 4.5.h),
                  child: Neumorphic(
                    style: boolmail == false
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
                      keyboardType: TextInputType.emailAddress,
                      validator: (mail) {
                        if (mail!.isEmpty) {
                          setState(() {
                            boolmail = true;
                          });
                          return "Email is not null";
                        } else {
                          setState(() {
                            boolmail = false;
                          });
                        }
                      },
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: email,
                      onChanged: (val2) {
                        emaiU = val2;
                      },
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.email,
                              size: 3.h,
                              color: Colors.indigo[900],
                            ),
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.indigo[900],
                          ),
                          border: boolmail == false
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35))
                              : null),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 4.5.h),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            boolpass = true;
                          });
                          return 'Password is not empty';
                        } else if (value.length < 6) {
                          setState(() {
                            boolpass = true;
                          });
                          return "Password length must be greater than six letter ";
                        } else if (value.length > 15) {
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
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pass,
                      onChanged: (val3) {
                        passu = val3;
                      },
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Icon(
                              Icons.lock,
                              size: 3.h,
                              color: Colors.indigo[900],
                            ),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.indigo[900],
                          ),
                          border: boolpass == false
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35))
                              : null),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 4.5.h),
                  child: Neumorphic(
                    style: boolConfermPass == false
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
                            boolConfermPass = true;
                          });
                          return 'Password is not empty';
                        } else if (passu != val) {
                          setState(() {
                            boolConfermPass = true;
                          });
                          return 'Password does not match';
                        } else {
                          setState(() {
                            boolConfermPass = false;
                          });
                        }
                      },
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: cpass,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(
                            Icons.lock,
                            size: 3.h,
                            color: Colors.indigo[900],
                          ),
                        ),
                        hintText: "Conferm Password",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.indigo[900],
                        ),
                        border: boolConfermPass == false
                            ? OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 7.h,
                  ),
                  width: 60.w,
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
                        try {
                          _image != null
                              ? auth!
                                  .createUserWithEmailAndPassword(
                                      email: emaiU, password: passu)
                                  .then((value) async {
                                  userid = auth!.currentUser!.uid;
                                  await reference!.add({
                                    'name': nameU,
                                    'email': emaiU,
                                    'uid': userid,
                                    'admin': false,
                                    'imageName': '$nameU+$uid'
                                  }).then(
                                    (value) => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LoginMember(),
                                      ),
                                    ),
                                  );
                                }).catchError((onError) {
                                  if (onError.code == 'weak-password') {
                                    toatMsg("Password is too weak");
                                  } else if (onError.code ==
                                      'email-already-in-use') {
                                    toatMsg("email-already-in-use");
                                  } else {
                                    toatMsg("Check e-mail formate");
                                  }
                                })
                              : toatMsg("Upload image");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            print("email already use");
                          }
                          print(e);
                        }
                      }
                    },
                    child: Text(
                      "Sign Up",
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
