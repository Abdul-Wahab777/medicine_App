import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/UserScreens/table.dart';
import 'package:medical_app/chatSc/chat_message.dart';
import 'package:medical_app/firebaseAuth.dart';

import '../obj.dart';


//  FutureBuilder(
//         future: getData(),
//         builder: (context,snap){
//           return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: list.length,
//                     itemBuilder: (context, index) {
//                       var myData = FirebaseFirestore.instance.collection("/UsersChat/null,arhamsarwar786@gmail.com/Messages").doc(list[index]);
//                       FirebaseFirestore.instance.collection("/UsersChat/null,arhamsarwar786@gmail.com/Messages/$myData").get('nam')
//                       return Text(myData.);
                      
//                     });
//         },
//       ),

      

// List list = [];
// getData()async{
//   list.clear();
//     var data = await  FirebaseFirestore.instance.collection("UsersChat").doc("${auth.currentUser!.displayName},${auth.currentUser!.email}").collection("Messages").get();
//     data.docs.forEach((element) {
//       list.add(element.id);
//     });
//     return list;
// }

FirebaseFirestore firestore = FirebaseFirestore.instance;
var nameSender;
var emailUser;
var uid;
var email;

  FirebaseAuth auth = FirebaseAuth.instance;
class UserChatMessage extends StatefulWidget {
  // var friendUid;

  // var friendemail;
  // UserChatMessage({this.friendUid, this.friendemail});

  @override
  _UserChatMessageState createState() => _UserChatMessageState();
}

class _UserChatMessageState extends State<UserChatMessage> {
  // FirebaseService service = FirebaseService();

  TextEditingController textController = TextEditingController();

  // Future getusername() async {
  //   var messge = await firestore.collection("userInfo").get();
  //   for (var m in messge.docs) {
  //     var name = m.get("name");
  //     var id = m.get("uid");
  //     if (auth.currentUser!.uid == id) {
  //       emailUser = auth.currentUser!.email;

  //       nameSender = name;
  //     }
  //   }
  // }

  // String? Textt;
  // @override
  // void initState() {
  //   super.initState();
  //   uid = widget.friendUid;
  //   messages();
  //   setState(() {
  //     BubbleMessage();
  //   });
  // }

  var msg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
      ),
      // body: widget.friendUid == widget.friendUid
      // ?
      body:  Container(
        width: 500,
        height: 500,
        color: Colors.red,
        child: StreamBuilder(
               stream: FirebaseFirestore.instance.collection("/UsersChat/null,arhamsarwar786@gmail.com/Messages").snapshots(),
               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                 return Container(
                   child: ListView(
                     children: snapshot.data!.docs.map((e) => Text("${e.get("message")}")).toList(),
                   ),
                 );
                 
                  
               },
             ),
      ),
     
      //  Container(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //     //   Container(


      //     //  child:  
      //     //       // child: messages(
      //     //       //     // emailf: widget.friendemail,
      //     //       //     )
      //     //           ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Container(
      //             margin: EdgeInsets.only(left: 5, bottom: 5),
      //             width: MediaQuery.of(context).size.width * 0.7,
      //             child: TextField(
      //               onChanged: (val) {
      //                 setState(() {
      //                   msg = val;
      //                 });
      //                 // setState(() {
      //                 //   messages();
      //                 //   BubbleMessage();
      //                 // });
      //               },
      //               decoration: InputDecoration(
      //                 border: OutlineInputBorder(),
      //                 hintText: "Type messages",
      //                 hintStyle: TextStyle(color: Colors.black, fontSize: 20),
      //               ),
      //               controller: textController,
      //             ),
      //           ),
      //           MaterialButton(
      //             color: Colors.yellow,
      //             onPressed: () async {

      //               FirebaseFirestore.instance.collection("UsersChat").doc("${auth.currentUser!.displayName},${auth.currentUser!.email}").collection("Messages").add({
      //                  'message': msg,
      //                   'From': auth.currentUser!.displayName,
      //                   'email': auth.currentUser!.email,
      //                   'time': DateTime.now(),
      //               });
                    
                   
      //               // for (var item in ) {
                      
      //               // }
      //               // if(auth.currentUser!.email == )
      //               // getusername();
      //               // try {
      //               //   print(Text);
      //               //   firestore
      //               //       .collection(widget.friendemail.toString())
      //               //       .add({
      //                   // 'message': Textt ?? "".toString(),
      //                   // 'From': nameSender ?? "".toString(),
      //                   // 'email': auth.currentUser!.email,
      //                   // 'time': DateTime.now(),
      //               //   });
      //               //   setState(() {
      //               //     messages();
      //               //     BubbleMessage();
      //               //   });
      //               // } catch (e) {
      //               //   print(e);
      //               // }
      //               // setState(() {
      //               //   messages();
      //               //   BubbleMessage();
      //               // });
      //               // textController.clear();
      //             },
      //             shape: CircleBorder(),
      //             child: Icon(
      //               Icons.send,
      //               color: Colors.white,
      //             ),
      //           )
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

class messages extends StatelessWidget {
  // var emailf;

  // messages({this.emailf});
   var firestoreData;
  // static var messageData;
  // static var senderName;
  // static var email;
  // static var time;
  
  @override
  Widget build(BuildContext context) {
    
    List<BubbleMessage> indexes = [];
    return StreamBuilder<QuerySnapshot>(
      stream : FirebaseFirestore.instance.collection("UsersChat").doc("${auth.currentUser!.displayName},${auth.currentUser!.email}").collection("Messages").snapshots(),
      // stream: firestore
      //     .collection(emailf.toString())
      //     .orderBy('time', descending: true)
      //     .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } 
        // else if (snapshot.hasData) {
          // firestoreData = snapshot.data!.docs;
          // for (var data in firestoreData) {
          //   messageData = data.get("message");
          //   senderName = data.get("From");
          //   email = data.get("email");
          //   time = data.get("time");
          //   var m = data;
          //   print(
          //       "Data iss ggggggggggggggggggggggggggggggggggggggggggggggggggggghhhhhhhh $messageData   $senderName $email");
          //   var a = BubbleMessage(
          //     message: messageData,
          //     snder: senderName,
          //     time: time,
          //     isMe: emailUser == email,
          //   );
          //   indexes.add(a);
          // }
        // }
        return Expanded(
          child: ListView(
            children: snapshot.data!.docs.map((e) =>
              Text(e.get('msg')),
             ).toList(),
          ),
          
          // ListView(
          //   padding: EdgeInsets.only(left: 10, bottom: 10),
          //   shrinkWrap: true,
          //   reverse: true,
          //   children: indexes,
          // ),
        );
      },
    );
  }
}

class BubbleMessage extends StatefulWidget {
  final data;
  BubbleMessage(this.data);
  // final snder;
  // final message;
  // final time;
  // final isMe;

  @override
  _BubbleMessageState createState() => _BubbleMessageState();
}

class _BubbleMessageState extends State<BubbleMessage> {
  @override
  Widget build(BuildContext context) {
    print('This is' + uid);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            widget.data ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            widget.data,
            style: TextStyle(fontSize: 12, color: Colors.indigo[900]),
          ),
          Material(
            borderRadius: widget.data
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            elevation: 10.0,
            color: widget.data ? Colors.lightBlueAccent : Colors.orange,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.00, horizontal: 20.0),
              child: Text(
                widget.data.get(''),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
