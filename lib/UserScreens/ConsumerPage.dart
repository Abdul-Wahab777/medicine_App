



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/UserScreens/requestDonations.dart';
import 'package:medical_app/data/AllDonation.dart';


class ConsumerPage extends StatefulWidget {

  @override
  _ConsumerPageState createState() => _ConsumerPageState();
}

class _ConsumerPageState extends State<ConsumerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Request Donations", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Medicine Approved")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.docs.isEmpty == true
                  ? Center(
                      child: Text("NO REQUEST FOUND"),
                    )
                  : ListView(
                      children: snapshot.data!.docs.map((e) {
                        return RequestDonation(
                          image: e.get("imageName"),
                          priceMedd: e.get("quantity"),
                          nameMedd: e.get("name"),
                          expMedd: e.get("exp"),
                        );
                      }).toList(),
                    );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      ),
    );
  }
}