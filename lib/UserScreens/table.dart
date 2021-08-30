import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatelessWidget {
  
  final String? timeTable;

 TimeTable({ this.timeTable});
  
  List list = [];
getData() async {
  list.clear();
  final result = await FirebaseFirestore.instance
      .collection('SCHOOL')
      .doc("Classes")
      .collection("9th").doc(timeTable).collection('Time Table')
      .get();

  result.docs.forEach((element) {
      print(element.id);
      list.add(
        element.id
      );
  });


  return list;
}
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        appBar: AppBar(title: Text(timeTable!)),

          body: Container(
        child:Column(
          children: [

            Text("My TimeTable page"),

          FutureBuilder(
            
            future:getData(),
            builder: (context, snapshot){
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length ,
                  itemBuilder: (context, index){
                    return Text(list[index], style: TextStyle(fontSize: 30.0,));
                  }
                  
                  );
            },
            
            
            ),
            ElevatedButton(
              onPressed:(){

              }, 
              child: Text("Button")
              
              )
          ],
        )
      ),
    );
  }
}