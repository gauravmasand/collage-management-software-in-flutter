import 'package:collagemanagementsystem/screens/HomePage.dart';
import 'package:collagemanagementsystem/screens/Welcome.dart';
import 'package:collagemanagementsystem/utils/FireRealTime.dart';
import 'package:collagemanagementsystem/utils/UserSimplePreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/CourcesModel.dart';
import '../screens/MessageScreen.dart';

class FireAuth {
  static void signupAdmin({
        required BuildContext context,
        required String collageName,
        required String email,
        required String pass,
        required String courseCount,
        required String roomCount,
        required String labsCount,
        required List<CoursesModel> coursesModel
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      ).whenComplete(() {
        if (FirebaseAuth.instance.currentUser?.uid.toString() == null) {
        } else {
          UserSimplePreferences.setCollageCode(FirebaseAuth.instance.currentUser!.uid.toString());
          UserSimplePreferences.setPosition("Admin");
          FireRealtime.uploadCollageData(context, FirebaseAuth.instance.currentUser?.uid.toString(), collageName, email, pass, courseCount, roomCount, labsCount, coursesModel);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      } else {
        Fluttertoast.showToast(msg: e.code);
      }
    } catch (e) {
      print(e);
    }
  }

  static void signupStaff ({
    required BuildContext context,
    required String collageCode,
    required String name,
    required String email,
    required String password,
    required String position
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).whenComplete(() {
        if (FirebaseAuth.instance.currentUser?.uid.toString() == null) {
        } else {
          UserSimplePreferences.setCollageCode(collageCode);
          UserSimplePreferences.setPosition(position);
          print("name1: "+name);
          FireRealtime.validateCollageCode(context, FirebaseAuth.instance.currentUser?.uid.toString(), collageCode, name, email, password, position);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      } else {
        Fluttertoast.showToast(msg: e.code);
      }
    } catch (e) {
      print(e);
    }
  }

  static void login(BuildContext context, String collageCode, String email, String pass) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('collage/$collageCode').get();
    if (snapshot.exists) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass,
        ).whenComplete(() async {
          if ((FirebaseAuth.instance.currentUser)!=null) {
            UserSimplePreferences.setCollageCode(collageCode);
            // TODO: Getting collage code from server and saving collage code in shared preferences
            String? uid = FirebaseAuth.instance.currentUser!.uid;
            if (uid==collageCode) {
              UserSimplePreferences.setPosition("Admin");
              performLogin(context, ref, collageCode);
            } else {
              final snapshot1 = await ref.child('collage/$collageCode/staff/$uid/position').get();
              if (snapshot1.exists) {
                UserSimplePreferences.setPosition(snapshot1.value.toString());
                performLogin(context, ref, collageCode);
              } else {
                Fluttertoast.showToast(msg: "Something went wrong please try again later");
              }
            }
          }
        });
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'user-not-found') {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Invalid credentials");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Wrong password provided for that user.");
          print('Wrong password provided for that user.');
        } else {
          Fluttertoast.showToast(msg: e.code);
        }
      }
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Invalid collage code");
    }
  }

  static void performLogin(BuildContext context, ref, collageCode) async {
    String currentUid = FirebaseAuth.instance.currentUser!.uid.toString();
    final snapshot0 = await ref.child('collage/$currentUid').get();
    if (snapshot0.exists) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>
              HomePage()), (Route<dynamic> route) => false);
    } else {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      final snapshot1 = await ref.child('collageStaff/$collageCode/$uid').get();
      print("snapshot1.value");
      print(snapshot1.value);
      if (snapshot1.value==true) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            HomePage()), (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            MessageScreen(msg: "You have to wait until collage admin accept the request")), (Route<dynamic> route) => false);
      }
    }
  }

  static void logout(BuildContext context) async {
    await UserSimplePreferences.deleteAllData();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        WelcomeScreen()), (Route<dynamic> route) => false);

  }
}