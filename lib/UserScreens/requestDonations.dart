import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/data/Detail.dart';
import 'package:sizer/sizer.dart';
import '../Constant1.dart';


class   RequestDonation extends StatefulWidget {
  var image;
  var priceMedd;
  var nameMedd;
  var expMedd;
  var uid;
  RequestDonation({this.image, this.nameMedd, this.priceMedd, this.expMedd, this.uid});

  @override
  _RequestDonationState createState() => _RequestDonationState();
}

class _RequestDonationState extends State<RequestDonation> {

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

    return SingleChildScrollView(
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detail(
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
              padding: EdgeInsets.all(12.0),
              width: double.infinity,
              height: 140.0,
              child: Row(
                children: [
                  Container(
                    width: 80.0,
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
                      ],
                    ),
                  ),
                  // SizedBox(width: 8.0),
                  Container(
                    width: 70.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // SizedBox(height: 10.sp),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
