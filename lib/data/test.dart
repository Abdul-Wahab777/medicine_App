import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/medcineform.dart';
import 'AllDonation.dart';

String ytyt() {
  return File('medical.png').path;
}

// import 'package:path/path.dart';
// import 'package:file/file.dart';
class Donation extends StatelessWidget {
  // List<dynamic> price;
  // List<dynamic> name;
  // List<dynamic> exp;
 

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) =>MedicineDetail()));
        },
        backgroundColor: Colors.blueGrey[700],
     
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("All Donations", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Medicine Approved").snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {

           if (snapshot.hasData == false || snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } 

          return ListView(
            children: snapshot.data!.docs.map((e) => 
            AllDoMedicine(
                 image: e.get("imageName")!,
            priceMedd: e.get('quantity'),
            nameMedd: e.get("name"),
            expMedd: e.get("exp"),
            uid: e.get("uid"),
            )
             ).toList(),
          );
          
         
        }
      ),
    );
  }
}
