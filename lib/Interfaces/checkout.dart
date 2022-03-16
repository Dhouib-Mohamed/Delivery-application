import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models.dart';

class Checkout extends StatefulWidget {
  final num price;
  const Checkout({Key? key, required this.price}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Color c = const Color.fromARGB(255, 232, 237, 240);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: ListView(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
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
                          address.description = address.getLocation();
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {});
                                },
                                child: Container(
                                  color: c,
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: FutureBuilder<String>(
                                            future: address.description,
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.data??"",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              )));
                        }).toList(),
                      ));
                }
              }),
          PaiementButton(name: "PAY NOW", c: c, role: '/end_order')
        ],
      ),
    );
  }
}

class PaiementButton extends StatelessWidget {
  final String? name;
  final Color? c;
  final String role;
  const PaiementButton(
      {Key? key, required this.name, required this.c, required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(c!),
            fixedSize: MaterialStateProperty.all(const Size(250, 43)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ))),
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("cart")
              .get()
              .then((value) {
            for (var element in value.docs) {
              element.reference.delete();
            }
          });
          Navigator.pushNamed(context, role);
        },
        child: Text(
          name!,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ));
  }
}
