import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_app/chatSc/chat_message.dart';
import 'package:medical_app/login/LoginMember.dart';
class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth? auth = FirebaseAuth.instance;
   FirebaseStorage? storage = FirebaseStorage.instance;
  Uint8List? imageBytes;

  String? errorMsg;
  Future getPic(BuildContext context) async {
    storage!
        .ref()
        .child('profile_photo/${auth!.currentUser!.uid}')
        .getData(10000000)
        .then((data) => setState(() {
              imageBytes = data;
            }))
        .catchError((e) => setState(() {
              errorMsg = e.error;
            }));
  }
   @override
  void initState() {
    super.initState();
    getPic(context);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            // image: DecorationImage(
            //     // image: AssetImage("assets/image.jpeg"),
            //      fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.4 ,
                  height: MediaQuery.of(context).size.height * 0.18,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffBCB6B0).withOpacity(0.2),
                      
                          ),
                          child: CircleAvatar(backgroundImage: MemoryImage(imageBytes!),),
                ),
              
          
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
               children: [
               Container(
                 color: Colors.indigo[900],
                 width: MediaQuery.of(context).size.width,
                 child: ListTile(
                   
                   leading: Icon(
                                Icons.person,
                                color: Colors.white,
                              ) ,
                              title: Text("${auth!.currentUser!.displayName}",style: TextStyle(
                                color: Colors.white
                              ),),
                 ),
               ),  
                 
                 SizedBox(height: 10,),
                  Container(
                 color: Colors.indigo[900],
                 width: MediaQuery.of(context).size.width,
                
                 child: ListTile(
                   
                   leading: Icon(
                                Icons.person,
                                color: Colors.white,
                              ) ,
                              title: Text("${auth!.currentUser!.email}",style: TextStyle(
                                color: Colors.white
                              ),),
                 ),
               ),  
       
            SizedBox(
                    height: MediaQuery.of(context).size.height/40,
                  ),
            
             SizedBox(
                    height: MediaQuery.of(context).size.height/40,
                  ),
                 Card(
                      color:Colors.red,
                      child: ListTile(
                        onTap: (){
                          auth!.signOut().then((value) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginMember()));
                          });
                        },
                        leading: Icon(
                          Icons.logout,
                          size: 20,
                          color: Colors.white70,
                        ),
                        title: Text(
                          "Sign Out ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                
               ],
             ),
           ),
                     ],
            ),
          ),
        ),
      ),
    );
  }
}
// TextField(
//                 cursorColor: Colors.white,
               
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
//               textAlign: TextAlign.start,
              
//               decoration: InputDecoration(
//                  filled: true,

//                   fillColor: Colors.grey,
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white70, width: 2.0),),
//                 contentPadding: EdgeInsets.only(top: 20, left: 20),
//                 prefixIcon: Icon(
//                   Icons.email,
//                   color: Colors.white,
//                 ),
              
//                 hintText: "${auth!.currentUser!.email}",
//                 hintStyle: TextStyle(
//                   color: Colors.white,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Color(0xff40dedf),
//                   ),
//                 ),
                
//               ),
              
//           ),