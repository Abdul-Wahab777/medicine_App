import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/data/VerifyDetail.dart';
// import 'package:flutter_chat/chatSc/chat_body.dart';

// import 'chat_page.dart';

class MedicineVerfiy extends StatefulWidget {
  @override
  _MedicineVerfiyState createState() => _MedicineVerfiyState();
}

class _MedicineVerfiyState extends State<MedicineVerfiy> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "REQUESTS",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("Chats"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text("Groups"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("Profile"),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("medicine info")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.docs.isEmpty == true
                    ? Center(
                        child: Text("NO REQUEST FOUND"),
                      )
                    : ListView(
                        children: snapshot.data!.docs.map((e) {
                          return InkWell(
                            onTap: () {
                               Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailVerify(
                          image: e.get("imageName"),
                          price: e.get("quantity"),
                          name: e.get("name"),
                          exp: e.get("exp"),
                          uid: e.get("uid"),
                        )));

                              // Navigator.
                                  
                            },
                            child: Card(
                              child: ListTile(
                                title: Text("${e.get("name")}"),
                                trailing: Container(
                                  width: size.width * 0.30,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.check,
                                              color: Colors.green),
                                          onPressed: () {
                                            setState(() {
                                              var ins = FirebaseFirestore
                                                  .instance
                                                  .collection("medicine info");
                                              ins
                                                  .doc(e.id)
                                                  .update({"request": true});

                                              var inss = FirebaseFirestore
                                                  .instance
                                                  .collection(
                                                      "Medicine Approved");
                                              // inss.add(e.data()!);
                                              var obj = e.data();
                                              inss.add({
                                                "name": e.get("name"),
                                                "request": e.get("request"),
                                                "exp": e.get("exp"),
                                                "imageName": e.get("imageName"),
                                                "quantity": e.get("quantity"),
                                                "uid": e.get("uid"),
                                              });
                                              print(obj);
                                            });

                                            FirebaseFirestore.instance
                                                .collection("medicine info")
                                                .doc(e.id)
                                                .delete();

                                            //  print(e.get("request"));
                                          }),
                                      IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("medicine info")
                                                .doc(e.id)
                                                .delete();
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
