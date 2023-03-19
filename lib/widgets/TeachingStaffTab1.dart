import 'package:collagemanagementsystem/screens/AddTimeTable.dart';
import 'package:collagemanagementsystem/screens/MarkStudentAttandance.dart';
import 'package:collagemanagementsystem/screens/ShowAttendance.dart';
import 'package:collagemanagementsystem/screens/ShowTimeTable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../screens/StudentList.dart';
import '../utils/UserSimplePreferences.dart';

class TeachingStaffTab1 extends StatefulWidget {
  TeachingStaffTab1({Key? key}) : super(key: key);

  @override
  State<TeachingStaffTab1> createState() => _TeachingStaffTab1State();
}

class _TeachingStaffTab1State extends State<TeachingStaffTab1> {

  late double width;
  late double height;

  // String dummyText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";

  dimension() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    dimension();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Teaching Staff".text.black.make(),
        elevation: 0,
        backgroundColor: Colors.blue.withOpacity(0.1),
      ),
      body: Container(
        color: Colors.blue.withOpacity(0.1),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children:[
            Container(
              width: width,
              height: width*0.85,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.5),
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Container(
                    width: width*0.5-11,
                    height: height*0.38,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 1, color: Colors.grey),
                      )
                    ),
                  child: Container(
                    height: 200,
                    child: FirebaseAnimatedList(
                      primary: false,
                      shrinkWrap: true,
                      query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("announcement").orderByChild('date'),
                      itemBuilder: (context, DataSnapshot snapshot, animation, index) {
                        Map<dynamic, dynamic>? values = snapshot.value as Map?;
                        return specialAnnouncement(values!['announcement']);
                      },
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                  //   child: ListView(
                  //     physics: BouncingScrollPhysics(),
                  //     children: [
                  //       specialAnnouncement(dummyText),
                  //       specialAnnouncement(dummyText),
                  //       specialAnnouncement(dummyText),
                  //       specialAnnouncement(dummyText),
                  //       specialAnnouncement(dummyText),
                  //       specialAnnouncement(dummyText),
                  //       specialAnnouncement(dummyText),
                  //     ],
                  //   ).py(10),
                  ),
                  Divider(),
                  Container(
                    width: width*0.5-30,
                    child: Column(
                      children: [
                        Container(
                          height: height*0.2-1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(width: 0.7),
                            ),
                          ),
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              attendanceItem(per: "75", roll: "15"),
                              attendanceItem(per: "73", roll: "16"),
                              attendanceItem(per: "95", roll: "17"),
                              attendanceItem(per: "95", roll: "17"),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAttendance(
                              uid: FirebaseAuth.instance.currentUser!.uid.toString()
                            )));
                          },
                          child: Container(
                            width: width*0.5,
                            height: height*0.16,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Icon(Icons.book),
                                ).centered().py(20),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: "Show Att...".text.xl3.black.make().centered(),
                                ),
                              ],
                            ).centered(),
                          ).centered(),
                        ),
                      ],
                    ),
                  ).py(10),
                ],
              ),
            ).px(10).py(0),
            SizedBox(height: 10,),
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      mainItem("Time Table", 12, "left"),
                      mainItem("Student Att...", 12, "left"),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      mainItem("Add Time Table", 12, "right"),
                      mainItem("Student List", 12, "right"),
                    ],
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }

  Widget mainItem(String text, double size, String side) {
    return InkWell(
      radius: 25,
      onTap: () {
        if (text=="Student List") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentList()));
        } else if (text=="Add Time Table") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTimeTable()));
        } else if (text=="Time Table") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowTimeTable()));
        } else if (text=="Student Att...") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAttendanceMark()));
        }
      },
      child: Container(
        height: 150,
        width: width*0.48,
        child: text.text.xl3.black.size(size).make().centered(),
        decoration: BoxDecoration(
          borderRadius: side=="left" ?
          BorderRadius.only(bottomRight: Radius.circular(25), topRight: Radius.circular(25)) :
          BorderRadius.only(bottomLeft: Radius.circular(25), topLeft: Radius.circular(25)),
          color: Colors.white,
        ),
      ).centered(),
    ).p(3).py(3);
  }

  Widget attendanceItem({required String roll, required String per}) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        child: "$roll - ${per}%".text.xl2.make().centered(),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 0.23),
          ),
        ),
      ),
    ).px(5).py(3);
  }

  Widget specialAnnouncement(String text) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        child: text.text.black.sm.maxLines(3).minFontSize(15).overflow(TextOverflow.ellipsis).make().px(10).py(5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ).px(5).py(5);
  }
}
