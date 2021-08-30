import 'package:flutter/material.dart';


class OBJ extends StatefulWidget {
  final instance;
  OBJ(this.instance);
  @override
  _OBJState createState() => _OBJState();
}

class _OBJState extends State<OBJ> {


  @override
    void initState() {
      super.initState();

      widget.instance.snapshots().listen((event) { 
                      event.docs.forEach((element) {
                          print(element.data());
                      });
                    });   
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}