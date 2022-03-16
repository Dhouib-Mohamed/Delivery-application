import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/Interfaces/profile.dart';
import 'package:iac_project/Widgets/contents.dart';
import 'package:iac_project/Widgets/parts.dart';
import 'package:iac_project/Widgets/tapped.dart';
import '../models.dart';
import 'restaurant_list.dart';
import "../gobals.dart" as globals;

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);
  @override
  State<Feed> createState() => _Feed();
}

class _Feed extends State<Feed> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Future<UserModel>? user;
  Future<UserModel>? getUser() async {
    late UserModel user ;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        user = UserModel.fromJson(value.data());
        globals.user = UserModel.fromJson(value.data());
      });
    });
    return user;
  }

  @override
  void initState() {
    user = getUser();
    super.initState();
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, '/opening');
    globals.user = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      bottomNavigationBar: const BotBar(i: 0),
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
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          IconButton(
            color: Colors.blueGrey,
            onPressed: () {
              _key.currentState!.openEndDrawer();
            },
            icon: const Icon(
              Icons.wrap_text_rounded,
              color: Color(0xffbd2005),
            ),
          ),
        ],
        title: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("addresses")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            AddressModel address =
                AddressModel.fromJson(snapshot.data!.docs.first.data());
            address.description=address.getLocation();
            return FutureBuilder<String>(
              future: address.description,
              builder: (context, snapshot) {
                return TappedPosition(
                    text: "Deliver To :  ",
                    tapped: snapshot.data??"",
                    role: '/address');
              }
            );
          } else {
            return const TappedPosition(
                text: "", tapped: "Add Location", role: '/address');
          }
        }),
        leading: IconButton(
          color: Colors.blueGrey,
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Color(0xffbd2005),
          ),
        ),
      ),
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          expandedHeight: 80,
          collapsedHeight: 0,
          pinned: true,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: SearchButton(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("restaurants")
                          .orderBy("location")
                          .limit(3)
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
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          "Close Places",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: IconButton(
                                          icon: const Icon(
                                              Icons.arrow_forward_rounded),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => RestaurantList(
                                                        text: "Close Places",
                                                        snapshot:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "restaurants")
                                                                .orderBy("location")
                                                                .snapshots())));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                    children: snapshot.data!.docs.map((document) {
                                  RestaurantModel r =
                                      RestaurantModel.fromJson(document.data());
                                  return FeedElement(
                                    restaurant: r,
                                    id: document.reference.id,
                                  );
                                }).toList()),
                              ],
                            ),
                          );
                        }
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("restaurants")
                          .orderBy("name")
                          .limit(3)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            "Popular Restaurants",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.arrow_forward_rounded),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => RestaurantList(
                                                          text:
                                                              "Popular Restaurants",
                                                          snapshot:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "restaurants")
                                                                      .orderBy("name")
                                                                  .snapshots())));
                                            },
                                          ),
                                        ),
                                      ]),
                                ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: snapshot.data!.docs.map((document) {
                                      RestaurantModel r =
                                          RestaurantModel.fromJson(document.data());
                                      return ListElement(
                                        restaurant: r,
                                        id: document.reference.id,
                                      );
                                    }).toList()),
                              ),
                            ],
                          );
                        }
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("restaurants")
                          .orderBy("name")
                          .limit(10)
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
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          "All Restaurants",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: IconButton(
                                          icon: const Icon(
                                              Icons.arrow_forward_rounded),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => RestaurantList(
                                                        text: "All Restaurants",
                                                        snapshot:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "restaurants")
                                                                    .orderBy("name")
                                                                .snapshots())));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                    children: snapshot.data!.docs.map((document) {
                                  RestaurantModel r =
                                      RestaurantModel.fromJson(document.data());
                                  return FeedElement(
                                    restaurant: r,
                                    id: document.reference.id,
                                  );
                                }).toList()),
                              ],
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ]),
      drawer: FutureBuilder<UserModel>(
        future: user,
        builder: (context, snapshot) {
          return Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, right: 10),
                  child: Text(
                    "${snapshot.data?.name[0].toUpperCase()}${snapshot.data?.name.substring(1)}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 40),
                  child: Text(
                    snapshot.data!.email,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 32, top: 6, left: 32, bottom: 13),
                  child: OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all(const Size(250, 48)),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Profile(),
                            ));
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(color: Colors.black, fontSize: 17),
                            )
                          ])),
                ),
                const ProfileButton(
                    name: "My Addresses",
                    role: "/address",
                    icon: Icons.location_on),
                const ProfileButton(
                    name: "Settings",
                    role: "/settings",
                    icon: Icons.settings_sharp),
                const ProfileButton(
                    name: "Help & FAQ", role: "/help", icon: Icons.help_rounded),
                Padding(
                    padding: const EdgeInsets.only(top: 100, bottom: 13),
                    child: TextButton(
                        style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(200, 48)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffbd2005)),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ))),
                        onPressed: () {
                          logout(context);
                          Navigator.pushNamed(context, '/opening');
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.power_settings_new,
                                color: Colors.white,
                                size: 30,
                              ),
                              Text(
                                "Log Out",
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              )
                            ])))
              ],
            ),
          );
        }
      ),
      endDrawer: const EndDrawer(),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 32, top: 6, left: 32, bottom: 13),
        child: OutlinedButton(
          style: ButtonStyle(
              alignment: Alignment.centerLeft,
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              fixedSize: MaterialStateProperty.all(const Size(300, 65)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.blueGrey,
                  width: 5,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ))),
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Search",
              style: TextStyle(color: Colors.blueGrey, fontSize: 14),
            ),
          ),
        ));
  }
}
