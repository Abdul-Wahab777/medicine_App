import 'package:flutter/material.dart';

// import 'package:funkkar_3/ProfileList.dart';
// import 'package:funkkar_3/sellerProfile.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:funkkar_3/Home1.dart';
// import 'Categories.dart';/
class Profile1 extends StatefulWidget {
  @override
  _Profile1State createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Center(
                  child: Text(
                    "Profile ",
                    style: TextStyle(
                        fontSize: 28,
                        color: Color(0xff0353a3),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 6,
                    child: ListTile(
                      leading: Icon(Icons.person,
                        color: Color(0xff0353a3),
                      ),
                      title: Text(
                        "Account",
                        style: TextStyle(
                            fontSize: 18,
                        color: Color(0xff0353a3),
                        
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: SizedBox(
                        // height: 30,
                        // width: 30,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 6,
                    child: ListTile(
                      leading: Icon(Icons.notifications,
                        color: Color(0xff0353a3),
                      
                      ),

                      title: Text(
                        "Notifications",
                        style: TextStyle(
                            fontSize: 18,
                        color: Color(0xff0353a3),
                            
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: SizedBox(
                        // height: 30,
                        // width: 30,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 6,
                    child: ListTile(
                      leading:Icon(Icons.star_border_outlined,
                        color: Color(0xff0353a3),
                      ),
                      title: Text(
                        "Rate DrugStar",
                        style: TextStyle(
                            fontSize: 18,
                        color: Color(0xff0353a3),
                            
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: SizedBox(
                        // height: 30,
                        // width: 30,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 6,
                    child: ListTile(
                      leading: Icon(Icons.share,
                        color: Color(0xff0353a3),
                      ),
                      title: Text(
                        "Share with others ",
                        style: TextStyle(
                            fontSize: 18,
                        color: Color(0xff0353a3),
                          
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: SizedBox(
                        // height: 30,
                        // width: 30,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 6,
                    child: ListTile(
                      leading: Icon(Icons.info_outline,
                        color: Color(0xff0353a3),
                      ),
                      title: Text(
                        "About",
                        style: TextStyle(
                            fontSize: 18,
                        color: Color(0xff0353a3),
                            
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: SizedBox(
                        // height: 30,
                        // width: 30,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/6),
                InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 6,
                    child: ListTile(
                      leading: Icon(Icons.logout,
                        color: Color(0xff0353a3),
                      ),
                      title: Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 18,
                        color: Color(0xff0353a3),
                            
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: SizedBox(
                        // height: 30,
                        // width: 30,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
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
