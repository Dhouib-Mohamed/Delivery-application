library globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iac_project/models.dart';

bool? signedIn;
UserModel? user;
getsign() async {
  await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      signedIn = value.data()!["autoSigned"];
    });
}
