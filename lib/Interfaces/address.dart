import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Widgets/parts.dart';
import '../models.dart';

class Address extends StatelessWidget {
  Address({Key? key}) : super(key: key);
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "My Addresses",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/feed');
          },
        ),
      ),
      floatingActionButton: TextButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(170, 48)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                side: BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ))),
          onPressed: () {
            Navigator.pushNamed(context, "/map");
          },
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.add_location_alt,
                size: 30,
                color: Colors.black,
              ),
            ),
            Text(
              "Add Location",
              style: TextStyle(color: Colors.black, fontSize: 15),
            )
          ])),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("addresses")
              .orderBy("selected")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              x = 0;
              return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: snapshot.data!.docs.map((document) {
                      AddressModel address =
                          AddressModel.fromJson(document.data());
                      address.description = address.getLocation();
                      x++;
                      return AddressWidget(address: address, x: x, document: document,);}).toList(),
                  ));
            }
          }),
    );
  }
}

