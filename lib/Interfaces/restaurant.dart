import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/models.dart';

class Restaurant extends StatefulWidget {
  const Restaurant({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  late RestaurantModel? restaurant;

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 100),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(restaurant!.name),
                    Text(restaurant!.location.toString()),
                  ],
                ),
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(restaurant!.photoUrl),fit: BoxFit.cover),
              ),
            ),
            leading: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.heart_broken,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            ],

          ),
          // StreamBuilder(
          //     stream: FirebaseFirestore
          //         .instance
          //         .collection('restaurants')
          //         .doc(widget.id)
          //         .collection("deals")
          //         .snapshots(),
          //
          //     builder: (BuildContext context,
          //         AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (!snapshot.hasData) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       } else {
          //         return SingleChildScrollView(
          //           scrollDirection: Axis.horizontal,
          //           child: Column(
          //               children: snapshot.data!.docs.map((document) {
          //                 DealModel d =
          //                 DealModel.fromJson(document.data());
          //                 return RestaurantElement(
          //                   url: d.photoUrl,
          //                   name: d.name,
          //                   description: d.description,
          //                   price: d.price ,);
          //               }).toList()),
          //         );
          //       }
          //     }),

        ],
      ),
    );
  }
}
