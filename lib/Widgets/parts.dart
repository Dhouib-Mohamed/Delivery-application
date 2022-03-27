import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/tapped.dart';
import 'package:iac_project/models.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../Interfaces/filter.dart';

class BotBar extends StatefulWidget {
  final int i;

   const BotBar({Key? key, required this.i})
      : super(key: key);
  @override
  State<BotBar> createState() => _BotBarState();
}

class _BotBarState extends State<BotBar> {

  User? user = FirebaseAuth.instance.currentUser;
  late final UserModel loggedInUser;
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
  void onItem(index) {
    if (index != widget.i) {
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
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: onItem,
        unselectedLabelStyle: const TextStyle(color: Colors.blueGrey),
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: const Color(0xffbd2005),
        currentIndex: widget.i,
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
        ]);
  }
}

class EndDrawer extends StatefulWidget {
  String? sort;

  double? maxPrice ;

  double? minPrice ;

  List<String>? restaurants;

  List<String>? categories;

  EndDrawer({Key? key ,this.sort,this.maxPrice,this.minPrice,this.categories,this.restaurants}) : super(key: key);

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  void addToRestaurants(String value) {
      widget.restaurants?.add(value);
  }
  void addToCategories(String value) {
      widget.categories?.add(value);
  }
  void removeFromRestaurants(String value) {
    widget.restaurants?.remove(value);
  }

  void removeFromCategories(String value) {
    widget.categories?.remove(value);
  }

  double getMaxPrice() {
    double x = 19.2;
    return x;
  }

  setMaxPrice(double x) {
    widget.maxPrice = x;
  }

  double getMinPrice() {
    double x = 5.3;
    return x;
  }

  setMinPrice(double x) {
    widget.minPrice = x;
  }

  setSortIcon(String name) {
    widget.sort = name;
  }

  setSort(SortIcon x) {
    widget.sort = x.text;
    setState(() {
      x.color = const Color(0xffbd2005);
    });
  }

  Color setColor(String s) {
    return (s == widget.sort) ? const Color(0xffbd2005) : Colors.blueGrey;
  }

  @override
  void initState() {
    if (widget.maxPrice == null) {
      setMaxPrice(getMaxPrice());
    }
    if (widget.minPrice == null) {
      setMinPrice(getMinPrice());
    }
    widget.restaurants ??= [];
    widget.categories ??= [];
    widget.sort ??= 'Name';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.93,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 18, left: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sort by",
                    style: TextStyle(fontSize: 22),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setMaxPrice(getMaxPrice());
                        setMinPrice(getMinPrice());
                        widget.restaurants = [];
                        widget.categories = [];
                        widget.sort = 'Name';
                      });
                    },
                    child: const Text(
                      "Reset all",
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: Color(0xffbd2005),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SortIcon(
                  text: 'Name',
                  icon: const AssetImage("assets/icons/name.png"),
                  setSort: setSort,
                  color: setColor('Name'),
                ),
                SortIcon(
                  text: 'Rating',
                  icon: const AssetImage("assets/icons/rating.png"),
                  setSort: setSort,
                  color: setColor('Rating'),
                ),
                SortIcon(
                  text: 'Delivery Time',
                  icon: const AssetImage("assets/icons/timer.png"),
                  setSort: setSort,
                  color: setColor('Delivery Time'),
                ),
                SortIcon(
                  text: 'Price',
                  icon: const AssetImage("assets/icons/price.png"),
                  setSort: setSort,
                  color: setColor('Price'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Filter by",
                style: TextStyle(fontSize: 22),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Budget",
                style: TextStyle(fontSize: 18),
              ),
            ),
        Padding(
          padding: const EdgeInsets.only(top:15,bottom: 20),
          child: SfRangeSlider(
            activeColor: const Color(0xffbd2005),
            inactiveColor: Colors.blueGrey,
            values: SfRangeValues(widget.minPrice??0,widget.maxPrice??0),
            max: getMaxPrice().round()%2==0?getMaxPrice().round():getMaxPrice().round()+1,
            min: getMinPrice().round()%2==0?getMinPrice().round():getMinPrice().round()-1,
            showLabels: true,
            stepSize: 1,
            interval: 2,
            showTicks: true,
            minorTicksPerInterval: 1,
            labelFormatterCallback: (dynamic actualValue, String formattedText) {
              return "$formattedText ";
            },
            onChanged: (SfRangeValues values) {
              setState(() {
                widget.minPrice = values.start;
                widget.maxPrice = values.end;
              });
            },
          ),
        ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Restaurants",
                style: TextStyle(fontSize: 18),
              ),
            ),
            RestaurantFlex(
                list: widget.restaurants!,
                removeFromList: removeFromRestaurants,
                addToList: addToRestaurants),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Category",
                style: TextStyle(fontSize: 18),
              ),
            ),
            CategoryFlex(
                list: widget.categories!,
                removeFromList: removeFromCategories,
                addToList: addToCategories),
            ColoredButton(
              width: 220,
              name: "Get Results",
              role: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Filter()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SortIcon extends StatelessWidget {
  SortIcon(
      {Key? key,
      required this.icon,
      required this.text,
      required this.color,
      required this.setSort})
      : super(key: key);
  final ImageProvider icon;
  final String text;
  final Function(SortIcon) setSort;
  Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 50,
      child: Column(
        children: [
          IconButton(
              onPressed: () {
                setSort(this);
              },
              icon: ImageIcon(
                icon,
                size: 30,
                color: color,
              )),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}

class RestaurantFlex extends StatelessWidget {
  final List<String> list;
  final void Function(String) removeFromList;
  final void Function(String) addToList;
  const RestaurantFlex(
      {Key? key,
      required this.list,
      required this.removeFromList,
      required this.addToList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("restaurants").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                direction: Axis.horizontal,
                children: snapshot.data!.docs.map((e) {
                  return FlexListElement(
                    text: e.get("name"),
                    list: list,
                    addToList: addToList,
                    removeFromList: removeFromList,
                    backgroundColor: (list.contains(e.get("name")))
                        ? const Color(0xffbd2005)
                        : Colors.white,
                    textColor: (list.contains(e.get("name")))
                        ? Colors.white
                        : Colors.black,
                  );
                }).toList(),
              ),
            );
          }
        });
  }
}

