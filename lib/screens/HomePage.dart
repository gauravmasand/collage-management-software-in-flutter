import 'package:collagemanagementsystem/screens/AdminHomeScreen.dart';
import 'package:collagemanagementsystem/screens/OfficeStaffHomeScreen.dart';
import 'package:collagemanagementsystem/screens/TeachingStaffHomeScreen.dart';
import 'package:collagemanagementsystem/utils/UserSimplePreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MessageScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseDatabase.instance.ref();

  void validateUser() async {
    print("Collage code is: ");
    print(UserSimplePreferences.getCollageCode());
    String? collageCode = await UserSimplePreferences.getCollageCode();
    String? currentUid = FirebaseAuth.instance.currentUser?.uid;

    final snapshot0 = await ref.child('collage/$currentUid').get();
    if (!snapshot0.exists) {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      final snapshot1 = await ref.child('collageStaff/$collageCode/$uid').get();
      if (snapshot1.value == true) {

      } else if (snapshot1.value == false) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                MessageScreen(
                    msg: "You have to wait until collage admin accept the request")), (
            Route<dynamic> route) => false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    validateUser();
  }

  showActualHomePage() {
    String? position = UserSimplePreferences.getPosition();
    if (position=="Admin") {
      return AdminHomeScreen();
    } else if (position=="Office Staff") {
      return OfficeStaffHomeScreen();
    } else if (position=="Teaching Staff") {
      return TeachingStaffHomeScreen();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return showActualHomePage();
  }
}
