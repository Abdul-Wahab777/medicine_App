import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Constant1.dart';
import 'package:medical_app/UserScreens/User.dart';
import 'package:medical_app/main.dart';

import 'package:sizer/sizer.dart';

import 'Admin Dashboard.dart';

class DetailVerify extends StatefulWidget {
  dynamic image;
  var price;
  var name;
  var exp;
  var uid;

  DetailVerify({this.image, this.exp, this.price, this.name, this.uid});

  @override
  _DetailVerifyState createState() => _DetailVerifyState();
}

class _DetailVerifyState extends State<DetailVerify> {




  
 FirebaseStorage storage =FirebaseStorage.instance;
  
  Uint8List? imageBytes;
  String? errorMsg;
   Future uploadPic(BuildContext context) async{
      
      storage.ref().child(widget.image).getData(10000000).then((data) =>
                setState(() {
                  imageBytes = data;
                  print(data);  
                })
        ).catchError((e) =>
                setState(() {
                  errorMsg = e.error;
                })
        );
    
    }


  @override
    void initState() {
      super.initState();
      uploadPic(context);
    }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(widget.name);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Detail",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Image.memory(imageBytes!),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 380,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                        color: kGrey1Color,
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: widget.price == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${widget.name.toString()}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    "Quantity",
                                    // doctor.specialist,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.price,
                                    // doctor.specialist,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    "Expire date",
                                    // doctor.specialist,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.exp.toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 25.0),
                                  Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blueGrey),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(35.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {

                                        try{

                                             FirebaseFirestore.instance
                                            .collection("Requests Medicines")
                                            .add({
                                          "quantity": widget.price,
                                          "name": widget.name,
                                          "exp": widget.exp,
                                          "uid": widget.uid,
                                          "imageName": "${widget.name + widget.uid}",
                                          "request": false,
                                        });
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.blueGrey,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ), //this right here
                            child: Container(
                              height: 150,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sucessfully Added in Medicine Stock',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // ignore: deprecated_member_use
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Irfan()));

                                              
                                            },
                                            // hoverColor: Colors.green,
                                            color: Colors.white,
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14),
                                            ),
                                            minWidth: 60.0,
                                            height: 35,
                                          ),
                                        ),
                                      
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                                     
                                        }catch(e){
                                          print(e);
                                        }
                                      },
                                      child: Container(
                                        width: 300,
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "Request",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
