import 'package:flutter/material.dart';

import '../Widgets/tapped.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void onItem(index) {
    switch (index) {
      case 0:
        setState(() {
          Navigator.pushNamed(context, '/feed');
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
      body: Row(
        children: const [
          Expanded(
            child: FeedInput(
              field: 'Search ',
              control: null,
              valid: null,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItem,
          unselectedLabelStyle: const TextStyle(color: Colors.blueGrey),
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: const Color(0xffbd2005),
          currentIndex: 1,
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
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
    );
  }
}
