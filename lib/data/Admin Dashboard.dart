import "package:autocomplete_textfield/autocomplete_textfield.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Constant1.dart';
import 'package:medical_app/data/AllDonation.dart';
import 'package:medical_app/data/DeliverMedicine.dart';

import '../main_page.dart';
import 'medicineVerify.dart';

class Irfan extends StatefulWidget {
  @override
  _IrfanState createState() => _IrfanState();
}

class _IrfanState extends State<Irfan> {
  List name = [
    "Add ",
    "Add ",
    "Set ",
    "Check ",
  ];

  List name1 = [
    " Students",
    " Teachers",
    " TimeTable",
    "Attendence",
  ];
  List name2 = [
    "assets/th.jpg",
    "assets/th (1).jpg",
  ];

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  var searchItem = [], dataInput;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Medicine Approved")
        .snapshots()
        .listen((event) {
      for (var item in event.docs) {
        searchItem.add(item.get("name"));
        print(searchItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        print("res");
      },),
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0.0,
        title: Text(
          "Admin Name ",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: kGrey2Color,
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                },
                icon: Icon(
                  Icons.notifications_none,
                  size: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  SizedBox(height: 1.0),
                  Container(
                    width: double.infinity,
                    height: 55.0,
                    margin: EdgeInsets.symmetric(horizontal: 18.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: kGrey1Color,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: AutoCompleteTextField(
                        itemSubmitted: (item) {
                          print(item);
                        },

                        key: key,
                        suggestions: searchItem,
                        itemBuilder: (context, suggestion) => suggestion ==
                                dataInput
                            ? Padding(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      color: Colors.black),
                                  child: ListTile(
                                    title: Text("No Item Found"),
                                  ),
                                ),
                                padding: EdgeInsets.all(8.0),
                              )
                            : InkWell(
                                onTap: () {
                                  // var val;
                                  // for (var i = 0; i < moviesDataWp.length; i++) {
                                  //   // if ( moviesDataWp[i]['original_title']  == suggestion) {
                                  //   //     setState(() {
                                  //   //     val = moviesDataWp[i];

                                  //   //                                 });
                                  //   // }
                                  // }
                                },

                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white24,
                                      border:
                                          Border.all(color: Colors.blueGrey)),
                                  child: ListTile(
                                    title: Text(
                                      suggestion.toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),

                                // decoration: InputDecoration(
                                //   hintText: "Search",
                                //   icon: Icon(
                                //     Icons.search,
                                //     size: 20.0,
                                //     color: Colors.black54,
                                //   ),
                                // border: InputBorder.none,
                              ),

                        itemSorter: (a, b) => (a as dynamic).compareTo(b),
                        itemFilter: (suggestion, input) {
                          dataInput = input;
                          return (suggestion as dynamic)
                              .toLowerCase()
                              .startsWith(input.toLowerCase());
                        },

                        style: TextStyle(
                            color: Colors.black, fontSize: 13, height: 1.5),
                        //  cursorColor: Colors.black,

                        // textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          contentPadding: EdgeInsets.only(top: 20, left: 20),
                          fillColor: Colors.white12,
                          filled: true,
                          hintText: "Search Medicine",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueGrey,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              left: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    buildTitleRow("Admin Dashboard"),
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spac,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> DeliverMedicine()));
                            },
                            child: buildTaskItem(
                                "Deliver", "Medicines", 'assets/th (1).jpg'),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MedicineVerfiy()));
                              },
                              child: buildTaskItem(
                                  "Medicine", "Verify", "assets/th.jpg")),
                          //   buildTaskItem(
                          //  "Add", "Students",""),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildTitleRow("Live Report's"),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Medicine Approved")
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot>? snapshot) {
                          if (!snapshot!.hasData || snapshot.hasError) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Column(
                            children: snapshot.data!.docs
                                .map(
                                  (e) => AllDoMedicine(
                                    image: e.get("imageName")!,
                                    priceMedd: e.get('quantity')!,
                                    nameMedd: e.get("name")!,
                                    expMedd: e.get("exp")!,
                                    uid: e.get("uid")!,
                                  ),
                                )
                                .toList(),
                          );
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildTaskItem(String courseTitle, String name1, String name2) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(0),
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 150,
            // color: Colors.black,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              image: DecorationImage(
                  image: AssetImage(name2), fit: BoxFit.fitHeight),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            courseTitle,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            name1,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Row buildTitleRow(
    String title,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title",
          style: TextStyle(
              fontSize: 23, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Container buildClassItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.18),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "07:00",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                "AM",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          Container(
            height: 100,
            width: 2,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 160,
                child: Text(
                  "The Basic of Typography II",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      "Room C1, Faculty of Art & Design Building",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=80"),
                    radius: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Gabriel Sutton",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Tiles extends StatelessWidget {
  // @override
  var id;
  var nameMed;
  var priceMed;
  var expMed;
  var lenghtM = 2;
  var searchItem = [];

  var imagess = 'assets/aq1.jpg';

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Medicine Approved")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot>? snapshot) {
            if (snapshot!.hasData) {
              return snapshot.data!.docs.isEmpty == true
                  ? Center(
                      child: Text("NO REQUEST FOUND"),
                    )
                  : ListView(
                      children: snapshot.data!.docs.map((e) {
                        return AllDoMedicine(
                          image: imagess,
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
    );
  }
}