class CategoryFlex extends StatelessWidget{
  final List<String> list;

  final void Function(String) removeFromList;
  final void Function(String) addToList;

  CategoryFlex({Key? key, required this.list, required this.removeFromList, required this.addToList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore
            .instance
            .collection('restaurants')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                  children: snapshot.data!.docs.map((document) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("restaurants")
                        .doc(document.reference.id)
                        .collection('category')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Wrap(
                            children: snapshot.data!.docs.map((document) {
                            return FlexListElement(
                              text: document.get("name"),
                              list: list,
                              addToList: addToList,
                              removeFromList: removeFromList,
                              backgroundColor:
                                  (list.contains(document.get("name")))
                                      ? const Color(0xffbd2005)
                                      : Colors.white,
                              textColor: (list.contains(document.get("name")))
                                  ? Colors.white
                                  : Colors.black,
                            );
                        }).toList());
                      }
                    });
              }).toList()),
            );
          }
        });
  }
}
class FlexListElement extends StatefulWidget{

  final String text;
  final List<String> list;
  final void Function(String) addToList ;
  final void Function(String) removeFromList ;
  Color backgroundColor;
  Color textColor ;

  FlexListElement({Key? key, required this.text,required this.textColor,required this.backgroundColor,required this.list, required this.addToList, required this.removeFromList}) : super(key: key);

  @override
  State<FlexListElement> createState() => _FlexListElementState();
}

class _FlexListElementState extends State<FlexListElement> {

  setList() {
    if(widget.list.contains(widget.text)) {
      widget.removeFromList(widget.text);
    } else {
      widget.addToList(widget.text);
    }
  }

  setColor() {
    widget.backgroundColor = (widget.list.contains(widget.text))
        ? const Color(0xffbd2005)
        : Colors.white;
    widget.textColor =
        (widget.list.contains(widget.text)) ? Colors.white : Colors.black;
  }

  @override
  void initState() {
    setColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 4, right: 2),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(widget.backgroundColor),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: Colors.blueGrey))),
        ),
        onPressed: () {
          setList();
          setState(() {
            setColor();
          });
        },
        child: Text(
          widget.text,
          maxLines: 1,
          style: TextStyle(color: widget.textColor),
        ),
      ),
    );
  }
}
