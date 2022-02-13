import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models.dart';

class Address extends StatelessWidget {
  Address({Key? key}) : super(key: key);
  int i =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "My Adresses",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      floatingActionButton: TextButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(170, 48)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                side:BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ))),
          onPressed: () {
            Navigator.pushNamed(context, "/map");
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
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

              style: TextStyle( color: Colors.black,fontSize: 15),
            )
          ])),

      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc()
              .collection("addresses")
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: snapshot.data!.docs.map((document) {
                      AddressModel address =
                      AddressModel.fromJson(document.data());
                      i++;
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Container(
                                color: const Color.fromARGB(255, 232, 237, 240),
                                height: 90,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.9,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "ADDRESS $i :",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        address.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              )));
                    }).toList(),
                  ));
            }
          }),);
  }}