import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iac_project/Widgets/parts.dart';
import 'package:iac_project/models.dart';
import '../Widgets/contents.dart';

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
      body: Column(
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
    );
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
