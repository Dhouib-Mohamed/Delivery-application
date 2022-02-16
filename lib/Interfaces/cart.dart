import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iac_project/models.dart';
import '../Widgets/contents.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void onItem(index) {
    switch (index) {
      case 0:
        setState(() {
          Navigator.pushNamed(context, '/feed');
        });
        break;
      case 1:
        setState(() {
          Navigator.pushNamed(context, '/search');
        });
        break;
      case 3:
        setState(() {
          Navigator.pushNamed(context, '/saved');
        });
        break;
      case 4:
        setState(() {
          Navigator.pushNamed(context, '/profile');
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItem,
          unselectedLabelStyle: const TextStyle(color: Colors.blueGrey),
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: const Color(0xffbd2005),
          currentIndex: 2,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_rounded,
                ),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/heart.png")),
                label: "Saved"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile"),
          ]),
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
                          url: d.photoUrl,
                          name: d.name,
                          description: d.description,
                          price: d.price,
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
