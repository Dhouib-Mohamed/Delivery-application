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
