
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
class GetImge extends StatefulWidget {

  @override
  _GetImgeState createState() => _GetImgeState();
}

class _GetImgeState extends State<GetImge> {
  FirebaseStorage storage =FirebaseStorage.instance;
  
  Uint8List? imageBytes;
  String? errorMsg;
  Future uploadPic(BuildContext context) async{
      
      storage.ref().child('PanadolpOmY6UqbsIQM33SQCHAvbLP6bxu2').getData(10000000).then((data) =>
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          child:imageBytes!=null? Image.memory(
            imageBytes!,
          ):MaterialButton(onPressed: (){
            
          uploadPic(context);
          setState(() {
                      
                    });
          },child: Text("Click"),
          ),
        ),
      ),
    );
  }
}

