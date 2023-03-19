import 'dart:ffi';
import 'dart:math';

import 'package:collagemanagementsystem/models/CourcesModel.dart';
import 'package:collagemanagementsystem/screens/HomePage.dart';
import 'package:collagemanagementsystem/screens/MessageScreen.dart';
import 'package:collagemanagementsystem/utils/FireAuth.dart';
import 'package:collagemanagementsystem/utils/UserSimplePreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireRealtime {
  static void uploadCollageData(context, uid, collageName, email, password, courseCount, roomCount, labsCount, List<CoursesModel> coursesModel) async {
    DatabaseReference mainRef = FirebaseDatabase.instance.ref("collage/$uid");

    var collageCode = uid.toString();

    await mainRef.set({
      "uid": uid,
      "collageCode": collageCode,
      "collageName": collageName,
      "password": password,
      "courseCount": courseCount,
      "roomCount": roomCount,
      "labsCount": labsCount,
    }).whenComplete(() async {
      for (int i = 0; i < coursesModel.length; i++) {
        DatabaseReference coursesRef = FirebaseDatabase.instance.ref("collage/$uid/courses/$i");
        await coursesRef.set({
          "courseName" : coursesModel[i].name,
          "courseYear" : coursesModel[i].year
        });
      }
    });
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        HomePage()), (Route<dynamic> route) => false);
  }

  static void validateCollageCode(BuildContext context, String? uid, String collageCode, String name, String email, String password, String position) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('collage/$collageCode/collageCode').get();
    if (snapshot.exists) {
      print("name2: "+name);
      FireRealtime.uploadStaffData(context: context, uid: uid, collageUid: collageCode, collageCode: collageCode, staffName: name, email: email, password: password, position: position);
    } else {
      Fluttertoast.showToast(msg: "invalid collage code");
    }
  }

  static void uploadStaffData({
    required BuildContext context,
    required String? uid,
    required String? collageUid,
    required String collageCode,
    required String staffName,
    required String email,
    required String password,
    required String position,
  }) async {
    String? postKey = uid;

    DatabaseReference reference = FirebaseDatabase.instance.ref("collageStaff/$collageUid");
    await reference.update({
      "$uid": false,
    }).whenComplete(() async {
      DatabaseReference mainRef = FirebaseDatabase.instance.ref("collage/$collageUid/staff/$postKey");
      print("name3: "+staffName);
      await mainRef.set({
        "collageUid": collageUid,
        "uid": uid,
        "collageCode": collageCode,
        "staffName": staffName,
        "email": email,
        "password": password,
        "position": position,
      }).whenComplete(() async {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            MessageScreen(msg: "You have to wait until collage admin accept the request")), (Route<dynamic> route) => false);
      });
    });
  }

  static String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  }

  // static void addNotice ({
  //   required BuildContext context,
  //   String? title,
  //   String? desc,
  //   required String? fileName,
  // }) async {
  //   String? clgCode = UserSimplePreferences.getCollageCode();
  //   DatabaseReference reference = FirebaseDatabase.instance.ref("collage/${clgCode}/notices/${DateTime.now().millisecondsSinceEpoch.toString()}");
  //
  //   await reference.set({
  //     "uid" : FirebaseAuth.instance.currentUser?.uid,
  //     "title" : title,
  //     "desc" : desc,
  //     "fileName" : fileName
  //   }).whenComplete(() => () {
  //     Navigator.pop(context);
  //   });
  // }

  static void addEvents ({
    required BuildContext context,
    String? title,
    String? desc,
    required String? fileName,
  }) async {
    String? clgCode = UserSimplePreferences.getCollageCode();
    DatabaseReference reference = FirebaseDatabase.instance.ref("collage/${clgCode}/events/${DateTime.now().millisecondsSinceEpoch.toString()}");

    await reference.set({
      "uid" : FirebaseAuth.instance.currentUser?.uid,
      "title" : title,
      "desc" : desc,
      "fileName" : fileName
    }).whenComplete(() => () {
      Navigator.pop(context);
    });
  }

}