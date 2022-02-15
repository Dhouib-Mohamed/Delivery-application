import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/contents.dart';
import 'package:iac_project/Widgets/tapped.dart';
import '../models.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);
  @override
  State<Feed> createState() => _Feed();
}

class _Feed extends State<Feed> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  User? user = FirebaseAuth.instance.currentUser;
  late final UserModel loggedInUser;
  Widget locationWidget() {
    bool a = false;
    AddressModel? address;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("addresses")
        .doc()
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        a = true;
        address = AddressModel.fromJson(documentSnapshot.data());
      }
    });
    if (a) {
      return TappedPosition(
          text: "Deliver To :  ",
          tapped: address!.location.toString(),
          role: '/address');
    } else {
      return const TappedPosition(
          text: "", tapped: "Add Location", role: '/address');
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        loggedInUser = UserModel.fromJson(value.data());
      });
    });
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, '/opening');
  }

  void onItem(index) {
    switch (index) {
      case 1:
        setState(() {
          Navigator.pushNamed(context, '/search');
        });
        break;
      case 2:
        setState(() {
          Navigator.pushNamed(context, '/cart');
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
      key: _key,
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItem,
          unselectedLabelStyle: const TextStyle(color: Colors.blueGrey),
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: const Color(0xffbd2005),
          currentIndex: 0,
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
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 100),
          child: GestureDetector(
            onTap: () => {
              setState(() {
                Navigator.pushNamed(context, '/search');
              })
            },
            child: const Input(
              field: 'Search ',
              control: null,
              valid: null,
            ),
          ),
        ),
        title: locationWidget(),
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
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Close Places",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Icon(Icons.arrow_forward_rounded),
                ],
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("restaurants")
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
                          RestaurantModel r =
                              RestaurantModel.fromJson(document.data());
                          return FeedElement(
                            url: r.photoUrl,
                            name: r.name,
                            location: r.location,
                            id: document.reference.id,
                          );
                        }).toList()),
                      );
                    }
                  }),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Popular Restaurants",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Icon(Icons.arrow_forward_rounded),
                ],
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("restaurants")
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
                        child: Row(
                            children: snapshot.data!.docs.map((document) {
                          RestaurantModel r =
                              RestaurantModel.fromJson(document.data());
                          return ListElement(
                            url: r.photoUrl,
                            name: r.name,
                            location: r.location,
                            id: document.reference.id,
                          );
                        }).toList()),
                      );
                    }
                  }),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "All Restaurants",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Icon(Icons.arrow_forward_rounded),
                ],
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("restaurants")
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
                          RestaurantModel r =
                              RestaurantModel.fromJson(document.data());
                          return FeedElement(
                            url: r.photoUrl,
                            name: r.name,
                            location: r.location,
                            id: document.reference.id,
                          );
                        }).toList()),
                      );
                    }
                  }),
            ],
          ),
        ],
      ),
      drawer: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0, right: 10),
              child: Text(
                "${loggedInUser.name[0].toUpperCase()}${loggedInUser.name.substring(1)}",
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
                loggedInUser.email,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const ProfileButton(
                name: "My Profile",
                role: "/profile",
                icon: Icons.account_circle_outlined),
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
      ),
      endDrawer: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.9,
      ),
    );
  }
}
