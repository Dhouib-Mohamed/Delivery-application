import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/parts.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('restaurants/*/deals').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              print("hello");
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SingleChildScrollView(
                  child: Center(),
                  );
            }
          }),
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.blueGrey,
            onPressed: () {
              _key.currentState!.openEndDrawer();
            },
            icon: const Icon(
              Icons.wrap_text_rounded,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "Filter",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      bottomNavigationBar: const BotBar(i: 1),
      endDrawer: EndDrawer(),
    );
  }
}
