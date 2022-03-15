import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/models.dart';
import '../Widgets/contents.dart';
import '../gobals.dart' as globals;

class Restaurant extends StatefulWidget {
  final RestaurantModel restaurant;
    final String id;

  const Restaurant({Key? key, required this.id, required this.restaurant}) : super(key: key);


  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  String source = "assets/icons/heart.png";

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
                    widget.restaurant.name,
                    style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 63, 11, 4)),
                  ),
                  FutureBuilder<void>(
                    future: widget.restaurant.getLocation(),
                    builder: (context, snapshot) {
                      return Text(
                        widget.restaurant.description!,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 63, 11, 4)),
                      );
                    }
                  ),
                ],
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.restaurant.photoUrl),
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
                      globals.addRestaurantToSaved(
                        widget.restaurant
                      );
                    } else {
                      setState(() {
                                    source = "assets/icons/heart.png";
                                  });
                      globals.removeRestaurantFromSaved(widget.id);
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
                                globals.addToCart(
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
}
