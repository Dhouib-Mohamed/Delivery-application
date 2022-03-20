import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/tapped.dart';
import '../models.dart';

class Checkout extends StatefulWidget {
  final num price;
  const Checkout({Key? key, required this.price}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Color c = const Color.fromARGB(255, 232, 237, 240);
  bool b = false;

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
          Padding(
            padding: const EdgeInsets.all(15),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("addresses")
                    .orderBy("selected")
                    .limit(1)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    b = true;
                    AddressModel address =
                    AddressModel.fromJson(snapshot.data!.docs.first.data());
                    address.description = address.getLocation();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom:20),
                              child: Text(
                                "Delivery Address",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                  ,)
                                ,),
                            ),
                            FutureBuilder<String>(
                                future: address.description,
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data ?? "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  );
                                }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0,left: 4),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/address');},
                                icon:const ImageIcon(AssetImage("assets/icons/change.png")),
                              ),
                        ),
                      ],
                    );
                  } else {
                    return const TappedPosition(
                        text: "",
                        tapped: "Please add a location to continue",
                        role: '/address');
                  }
                }),
          ),
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
