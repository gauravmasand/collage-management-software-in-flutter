import 'package:collagemanagementsystem/screens/AcceptStaffSreen.dart';
import 'package:collagemanagementsystem/screens/AddSpecialAnnouncementScreen.dart';
import 'package:collagemanagementsystem/screens/ShowAttendance.dart';
import 'package:collagemanagementsystem/widgets/TeachingStaffTab4.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../screens/AddEvents.dart';
import '../screens/AddNoticeScreen.dart';
import '../screens/AddStudent.dart';
import '../screens/StudentList.dart';
import '../utils/UserSimplePreferences.dart';

class AdminTab1 extends StatefulWidget {
  const AdminTab1({Key? key}) : super(key: key);

  @override
  State<AdminTab1> createState() => _AdminTab1State();
}

class _AdminTab1State extends State<AdminTab1> {

  late double width;
  late double height;
  DateTime now = new DateTime.now();
  late DateTime date;
  late String? collageName = "";
  String dummyText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
  List<String> deptList = [];

  fetchData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("collage/${FirebaseAuth.instance.currentUser!.uid.toString()}/collageName");
    DatabaseEvent event = await ref.once();
    collageName = event.snapshot.value as String?;
    TeachingStaffTab4.name = collageName!;
    setState(() {});
  }

  // fetchDept() async {
  //   DatabaseReference ref = FirebaseDatabase.instance.ref("collage/${FirebaseAuth.instance.currentUser!.uid.toString()}/courses");
  //   DatabaseEvent event = await ref.once();
  //   collageName = event.snapshot.value as String?;
  //   setState(() {});
  // }

  dimension() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  void initState() {
    date = new DateTime(now.year, now.month, now.day);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    dimension();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: collageName!.text.black.make(),
        elevation: 0,
        backgroundColor: Colors.blue.withOpacity(0.1),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AcceptStaff()));
          }, icon: Icon(Icons.notifications_none,color: Colors.black,)),
        ],
      ),
      body: Container(
        color: Colors.blue.withOpacity(0.1),
        child: ListView(
            physics: BouncingScrollPhysics(),
            children:[
              Container(
                width: width,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.5),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    "Announcement".text.xl2.make().px(25),
                    Container(
                      height: 150,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    "Departments".text.xl2.make().px(25),
                    FirebaseAnimatedList(
                      primary: false,
                      shrinkWrap: true,
                      query: FirebaseDatabase.instance.reference().child('collage').child(FirebaseAuth.instance.currentUser!.uid.toString()).child("courses").orderByChild('courseName'),
                      reverse: true,
                      itemBuilder: (context, DataSnapshot snapshot, animation, index) {
                        Map<dynamic, dynamic>? values = snapshot.value as Map?;
                        // values!['fileName'])
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StudentList2(index: index.toString(), branch: values!['courseName'],)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(width: 0.1, color: Colors.grey, style: BorderStyle.solid),
                            ),
                            child: Text(values!['courseName'], style: TextStyle(color: Colors.black, fontSize: 18),).px(10).py(5),
                          ),
                        ).px(20).py(5);
                      },
                      physics: BouncingScrollPhysics(),
                    ),
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
                  child: "Admission".text.blue400.bold.make().centered().py(20).px(15),
                ).centered(),
              ).centered(),
              false ? TextButton(
                onPressed: () {},
                child: Container(
                  width: width*0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 0.5),
                    color: Colors.white,
                  ),
                  child: "Admission from CSV".text.blue400.bold.make().centered().py(20).px(15),
                ).centered(),
              ).centered() : SizedBox(),
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
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminShowAttendance()));
                },
                child: Container(
                  width: width*0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 0.5),
                    color: Colors.white,
                  ),
                  child: "Attendance".text.blue400.bold.make().centered().py(20).px(15),
                ).centered(),
              ).centered(),
              // Container(
              //   width: width,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.5),
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(25),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       SizedBox(height: 10,),
              //       "Categorization of year".text.xl2.make().px(25),
              //       // InkWell(
              //       //   onTap: () {
              //       //     print("object");
              //       //   },
              //       //   child: Container(
              //       //     decoration: BoxDecoration(
              //       //         borderRadius: BorderRadius.circular(10),
              //       //         border: Border.all(color: Colors.grey, width: 0.5)
              //       //     ),
              //       //     width: width*.9,
              //       //     child: "Admission".text.blue400.bold.make().centered().py(10),
              //       //   ).centered(),
              //       // ).centered().py(10),
              //       // InkWell(
              //       //   onTap: () {
              //       //     print("object");
              //       //   },
              //       //   child: Container(
              //       //     decoration: BoxDecoration(
              //       //         borderRadius: BorderRadius.circular(10),
              //       //         border: Border.all(color: Colors.grey, width: 0.5)
              //       //     ),
              //       //     width: width*.9,
              //       //     child: "Fees".text.blue400.bold.make().centered().py(10),
              //       //   ).centered(),
              //       // ).centered(),
              //       // InkWell(
              //       //   onTap: () {
              //       //     print("object");
              //       //   },
              //       //   child: Container(
              //       //     decoration: BoxDecoration(
              //       //         borderRadius: BorderRadius.circular(10),
              //       //         border: Border.all(color: Colors.grey, width: 0.5)
              //       //     ),
              //       //     width: width*.9,
              //       //     child: "Student List".text.blue400.bold.make().centered().py(10),
              //       //   ).centered(),
              //       // ).centered().py(10),
              //       SizedBox(height: 5,)
              //     ],
              //   ),
              // ).px(10).py(0),
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
        child: text.text.black.maxLines(3).minFontSize(17).overflow(TextOverflow.ellipsis).make().px(10).py(5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ).px(10).py(5);
  }
}
