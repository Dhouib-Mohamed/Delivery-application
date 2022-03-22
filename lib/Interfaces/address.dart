import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models.dart';
import 'address_map.dart';

class Address extends StatelessWidget {
  Address({Key? key}) : super(key: key);

  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xffbd2005),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              "My Addresses",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "You can choose your preferred location by dragging it to the top",
              maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w300),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/feed');
          },
        ),
      ),
      floatingActionButton: TextButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(170, 48)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                side: BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ))),
          onPressed: () {
            Navigator.pushNamed(context, "/map");
          },
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.add_location_alt,
                size: 30,
                color: Colors.black,
              ),
            ),
            Text(
              "Add Location",
              style: TextStyle(color: Colors.black, fontSize: 15),
            )
          ])),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("addresses")
              .orderBy("selected",descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              x = 0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 65),
                child: ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) async {
                      print(newIndex);
                      if(oldIndex!=newIndex){
                      if (newIndex == 0) {
                        await updateSelected(oldIndex, newIndex);
                      }
                    }
                  },
                      children: snapshot.data!.docs.map((document) {
                        AddressModel address =
                            AddressModel.fromJson(document.data());
                        address.description = address.getLocation();
                        x++;
                        return AddressWidget(key: ValueKey("$x"),address: address, x: x, document: document,);}).toList(),
                    ),
              );
            }
          }),
    );
  }
}

class AddressWidget extends StatelessWidget {
  final AddressModel address;
  final int x;
  final QueryDocumentSnapshot document;


  const AddressWidget({Key? key, required this.address, required this.x, required this.document}) : super(key: key);

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
                            location: address.location)));
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.location_on,color: Color(0xffbd2005),),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          address.selected?
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 15),
                            child: Text(
                              "Selected Address",
                              style: TextStyle(
                                color: Color(0xffbd2005),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ):const SizedBox(),
                          Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 17),
                                child: FutureBuilder<String>(
                                    future: address.description,
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
                    Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: IconButton(
                        iconSize: 35,
                          onPressed: () {
                            removeAdress(document.id,address.selected);
                          },
                        icon: const Icon(Icons.highlight_remove),),
                    ),
                  ],
                ),
              ),
            ))
    );
  }
}
removeAdress(String id,bool selected) async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("addresses")
      .doc(id)
      .delete();
  Fluttertoast.showToast(msg: "Address Successfully removed ");
  if(selected) {
    String? id;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("addresses")
        .get()
        .then((value) {
      if(value.size>0)id = value.docs.first.id;
    });
    id==null?
    {}:
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("addresses")
        .doc(id)
        .update({"selected": true});
  }
}
Future<void> updateSelected(int? oldPosition,int? newPosition) async {
  String? oldId;
  String? newId;
  print("hi");
  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("addresses")
      .orderBy("selected",descending: true)
      .get()
      .then((value) {
    oldId =value.docs.elementAt(0).id;
    if(value.size>1){newId = value.docs.elementAt(oldPosition!).id;}
  });
  print(newId);
  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("addresses")
      .doc(oldId)
      .update({"selected":false});
  newId==null?{}:await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("addresses")
      .doc(newId)
      .update({"selected":true});
}



