import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItem,
          unselectedLabelStyle: const TextStyle(color: Colors.blueGrey),
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: const Color(0xffbd2005),
          currentIndex: 2,
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
          "Cart",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
