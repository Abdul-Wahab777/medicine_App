import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/data/Detail.dart';
import '../Constant1.dart';
import 'package:sizer/sizer.dart';

class   AllDoMedicine extends StatefulWidget {
  dynamic? image;
  dynamic? priceMedd;
  dynamic? nameMedd;
  dynamic? expMedd;
  dynamic? uid;
  AllDoMedicine({this.image, this.nameMedd, this.priceMedd, this.expMedd, this.uid});

  @override
  _AllDoMedicineState createState() => _AllDoMedicineState();
}

class _AllDoMedicineState extends State<AllDoMedicine> {

 FirebaseStorage? storage =FirebaseStorage.instance;
  
  Uint8List? imageBytes;
  String? errorMsg;
   Future uploadPic(BuildContext context) async{
      
      storage!.ref().child(widget.image).getData(10000000).then((data) =>
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
                          name: widget.nameMedd!,
                          exp: widget.expMedd!,
                          uid: widget.uid!,
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
                imageBytes == null ? Container():  Container(
                    width: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: kBlue2Color,
                      image: DecorationImage(
                        image: MemoryImage(imageBytes!),
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
