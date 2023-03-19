import 'package:collagemanagementsystem/screens/AddEvents.dart';
import 'package:collagemanagementsystem/screens/AddNoticeScreen.dart';
import 'package:collagemanagementsystem/screens/AddSpecialAnnouncementScreen.dart';
import 'package:collagemanagementsystem/screens/CheckStudentFees.dart';
import 'package:collagemanagementsystem/screens/StudentList.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../screens/AddStudent.dart';

class OfficeStaffTab1 extends StatefulWidget {
  OfficeStaffTab1({Key? key}) : super(key: key);

  @override
  State<OfficeStaffTab1> createState() => _OfficeStaffTab1State();
}

class _OfficeStaffTab1State extends State<OfficeStaffTab1> {

  late double width;
  late double height;
  DateTime now = new DateTime.now();
  late DateTime date;

  dimension() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  void initState() {
    date = new DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    dimension();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Office Staff".text.black.make(),
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
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.5),
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  "Options".text.xl2.make().px(25),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudent()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.5)
                      ),
                      width: width*.9,
                      child: "Admission".text.blue400.bold.make().centered().py(10),
                    ).centered(),
                  ).centered().py(10),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckStudentFees()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.5)
                      ),
                      width: width*.9,
                      child: "Fees".text.blue400.bold.make().centered().py(10),
                    ).centered(),
                  ).centered(),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentList()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.5)
                      ),
                      width: width*.9,
                      child: "Student List".text.blue400.bold.make().centered().py(10),
                    ).centered(),
                  ).centered().py(10),
                  SizedBox(height: 5,)
                ],
              ),
            ).px(10).py(0),
            SizedBox(height: 10,),
            Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.5),
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddNoticeScreen()));
                    },
                    child: Container(
                      width: width*0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 0.5)
                      ),
                      child: "Add Notice".text.blue400.bold.make().centered().py(10).px(15),
                    ).centered(),
                  ).centered().py(10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventsScreen()));
                      },
                    child: Container(
                      width: width*0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 0.5)
                      ),
                      child: "Add Event".text.blue400.bold.make().centered().py(10).px(15),
                    ).centered(),
                  ).centered().py(10),
                  SizedBox(height: 5,)
                ],
              ),
            ).px(10).py(0),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudent()));
              },
              child: Container(
                width: width*0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 0.5),
                  color: Colors.white,
                ),
                child: "Add Student".text.blue400.bold.make().centered().py(20).px(15),
              ).centered(),
            ).centered(),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddSpecialAnnouncementScreen()));
              },
              child: Container(
                width: width*0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 0.5),
                  color: Colors.white,
                ),
                child: "Special Announcement".text.blue400.bold.make().centered().py(20).px(15),
              ).centered(),
            ).centered(),
          ]
        ),
      ),
    );
  }

  Widget mainItem(String text, double size, String side) {
    return InkWell(
      radius: 25,
      onTap: () {

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
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ).px(5).py(5);
  }
}
