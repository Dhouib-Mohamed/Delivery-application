import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/Interfaces/restaurant.dart';

class SimplAppBar extends AppBar {
  final String text;
  final BuildContext context;
  SimplAppBar({
    Key? key,
    required this.text,
    required this.context,
  }) : super(
          key: key,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black87,
                size: 22,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'inter',
                fontWeight: FontWeight.bold,
              )),
        );
}

class RestaurantElement extends StatelessWidget {
  final String url, description, name, price;
  const RestaurantElement(
      {Key? key,
      required this.url,
      required this.description,
      required this.name,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Color.fromARGB(255, 232, 237, 240),
          height: 110,
          child: Row(
            children: [
              Image.network(url, width: 64, height: 64),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 2.0),
                child: Column(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Color(0x008e8e93),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      price + "\$",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class FeedElement extends StatelessWidget {
  final String url, name;
  final GeoPoint location;
  final id;
  const FeedElement(
      {Key? key,
      required this.url,
      required this.name,
      required this.location,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: GestureDetector(
          onTap: () =>
              {Navigator.push(context,MaterialPageRoute(builder: (context) => Restaurant(id: id,)))},
          child: Container(
              color: Color.fromARGB(255, 232, 237, 240),
              height: 90,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: [
                  SizedBox(
                    child: Image.network(
                      url,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          location.toString(),
                          style: const TextStyle(
                            color: Color(0x008e8e93),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class ListElement extends StatelessWidget {
  final GeoPoint location;
  final String name, url;
  final id;
  const ListElement(
      {Key? key,
      required this.url,
      required this.name,
      required this.location,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: GestureDetector(
          onTap: () =>
          {Navigator.push(context,MaterialPageRoute(builder: (context) => Restaurant(id: id,)))},
          child: Container(
              color: const Color.fromARGB(255, 232, 237, 240),
              height: 240,
              width: 260,
              child: Column(
                children: [
                  SizedBox(
                    child: Image.network(
                      url,
                      width: 220,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    location.toString(),
                    style: const TextStyle(
                      color: Color(0x008e8e93),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
