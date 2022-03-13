import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iac_project/models.dart';
import '../Widgets/contents.dart';
// TODO heart init

class Restaurant extends StatefulWidget {
  const Restaurant({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  late final RestaurantModel? restaurant;
  String source = "assets/icons/heart.png";

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(widget.id)
        .get()
        .then((value) => {
              setState(
                () {
                  restaurant = RestaurantModel.fromJson(value);
                },
              )
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffbd2005),
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        child: const Icon(
          Icons.shopping_cart_rounded,
          color: Colors.white,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            expandedHeight: 230,
            pinned: true,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    restaurant!.name,
                    style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 63, 11, 4)),
                  ),
                  Text(
                    restaurant!.location.toString(),
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 63, 11, 4)),
                  ),
                ],
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(restaurant!.photoUrl),
                    fit: BoxFit.cover),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (source == "assets/icons/heart.png") {
                      setState(() {
                                  source = "assets/icons/heart1.png";
                                });
                      addToSaved(
                        restaurant
                      );
                    } else {
                      setState(() {
                                    source = "assets/icons/heart.png";
                                  });
                      removeFromSaved(widget.id);
                    }
                  },
                  child: ImageIcon(
                    AssetImage(source),
                    color: const Color(0xffbd2005),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.share,
                  color: Color(0xffbd2005),
                ),
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child:
                Padding(padding: EdgeInsets.all(8), child: Text("All Deals :",style: TextStyle(fontSize: 22,color: Color(0xffbd2005)),)),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('restaurants')
                    .doc(widget.id)
                    .collection('deals')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom:45),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                            children: snapshot.data!.docs.map((document) {
                          DealModel d = DealModel.fromJson(document.data());
                          return RestaurantElement(
                              deal: d,
                              id: document.id,
                              buttonText: "Add in Cart",
                              buttonRole: () {
                                addInCart(
                                  d
                                );
                              });
                        }).toList()),
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  removeFromSaved(String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .doc()
        .collection("restaurants")
        .doc(id)
        .delete();
  }

  addToSaved(d) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("saved")
        .doc()
        .collection("restaurants")
        .add(d.toJson());
  }

  Future<void> addInCart(d) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .add(d.toJson());
    Fluttertoast.showToast(msg: "Item added Successfully to cart :) ");
  }
}
