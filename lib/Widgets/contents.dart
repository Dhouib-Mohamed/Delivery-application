import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/Interfaces/restaurant.dart';
import 'package:iac_project/Widgets/tapped.dart';

import '../models.dart';

class RestaurantElement extends StatefulWidget {
  final String buttonText, id;
  final DealModel deal;
  final void Function()? buttonRole;

  const RestaurantElement(
      {Key? key,
      required this.buttonText,
      required this.buttonRole,
      required this.id,
      required this.deal})
      : super(key: key);

  @override
  State<RestaurantElement> createState() => _RestaurantElementState();
}

class _RestaurantElementState extends State<RestaurantElement> {
  String source = "assets/icons/heart.png";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: const Color.fromARGB(255, 232, 237, 240),
          height: 150,
          width: MediaQuery.of(context).size.width * 0.96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(widget.deal.photoUrl, width: 120, height: 120),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 2.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.96 - 135,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.deal.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (source == "assets/icons/heart.png") {
                                setState(() {
                                  source = "assets/icons/heart1.png";
                                });
                                addToSaved(widget.deal);
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
                        ],
                      ),
                      Text(
                        widget.deal.description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.deal.price + " TND",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SimplButton(
                              buttonRole: widget.buttonRole,
                              buttonText: widget.buttonText),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future<void> addToSaved(deal) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("saved")
        .doc()
        .collection("deals")
        .add(deal.toJson());
  }

  removeFromSaved(String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("saved")
        .doc()
        .collection("deals")
        .doc(id)
        .delete();
  }
}

class FeedElement extends StatefulWidget {
  final String id;
  final RestaurantModel restaurant;

  const FeedElement({
    Key? key,
    required this.restaurant,
    required this.id,
  }) : super(key: key);

  @override
  State<FeedElement> createState() => _FeedElementState();
}

class _FeedElementState extends State<FeedElement> {
  String source = "assets/icons/heart.png";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Restaurant(
                        id: widget.id,
                      )))
        },
        child: Container(
            color: const Color.fromARGB(255, 232, 237, 240),
            height: 90,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: [
                Image.network(
                  widget.restaurant.photoUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9 - 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.restaurant.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (source == "assets/icons/heart.png") {
                                setState(() {
                                  source = "assets/icons/heart1.png";
                                });
                                addToSaved(widget.restaurant);
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.restaurant.location.toString(),
                          style: const TextStyle(
                            color: Color(0x008e8e93),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> addToSaved(restaurant) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("saved")
        .doc()
        .collection("restaurants")
        .add(restaurant.toJson());
  }

  removeFromSaved(String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("saved")
        .doc()
        .collection("restaurants")
        .doc(id)
        .delete();
  }
}

class ListElement extends StatefulWidget {
  final RestaurantModel restaurant;
  final String id;
  const ListElement(
      {Key? key,
      required this.id, required this.restaurant})
      : super(key: key);

  @override
  State<ListElement> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  String source = "assets/icons/heart.png";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Restaurant(
                        id: widget.id,
                      )))
        },
        child: Container(
            color: const Color.fromARGB(255, 232, 237, 240),
            height: 240,
            width: 260,
            child: Column(
              children: [
                SizedBox(
                  child: Image.network(
                    widget.restaurant.photoUrl,
                    width: 220,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.restaurant.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (source == "assets/icons/heart.png") {
                          setState(() {
                            source = "assets/icons/heart1.png";
                          });
                          addToSaved(widget.restaurant);
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
                  ],
                ),
                Text(
                  widget.restaurant.location.toString(),
                  style: const TextStyle(
                    color: Color(0x008e8e93),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> addToSaved(restaurant) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("saved")
        .doc()
        .collection("restaurants")
        .add(restaurant.toJson());
  }

  removeFromSaved(String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("saved")
        .doc()
        .collection("restaurants")
        .doc(id)
        .delete();
  }
}
