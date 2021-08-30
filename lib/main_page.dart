import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/data/Detail.dart';
// import 'package:flutter_chat/chatSc/chat_body.dart';

// import 'chat_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var data;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("medicine info")
        .snapshots()
        .listen((event) {
      var mu = [];
      event.docs.forEach((element) {
        var d = element.data();
        //  print(d['uid'] == 'pOmY6UqbsIQM33SQCHAvbLP6bxu2');
        if (d['uid'] == 'pOmY6UqbsIQM33SQCHAvbLP6bxu2') {
          mu.add(d);
          print(mu);
        }
      });
      setState(() {
        data = mu;
      });
    });
  }

  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.request_page),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("medicine info")
                      .snapshots()
                      .listen((event) {
                    var mu = [];
                    event.docs.forEach((element) {
                      var d = element.data();
                      //  print(d['uid'] == 'pOmY6UqbsIQM33SQCHAvbLP6bxu2');
                      if (d['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                        mu.add(d);
                        print(mu);
                      }
                    });
                    setState(() {
                      data = mu;
                      _currentIndex = 0;
                    });
                  });
                },
              ),
              title: Text("Donations"),
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.request_page),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("Requests Medicines")
                      .snapshots()
                      .listen((event) {
                    var mu = [];
                    event.docs.forEach((element) {
                      var d = element.data();
                      //  print(d['uid'] == 'pOmY6UqbsIQM33SQCHAvbLP6bxu2');
                      if (d['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                        mu.add(d);
                        print(mu);
                      }
                    });
                    setState(() {
                      data = mu;
                      _currentIndex = 1;
                    });
                  });
                },
              ),
              title: Text("Requests"),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: Text(
            "${_currentIndex == 0 ? 'DONATIONS' : 'REQUESTS'}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          child: data.isEmpty == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: data.length == 0 ? 0 : data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          // var data=  e.data();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detail(
                                        image: data[index]['imageName'],
                                        name: data[index]['name'],
                                        exp: data[index]['exp'],
                                        uid: data[index]['uid'],
                                      )));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text("${data[index]['name']}"),
                            trailing: Container(
                              width: size.width * 0.30,
                              child: Row(
                                children: [
                                  Text(
                                    "${data[index]['request'] == false ? 'PENDING' : 'APPROVED'}",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.close), onPressed: () {})
                                ],
                              ),
                            ),
                          ),
                        ));
                  }),
        ));
  }
}
