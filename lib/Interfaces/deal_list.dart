import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Widgets/contents.dart';
import '../../models.dart';
import '../gobals.dart' as globals;

class DealList extends StatefulWidget {
  final String text;
  final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
  const DealList({Key? key, required this.text, required this.snapshot})
      : super(key: key);

  @override
  State<DealList> createState() => _DealListState();
}

class _DealListState extends State<DealList> {
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
      body: Center(
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
                  child: Column(
                      children: snapshot.data!.docs.map((document) {
                        DealModel d =
                        DealModel.fromJson(
                            document.data());
                        return RestaurantElement(
                          deal: d,
                          id: document.reference.id, buttonRole: () { globals.addToCart(d); }, buttonText: 'Add To Cart',
                        );
                      }).toList()),
                );
              }
            }),
      ),
    );
  }
}
