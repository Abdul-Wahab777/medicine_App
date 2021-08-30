import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/data/Detail.dart';
import 'package:medical_app/data/DetailsRequest.dart';
import '../Constant1.dart';
import 'package:sizer/sizer.dart';

import 'Admin Dashboard.dart';

class AccORrej extends StatefulWidget {
  var image;
  var priceMedd;
  var nameMedd;
  var expMedd;
  var uid;
  AccORrej({this.image, this.nameMedd, this.priceMedd, this.expMedd, this.uid});

  @override
  _AccORrejState createState() => _AccORrejState();
}

class _AccORrejState extends State<AccORrej> {
  FirebaseStorage storage = FirebaseStorage.instance;

  Uint8List? imageBytes;
  String? errorMsg;
  Future uploadPic(BuildContext context) async {
    storage
        .ref()
        .child(widget.image)
        .getData(10000000)
        .then((data) => setState(() {
              imageBytes = data;
              print(data);
            }))
        .catchError((e) => setState(() {
              errorMsg = e.error;
            }));
  }

  @override
  void initState() {
    super.initState();
    uploadPic(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsRequest(
                          image: imageBytes!,
                          price: widget.priceMedd.toString(),
                          name: widget.nameMedd,
                          exp: widget.expMedd,
                          uid: widget.uid,
                        )));
          },
          child: Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 12),
              width: double.infinity,
              height: 150.0,
              child: Row(
                children: [
                 imageBytes == null ? Container() :  Container(
                    width: 90.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: kBlue2Color,
                      image: DecorationImage(
                        image: MemoryImage(imageBytes!),
                        // image:  AssetImage("assets/medical.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 18.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.nameMedd.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          "Quantity : ${widget.priceMedd.toString()}",
                          style: kButtonStyle.copyWith(
                              fontSize: 10.sp, color: Colors.red),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          "Expire date",
                          // doctor.specialist,
                          overflow: TextOverflow.ellipsis,
                          style: kCategoryStyle.copyWith(
                              fontSize: size.height / 65,
                              color: Colors.grey[900]),
                        ),
                        Text(
                          widget.expMedd.toString(),
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Container(
                          width: size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {


                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            backgroundColor: Colors.blueGrey,

                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ), //this right here
                                            child: Container(
                                              height: 150,
                                              width: 150,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Sucessfully Added in Medicine Stock',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      width: 320.0,
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        // ignore: deprecated_member_use
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: MaterialButton(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    20.0),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Irfan()));
                                                            },
                                                            // hoverColor: Colors.green,
                                                            color: Colors.white,
                                                            child: Text(
                                                              "OK",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
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
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {}),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(width: 8.0),
                ],
              ),
            ),
          )),
    );
  }
}
