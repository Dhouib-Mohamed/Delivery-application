import 'package:flutter/material.dart';

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
      child: SizedBox(
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
  final String url, name, location;
  const FeedElement(
      {Key? key, required this.url, required this.name, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
            height: 214,
            width: 328,
            child: Row(
              children: [
                SizedBox(
                  child: Image.network(url, width: 328, height: 160),
                ),
                Column(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Color(0x008e8e93),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class ListElement extends StatelessWidget {
  final String url, name, location;
  const ListElement(
      {Key? key, required this.url, required this.name, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
            height: 214,
            width: 240,
            child: Row(
              children: [
                SizedBox(
                  child: Image.network(url, width: 240, height: 160),
                ),
                Column(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Color(0x008e8e93),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
