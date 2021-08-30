import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AccORrej.dart';
import 'AllDonation.dart';

class DeliverMedicine extends StatefulWidget {
  const DeliverMedicine({ Key? key }) : super(key: key);

  @override
  _DeliverMedicineState createState() => _DeliverMedicineState();
}

class _DeliverMedicineState extends State<DeliverMedicine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
         appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "REQUESTING",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
        body: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Requests Medicines")
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData == false || snapshot.hasError) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView(
                              children: snapshot.data!.docs
                                  .map(
                                    (e) => AccORrej(
                                      image: e.get("imageName")!,
                                      priceMedd: e.get('quantity'),
                                      nameMedd: e.get("name"),
                                      expMedd: e.get("exp"),
                                      uid: e.get("uid"),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
      ),
    );
  }
}

