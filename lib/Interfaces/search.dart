import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/Interfaces/restaurant.dart';
import 'package:iac_project/Widgets/parts.dart';
import 'package:search_widget/search_widget.dart';
import '../models.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("restaurants").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SearchWidget<RestaurantModel>(
                    onItemSelected: ((item) {
                    }),
                    selectedItemBuilder: (item, deleteSelectedItem) {
                      return const Center();
                    },
                    dataList: snapshot.data!.docs.map((document) {
                      RestaurantModel r =
                          RestaurantModel.fromJson(document.data());
                      r.id = document.reference.id;
                      return r;
                    }).toList(),
                    hideSearchBoxWhenItemSelected: false,
                    popupListItemBuilder: (item) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Restaurant(
                                          restaurant: item,
                                          id: item.id!,
                                        )))
                          },
                          child: SizedBox(
                              height: 50,
                              width:MediaQuery.of(context).size.width *0.95,
                              child: Row(
                                children: [
                                  Image.network(
                                    item.photoUrl,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                    listContainerHeight:
                        MediaQuery.of(context).size.height * 0.5,
                    queryBuilder: (query, list) {
                      return list
                          .where((item) => item.name
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    },
                    noItemsFoundWidget: const Text("No Items Found"),
                  ));
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
          "Search",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      bottomNavigationBar: const BotBar(i: 1),
      endDrawer: EndDrawer(),
    );
  }
}
