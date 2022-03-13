import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iac_project/Widgets/parts.dart';
import '../Widgets/contents.dart';
import '../models.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "Saved Items",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      bottomNavigationBar: const BotBar(i: 3),
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.all(8), child: Text("Restaurants :",style: TextStyle(fontSize: 22,color: Color(0xffbd2005)),)),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('saved')
                  .doc()
                  .collection('restaurants')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return (Column(
                        children: snapshot.data!.docs.map((document) {
                      RestaurantModel d =
                          RestaurantModel.fromJson(document.data());
                      return FeedElement(
                        restaurant: d,
                        id: document.id,
                      );
                    }).toList()));
                }
              }),
              const Padding(padding: EdgeInsets.all(8), child: Text("Deals :",style: TextStyle(fontSize: 22,color: Color(0xffbd2005)),)),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('saved')
                  .doc()
                  .collection('deals')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                        children: snapshot.data!.docs.map((document) {
                      DealModel d = DealModel.fromJson(document.data());
                      return RestaurantElement(
                          deal: d,
                          id: document.id,
                          buttonText: "remove from cart",
                          buttonRole: () {
                            addInCart( d.photoUrl,
                          d.name,
                          d.description,
                          d.price,);
                          });
                    }).toList());
                }
              }),
        ],
      ),
    );
  }
  Future<void> addInCart(url, name, description, price) async {
    DealModel d = DealModel.fromJson({
      'photoUrl': url,
      'name': name,
      'description': description,
      'price': price,
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .add(d.toJson());
    Fluttertoast.showToast(msg: "Item added Successfully to cart :) ");
  }
}
