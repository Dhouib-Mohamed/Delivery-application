import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Widgets/tapped.dart';
import '../models.dart';

enum SingingCharacter { delivery, card }

class Checkout extends StatefulWidget {
  final num price;
  final num deliveryPrice;
  const Checkout({Key? key, required this.price, required this.deliveryPrice}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Color c = const Color.fromARGB(255, 232, 237, 240);
  bool b = false;
  SingingCharacter? _character = SingingCharacter.delivery;

  final TextEditingController cardNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? cardNumberValidator(String? value) {
    RegExp regex = RegExp('^[0-9]{16}');
    if (value!.isEmpty) {
      return ("Card Number is required for login");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid Card Number");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 17,top: 20,right: 5,bottom:20),
              child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("addresses")
                        .orderBy("selected")
                        .limit(1)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        b = true;
                        AddressModel address =
                        AddressModel.fromJson(snapshot.data!.docs.first.data());
                        address.description = address.getLocation();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom:20),
                                  child: Text(
                                    "Delivery Address",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500
                                      ,)
                                    ,),
                                ),
                                FutureBuilder<String>(
                                    future: address.description,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ?? "",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,left: 4),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/address');},
                                    icon:const ImageIcon(AssetImage("assets/icons/change.png")),
                                  ),
                            ),
                          ],
                        );
                      } else {
                        return const TappedPosition(
                            text: "",
                            tapped: "Please add a location to continue",
                            role: '/address');
                      }
                    }),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 8,
                color: const Color(0xD7DAE0E3),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom:20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 17,bottom:20,right: 5),
                    child: Text(
                      "Delivery Instructions",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                        ,)
                      ,),
                  ),
                 Padding(
                   padding: EdgeInsets.only(left: 17,bottom:20,right: 5),
                   child: Text(
                          "Let us know if you have specific things in mind",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),),
                  Input(field: "e.g. I am home around 10 pm"),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: const Color(0xD7DAE0E3),
            ),
       Padding(
         padding: const EdgeInsets.only(top: 20,bottom:20),
         child: Column(
           crossAxisAlignment:
           CrossAxisAlignment.start,
           mainAxisAlignment:
           MainAxisAlignment.spaceAround,
           children: [
             const Padding(
               padding: EdgeInsets.only(left: 17,bottom:20,right: 5),
               child: Text(
                 "Payment Method",
                 style: TextStyle(
                   fontSize: 22,
                   fontWeight: FontWeight.w500
                   ,)
                 ,),
             ),
             Column(
               children: <Widget>[
                 Row(
                   children: [
                     Radio<SingingCharacter>(
                       activeColor: const Color(0xffbd2005),
                       value: SingingCharacter.delivery,
                       groupValue: _character,
                       onChanged: (SingingCharacter? value) {
                         setState(() {
                           _character = value;
                         });
                       },
                     ),
                     const Text(
                       "Pay At delivery",
                       style: TextStyle(
                         fontSize: 18,
                         fontWeight: FontWeight.w300,
                       ),
                     )
                   ],
                 ),
                 Row(
                   children: [
                     Radio<SingingCharacter>(
                       activeColor: const Color(0xffbd2005),
                       value: SingingCharacter.card,
                       groupValue: _character,
                       onChanged: (SingingCharacter? value) {
                         setState(() {
                           _character = value;
                         });
                       },
                     ),
                     const Text(
                       "Pay With Bank card",
                       style: TextStyle(
                         fontSize: 18,
                         fontWeight: FontWeight.w300,
                       ),
                     )
                   ],
                 ),
               ],
             ),
             (_character==SingingCharacter.card)?
             Form(
               key: _formKey,
                 child: Input(field: 'CardNumber',control: cardNumberController,valid: cardNumberValidator,)):
             const SizedBox(),
           ],
         ),
       ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: const Color(0xD7DAE0E3),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom:40),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 17,bottom:20,right: 5),
                    child: Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                        ,)
                      ,),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('cart')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                                children: snapshot.data!.docs.map((document) {
                                  DealModel d = DealModel.fromJson(document.data());
                                  return Container(
                                    width: MediaQuery.of(context).size.width,

                                    decoration: const BoxDecoration(
                                      border: Border(bottom :BorderSide(color: Colors.blueGrey,width: 0.3))
                                    ),
                                    padding: const EdgeInsets.only(left: 17,bottom:20,right: 10,top: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          d.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),),
                                        Text(
                                          "${d.price} DT",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList());
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(left: 17,bottom:40,right: 10,top: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Delivery Fee",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),),
                        Text(
                          "${widget.deliveryPrice} DT",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17,top: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.price} DT",
                          style: const TextStyle(
                            color: Color(0xffbd2005),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                          ColoredButton(
                            name: "Order Now",
                            width: 170,
                            color: const Color(0xffbd2005),
                            role: () async {
                            if (_formKey.currentState?.validate()??true) {
                              print('ho');
                              if(b){
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("cart")
                                  .get()
                                  .then((value) {
                                for (var element in value.docs) {
                                  element.reference.delete();
                                }
                              });
                              Navigator.pushNamed(context, '/end_order');
                            }
                              else {Fluttertoast.showToast(msg: "Please add an address");}
                          }
                        },),
                      ],

                    ),
                  )

                ],
              ),
            ),

          ],
        ),
    );
  }
}