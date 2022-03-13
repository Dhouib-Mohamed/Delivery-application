import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iac_project/Widgets/parts.dart';
import 'package:iac_project/models.dart';
import '../Widgets/contents.dart';
import 'checkout.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BotBar(i: 2),
        appBar: AppBar(
          backgroundColor: const Color(0xffbd2005),
          title: const Text(
            "Cart",
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
        body: ListView(children: [
          Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('cart')
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
                          DealModel d = DealModel.fromJson(document.data());
                          return RestaurantElement(
                              deal: d,
                              id: document.id,
                              buttonText: "remove from cart",
                              buttonRole: () {
                                removeFromCart(document.id);
                              });
                        }).toList()),
                      );
                    }
                  }),
            ],
          ),
          Center(
              child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 170,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('cart')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  num price = 0;
                  snapshot.data!.docs.map((document) {
                    DealModel d = DealModel.fromJson(document.data());
                    price += d.price;
                  });
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "SUBTOTAL :",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "$price TND",
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "DELIVERY FEE :",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "3 TND",
                              style: TextStyle(fontSize: 14),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${price + 3} TND",
                                style: const TextStyle(fontSize: 14)),
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xffbd2005)),
                                    fixedSize: MaterialStateProperty.all(
                                        const Size(250, 43)),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Checkout(
                                                price: price,
                                              )));
                                },
                                child: const Text(
                                  "GO TO CHECKOUT",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )),
                          ]),
                    ],
                  );
                }),
          ))
        ]));
  }

  removeFromCart(String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .doc(id)
        .delete();
    Fluttertoast.showToast(msg: "Item removed Successfully from cart :) ");
  }
}
