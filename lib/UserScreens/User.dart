import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/data/AllDonation.dart';
import 'package:medical_app/data/test.dart';
import 'package:medical_app/main.dart';
import '../Constant1.dart';
import '../main_page.dart';
import '../medcineform.dart';
import 'ConsumerPage.dart';
import 'package:sizer/sizer.dart';
class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<String> Images = [
    "assets/medi1.png",
    "assets/medi2.jpg",
    "assets/medi3.jpg",
  ];

  FirebaseFirestore? firestore = FirebaseFirestore.instance;

  FirebaseAuth? auth = FirebaseAuth.instance;

  FirebaseStorage? storage = FirebaseStorage.instance;

  var id;

  var nameMed;

  var priceMed;

  var expMed;

  var lenghtM;

  var quantity;

  var image;

  List<dynamic> namelist = [];

  List<dynamic> nameprice = [];

  List<dynamic> nameexp = [];

  Uint8List? imageBytes;

  String? errorMsg;

  Future getPic(BuildContext context) async {
    storage!
        .ref()
        .child('profile_photo/${auth!.currentUser!.uid}')
        .getData(10000000)
        .then((data) {
      setState(() {
        imageBytes = data;
      });
    }).catchError((e) {
      setState(() {
        errorMsg = e.error;
      });
    });
  }

  var nameMember;
  Future getusername() async {
    var messge = await firestore!.collection("userInfo").get();
    for (var m in messge.docs) {
      var name = m.get("name");
      var id = m.get("uid");
      if (auth!.currentUser!.uid == id) {
        nameMember = name;
        print(nameMember);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPic(context);
    getusername();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore!.collection("Medicine Approved").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            lenghtM = snapshot.data!.docs;
            if (snapshot.hasData == false || snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage: MemoryImage(imageBytes!),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                                                        width: MediaQuery.of(context).size.width*0.3,
                            child: Text(nameMember.toString(),style: TextStyle(
                              fontSize: 20.sp,
                              
                            ),),
                          ),
                          Spacer(),
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.indigo[900],
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()));
                                },
                                icon: Icon(
                                  Icons.notifications_none,
                                  size: 20.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      height: 55.0,
                      margin: EdgeInsets.symmetric(horizontal: 18.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: kGrey1Color,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            icon: Icon(
                              Icons.search,
                              size: 20.0,
                              color: Colors.black54,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                            height: 150.0,
                            autoPlay: true,
                            enlargeCenterPage: true),
                        items: [
                          "assets/aq.jpg",
                          "assets/aq1.jpg",
                          "assets/aq2.png",
                          "assets/aq3.jpg"
                        ].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: 60078,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: kBlue2Color,
                                  image: DecorationImage(
                                    image: AssetImage(i),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      height: 100,
                      // width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MedicineDetail(),
                                      ),
                                    );
                                  },
                                  child: CategoriesItem(
                                      title: "Donate", color: Colors.indigo[900])),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConsumerPage()),
                                  );
                                },
                                child: CategoriesItem(
                                    title: "Consumer", color: Colors.indigo[900]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                        // color: kGrey1Color,
                        color: Colors.indigo[900]
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Recent Donation",
                                style: TextStyle(
                                  color: Colors.white,
                                    fontWeight: FontWeight.bold, fontSize: 15.sp),
                              ),
                              Spacer(),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Donation()));
                                },
                                child: Text(
                                  "See all",
                                  style: TextStyle(
                                    color: Colors.lime,
                                  ),
                                ),
                              )
                            ],
                          ),

                          Column(
                            children: snapshot.data!.docs
                                .map(
                                  (e) => AllDoMedicine(
                                    image: e.get("imageName")!,
                                    priceMedd: e.get('quantity'),
                                    nameMedd: e.get("name"),
                                    expMedd: e.get("exp"),
                                    uid: e.get("uid"),
                                  ),
                                )
                                .toList(),
                          )
                          // DonationTiles(lenghtM: lenghtM, Images: Images, nameprice: nameprice, namelist: namelist, nameexp: nameexp,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class DonationTiles extends StatelessWidget {
  const DonationTiles({
    Key? key,
    required this.lenghtM,
    required this.Images,
    required this.nameprice,
    required this.namelist,
    required this.nameexp,
    required this.uid,
  }) : super(key: key);

  final lenghtM;
  final List<String> Images;
  final List nameprice;
  final List namelist;
  final List nameexp;
  final List uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: lenghtM.length,
        // scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return AllDoMedicine(
            image: Images[index],
            priceMedd: nameprice[index],
            nameMedd: namelist[index],
            expMedd: nameexp[index],
            uid: uid[index],
          );
        },
      ),
    );
  }
}

class CategoriesItem extends StatelessWidget {
  
  var color;
  var title;
  CategoriesItem({
    this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      child: Container(
        // width: size.width * 0.40,
        padding: EdgeInsets.symmetric(
            horizontal: size.width / 10, vertical: size.height / 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.height / 40),
          color: color,
        ),
        child: Center(
          child: Text(title,
              style: kCategoryStyle.copyWith(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
