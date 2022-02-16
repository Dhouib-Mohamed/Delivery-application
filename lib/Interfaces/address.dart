import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Widgets/tapped.dart';
import '../models.dart';
import 'address_map.dart';

class Address extends StatelessWidget {
  Address({Key? key}) : super(key: key);
  int i = 0;

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
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              i = 0;
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
                              child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddressMap(
                                          location: address.location)));
                            },
                            child: Container(
                              color: const Color.fromARGB(255, 232, 237, 240),
                              height: 90,
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "ADDRESS $i :",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SimplButton(
                                          buttonRole: () {
                                            removeAdress(document.id);
                                          },
                                          buttonText: "Remove address"),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      address.location.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )));
                    }).toList(),
                  ));
            }
          }),
    );
  }

  removeAdress(String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("addresses")
        .doc(id)
        .delete();
    Fluttertoast.showToast(msg: "Item removed Successfully from cart :) ");
  }
}
