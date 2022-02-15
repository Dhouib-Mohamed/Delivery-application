import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  void onItem(index) {
    switch (index) {
      case 0:
        setState(() {
          Navigator.pushNamed(context, '/feed');
        });
        break;
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
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "Saved Items",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItem,
          unselectedLabelStyle: const TextStyle(color: Colors.blueGrey),
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: const Color(0xffbd2005),
          currentIndex: 3,
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
    );
  }
}
