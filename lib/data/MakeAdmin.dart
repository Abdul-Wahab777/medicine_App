import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MakeAdmin extends StatefulWidget {
  @override
  _MakeAdminState createState() => _MakeAdminState();
}

class _MakeAdminState extends State<MakeAdmin> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            centerTitle: true,
            title: Text("Admin Setting"),
            bottom: TabBar( 
              tabs: [
                  Tab(text: "USERS",icon:Icon(Icons.people)),
                  Tab(text: "ADMINS",icon:Icon(Icons.admin_panel_settings))
              ],
            ),
          ),
          body: 
          
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("userInfo")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot>? snapshot) {
                if(!snapshot!.hasData){
                  Center(child: CircularProgressIndicator(),);
                }
                return  snapshot.data==null ?Center(child: CircularProgressIndicator(),) : TabBarView(
                  children: [

                    Container(
                      child: ListView(
                        children:  snapshot.data!.docs
                                        .map(
                                          (e) => e.get("admin") == true ? Container() : Card(
                            child: ListTile(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAdmin()));
                              },
                              title: Text(e.get("name")),
                              trailing: ElevatedButton(child: Text("Make Admin"),onPressed: (){
                                  FirebaseFirestore.instance.collection("userInfo").doc(e.id).update({"admin" : true});
                                },),
                            ),
                          ),).toList(),
                        
                      ),
                    ),


                    Container(
                      child: ListView(
                        children:  snapshot.data!.docs
                                        .map(
                                          (e) => e.get("admin") == false ? Container() : Card(
                            child: ListTile(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAdmin()));
                              },
                              title: Text(e.get("name")),
                              trailing: MaterialButton(
                                color: Colors.red,
                                
                                child: Text("Make User",style: TextStyle(color: Colors.white),),onPressed: (){
                                  FirebaseFirestore.instance.collection("userInfo").doc(e.id).update({"admin" : false});
                                  
                                },),
                            ),
                          ),).toList(),
                        
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
