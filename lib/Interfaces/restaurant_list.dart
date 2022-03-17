import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Widgets/contents.dart';
import '../../models.dart';

class RestaurantList extends StatefulWidget {
  final String text;
  final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
  const RestaurantList({Key? key, required this.text, required this.snapshot})
      : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: Text(
          widget.text,
          style: const TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: StreamBuilder(
              stream:
                  widget.snapshot,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: 
                        Column(
                            children: snapshot.data!.docs.map((document) {
                          RestaurantModel r =
                              RestaurantModel.fromJson(document.data());
                          return FeedElement(
                            restaurant: r,
                            id: document.reference.id,
                          );
                        }).toList()),
                  );
                }
              }),
        ),
      ),
    );
  }
}
