import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_chat/chat_message.dart';


import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:medical_app/chatSc/chat_message.dart';


class CharBody extends StatefulWidget {
  const CharBody({Key? key}) : super(key: key);

  @override
  _CharBodyState createState() => _CharBodyState();
}

class _CharBodyState extends State<CharBody> {
  // FirebaseService service = FirebaseService();
  var firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  var nameUser;
  var emailUser;
  var uidUser;
  var datafirestore;
  var show;
  List wid = [];
  List<dynamic> emails = [];
  List<dynamic> ids = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("userInfo").snapshots(),
          builder: (
            BuildContext context,
            snapshot,
          ) {
             if(snapshot.hasData==false||snapshot.hasError){
          return Center(child: CircularProgressIndicator(),);
        }
          else  if (snapshot.hasData) {
              datafirestore = snapshot.data!.docs;
              for (var message in datafirestore) {
                nameUser = message.get("name");
                emailUser = message.get('email');
                uidUser = message.get("uid");
                if (uidUser != auth.currentUser!.uid) {
                  // show = Text(
                    nameUser;
                  //   style: TextStyle(fontSize: 27 , color: Colors.white,fontWeight: FontWeight.bold),
                  // );
                 
                  var email = emailUser;

                  var id = uidUser;
                  wid.add(show);
                  wid= wid.toSet().toList();
                  emails.add(email);
                  emails=emails.toSet().toList();
                  ids.add(id);
                  ids=ids.toSet().toList();
                  
                }
              }
            }
            return ListView.builder(
                itemCount: wid.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                     
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => chatMessages(
                                    friendUid: ids[index].toString(),
                                    friendemail: emails[index].toString(),
                                  )));
                        },
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              color: Colors.indigo[900]!.withOpacity(0.9),
                              // color: Colors.white,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  // BorderRadius.circular(15.0)
                                  BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  )
                                  ),
                              depth: 2,
                              intensity: 1,
                              // surfaceIntensity: 0.5,
                              shape: NeumorphicShape.concave,
                              shadowLightColor: Colors.black,
                              lightSource: LightSource.bottomLeft),
                          child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  
                                  // borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  child:Text(wid[index].toString(), style: TextStyle(fontSize: 27 , color: Colors.white,fontWeight: FontWeight.bold),),
                             
                              ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
