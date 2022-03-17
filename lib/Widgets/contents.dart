import 'package:flutter/material.dart';
import 'package:iac_project/Interfaces/restaurant.dart';
import 'package:iac_project/Widgets/tapped.dart';
import '../models.dart';
import '../globals.dart' as globals;

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
  Future<void> setDealSource(String photoUrl) async {

        if (await globals.exist("savedDeals", photoUrl)) {
          setState(() {
            source = "assets/icons/heart1.png";
          });}
          else {setState(() {
          source = "assets/icons/heart.png";
        });}

  }

  @override
  void initState() {
    super.initState();
    setDealSource(widget.deal.photoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 232, 237, 240),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          height: 150,
          width: MediaQuery.of(context).size.width * 0.96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(widget.deal.photoUrl, width: 110, height: 110),
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
                            onTap: () async {
                              if (source == "assets/icons/heart.png") {
                                setState(() {
                                  source = "assets/icons/heart1.png";
                                });
                                globals.addDealToSaved(widget.deal);
                              } else {
                                setState(() {
                                  source = "assets/icons/heart.png";
                                });
                                globals.removeDealFromSaved(widget.id);
                              }
                            },
                            child: FutureBuilder<void>(
                              future: setDealSource(widget.deal.photoUrl),
                              builder: (context, snapshot) {
                                return ImageIcon(
                                  AssetImage(source),
                                  color: const Color(0xffbd2005),
                                );
                              }
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
                            "${widget.deal.price} TND",
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
  String source ="assets/icons/heart.png";
  Future<void> setRestaurantSource(String photoUrl) async {
    if (await globals.exist("savedRestaurants", photoUrl)) {
          setState(() {
            source = "assets/icons/heart1.png";
          });
        }
  else {setState(() {
  source = "assets/icons/heart.png";
  });}
  }

  @override
  void initState() {
    super.initState();
    setRestaurantSource(widget.restaurant.photoUrl);
    widget.restaurant.description = widget.restaurant.getLocation();
  }

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
                    restaurant: widget.restaurant,
                        id: widget.id,
                      )))
        },
        child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 232, 237, 240),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 90,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: [
                Image.network(
                  widget.restaurant.photoUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.fill,
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
                            onTap: () async {
                              if (source == "assets/icons/heart.png") {
                                setState(() {
                                  source = "assets/icons/heart1.png";
                                });
                                globals.addRestaurantToSaved(widget.restaurant);
                              } else {
                                setState(() {
                                  source = "assets/icons/heart.png";
                                });
                                globals.removeRestaurantFromSaved(widget.id);
                              }
                            },
                            child: FutureBuilder<void>(
                              future: setRestaurantSource(widget.restaurant.photoUrl),
                              builder: (context, snapshot) {
                                return ImageIcon(
                                  AssetImage(source),
                                  color: const Color(0xffbd2005),
                                );
                              }
                          ),
                          ),]),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: FutureBuilder<String>(
                            future: widget.restaurant.description,
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.data??"",
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }
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
}

class ListElement extends StatefulWidget {
  final RestaurantModel restaurant;
  final String id;
  const ListElement({Key? key, required this.id, required this.restaurant})
      : super(key: key);

  @override
  State<ListElement> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  late String source = "assets/icons/heart.png";
  Future<void> setRestaurantSource(String photoUrl) async {
    if (await globals.exist("savedRestaurants", photoUrl)) {
      setState(() {
        source = "assets/icons/heart1.png";
      });
    }
    else {setState(() {
      source = "assets/icons/heart.png";
    });}
  }

  @override
  void initState() {
    super.initState();
    setRestaurantSource(widget.restaurant.photoUrl);
    widget.restaurant.description = widget.restaurant.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Restaurant(
                        restaurant: widget.restaurant,
                        id: widget.id,
                      )))
        },
        child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 232, 237, 240),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            height: 240,
            width: 280,
            child: 
            Column(
              children: [
                SizedBox(
                  child: Image.network(
                    widget.restaurant.photoUrl,
                    width: 220,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
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
                        onTap: () async {
                          if (source == "assets/icons/heart.png") {
                            setState(() {
                              source = "assets/icons/heart1.png";
                            });
                            globals.addRestaurantToSaved(widget.restaurant);
                          } else {
                            setState(() {
                              source = "assets/icons/heart.png";
                            });
                            globals.removeRestaurantFromSaved(widget.id);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: FutureBuilder<void>(
                            future: setRestaurantSource(widget.restaurant.photoUrl),
                            builder: (context, snapshot) {
                              return ImageIcon(
                                AssetImage(source),
                                color: const Color(0xffbd2005),
                              );
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: FutureBuilder<String>(
                    future: widget.restaurant.description,
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data??"",
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
