import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iac_project/Widgets/tapped.dart';
import 'package:iac_project/models.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../Interfaces/address_map.dart';
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
    double x=19.2;
    return x;
  }
  setMaxPrice(double x) {
      widget.maxPrice = x;
  }

  double getMinPrice() {
    double x=5.3;
    return x;
  }
  setMinPrice(double x) {
      widget.minPrice = x;
  }
  setSortIcon(String name) {
          widget.sort = name;
  }

  String? getSort() {return widget.sort;}
  @override
  void initState() {
    setMaxPrice(getMaxPrice());
    setMinPrice(getMinPrice());
    widget.restaurants ??= [];
    widget.categories ??= [];

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
              padding: const EdgeInsets.only(top: 20,bottom: 18,left: 10,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sort by",
                    style: TextStyle(
                        fontSize: 22
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                        setMaxPrice(getMaxPrice());
                        setMinPrice(getMinPrice());
                        widget.restaurants ??= [];
                        widget.categories ??= [];
                        widget.sort = null;
                    },
                    child: const Text(
                      "Reset all",
                      style: TextStyle(
                        fontFamily: "Inter",
                        color:Color(0xffbd2005),
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
                SortIcon(text: 'Name', icon: const AssetImage("assets/icons/name.png"), getSort: getSort,setSortIcon: setSortIcon,),
                SortIcon(text: 'Rating', icon: const AssetImage("assets/icons/rating.png"), getSort: getSort,setSortIcon: setSortIcon,),
                SortIcon(text: 'Delivery Time', icon: const AssetImage("assets/icons/timer.png"), getSort: getSort,setSortIcon: setSortIcon,),
                SortIcon(text: 'Price', icon: const AssetImage("assets/icons/price.png"), getSort: getSort,setSortIcon: setSortIcon,),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Filter by",
                style: TextStyle(
                    fontSize: 22
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Budget",
                style: TextStyle(
                    fontSize: 18
                ),
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
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            ),
            RestaurantFlex(list: widget.restaurants!, removeFromList: removeFromRestaurants, addToList: addToRestaurants),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Category",
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            ),
            CategoryFlex(list: widget.categories!, removeFromList: removeFromCategories, addToList: addToCategories),
            Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 13),
                child: Center(
                  child: OutlinedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(const Size(220, 48)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xffbd2005)),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ))),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>const Filter()));
                      },
                      child: const Text(
                        "Get Results",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}

class SortIcon extends StatefulWidget{
  const SortIcon({Key? key, required this.icon, required this.text, required this.getSort, required this.setSortIcon}) : super(key: key);
  final ImageProvider icon;
  final String text;
  final String? Function() getSort;
  final void Function(String) setSortIcon ;

  @override
  State<SortIcon> createState() => _SortIconState();

}

class _SortIconState extends State<SortIcon> {
  late Color color ;
  setColor() {
    String? x = widget.getSort();
    color = (x??"")==widget.text?const Color(0xffbd2005):Colors.blueGrey;
  }
  @override
  void initState() {
    super.initState();
    setColor();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 50,
      child: Column(
        children: [
          IconButton(
              onPressed: (){
                  widget.setSortIcon(widget.text);
                  setState(() {
                  setColor();
                });},
              icon: ImageIcon(widget.icon,size: 30,color: color,)),
          Flexible(
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 14
                ),
              ),)
        ],
      ),
    );
  }
}
class RestaurantFlex extends StatelessWidget{
  final List<String> list;

  final void Function(String) removeFromList;
  final void Function(String) addToList;
  const RestaurantFlex({Key? key, required this.list, required this.removeFromList, required this.addToList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore
          .instance
          .collection("restaurants")
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return FlexListElement(text: e.get("name"), list: list, addToList: addToList, removeFromList: removeFromList);
            }).toList(),
          ),
        );}
      }
    );
  }
}

class CategoryFlex extends StatelessWidget{
  final List<String> list;

  final void Function(String) removeFromList;
  final void Function(String) addToList;

  List<String> categories = [];
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
                                children: snapshot.data!.docs
                                    .map((document) {
                                    if(!categories.contains(document.get("name"))) {
                                      categories.add(document.get("name"));
                                      return FlexListElement(text: document.get("name"),
                                        list: list,
                                        addToList: addToList,
                                        removeFromList: removeFromList);}
                                    else {return const SizedBox();}
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

  const FlexListElement({Key? key, required this.text,required this.list, required this.addToList, required this.removeFromList}) : super(key: key);

  @override
  State<FlexListElement> createState() => _FlexListElementState();
}

class _FlexListElementState extends State<FlexListElement> {
  late Color backgroundColor ;

  late Color textColor ;

  setColor() {
    if(widget.list.contains(widget.text)) {
      backgroundColor=const Color(0xffbd2005);
      textColor=Colors.white;
    } else {
      backgroundColor=Colors.white;
      textColor=Colors.black;
    }
  }
  setList() {
    if(widget.list.contains(widget.text)) {
      widget.removeFromList(widget.text);
    } else {
      widget.addToList(widget.text);
    }
  }
  @override
  void initState() {
    super.initState();
    setColor();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,top: 4,bottom: 4,right:2),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
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
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
class AddressWidget extends StatefulWidget {
  final AddressModel address;
  final int x;
  final QueryDocumentSnapshot document;
  const AddressWidget({Key? key, required this.address, required this.x, required this.document}) : super(key: key);

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressMap(
                            location: widget.address.location)));
              },
              child: Container(
                color: widget.address.selected?const Color(0xffbd2005):const Color(0xaaeee3e3),
                height: 90,
                width: MediaQuery.of(context).size.width *
                    0.95,
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0),
                          child: Text(
                            "ADDRESS ${widget.x} :",
                            style: TextStyle(
                              color: widget.address.selected?Colors.white:Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SimplButton(
                            buttonRole: () {
                              removeAdress(widget.document.id);
                            },
                            buttonText: "Remove address"),
                      ],
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0),
                        child: FutureBuilder<String>(
                            future: widget.address.description,
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.data??"",
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
    );
  }

  removeAdress(String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("addresses")
        .doc(id)
        .delete();
    Fluttertoast.showToast(msg: "Address Successfully removed ");
  }
}
