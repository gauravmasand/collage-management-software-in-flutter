import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/UserSimplePreferences.dart';

class StudentAttendanceMark extends StatefulWidget {
  const StudentAttendanceMark({Key? key}) : super(key: key);

  @override
  State<StudentAttendanceMark> createState() => _StudentAttendanceMarkState();
}

class _StudentAttendanceMarkState extends State<StudentAttendanceMark> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Mark Attendance".text.black.make(),
          elevation: 0,
          backgroundColor: Colors.blue.withOpacity(0.1),
        ),
        body: Container(
          color: Colors.blue.withOpacity(0.1),
          child: Column(
            children: [
              SizedBox(height: 50,),
              "Select the branch".text.xl.make().px(25),
              SizedBox(height: 10,),
              FirebaseAnimatedList(
                primary: false,
                shrinkWrap: true,
                query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("courses").orderByKey(),
                itemBuilder: (context, DataSnapshot snapshot, animation, index) {
                  Map<dynamic, dynamic>? values = snapshot.value as Map?;
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAttendanceMark2(index: index.toString(), branch: values!['courseName'],)));
                    },
                    child: Container(
                      height: 100,
                      alignment: Alignment.center,
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
            ],
          ),
        )
    );
  }
}

class StudentAttendanceMark2 extends StatefulWidget {
  late String branch, index;
  StudentAttendanceMark2({Key? key, required this.branch,  required this.index}) : super(key: key);

  @override
  State<StudentAttendanceMark2> createState() => _StudentAttendanceMark2State();
}

class _StudentAttendanceMark2State extends State<StudentAttendanceMark2> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Mark Attendance".text.black.make(),
          elevation: 0,
          backgroundColor: Colors.blue.withOpacity(0.1),
        ),
        body: Container(
          color: Colors.blue.withOpacity(0.1),
          child: Column(
            children: [
              SizedBox(height: 50,),
              "Select the year of ${widget.branch}".text.xl.make().px(25),
              SizedBox(height: 10,),
              FirebaseAnimatedList(
                primary: false,
                shrinkWrap: true,
                query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("courses").child(widget.index),
                itemBuilder: (context, DataSnapshot snapshot, animation, index) {
                  // Map<dynamic, dynamic>? values = snapshot.value as Map?;
                  print("object");
                  return isNumeric(snapshot.key as String) ? InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAttendanceMark3(index: widget.index, branch: widget.branch,)));
                    },
                    child: Container(
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 0.1, color: Colors.grey, style: BorderStyle.solid),
                      ),
                      child: Text(snapshot.key as String, style: TextStyle(color: Colors.black, fontSize: 18),).px(10).py(5),
                    ),
                  ).px(20).py(5) : SizedBox();
                },
                physics: BouncingScrollPhysics(),
              ),
            ],
          ),
        )
    );
  }

  bool isNumeric(String strNum) {
    if (strNum == null) {
      return false;
    }
    try {
      double d = double.parse(strNum);
    } catch (NumberFormatException) {
      return false;
    }
    return true;
  }

}

class StudentAttendanceMark3 extends StatefulWidget {
  late String branch, index;
  StudentAttendanceMark3({Key? key, required this.branch,  required this.index}) : super(key: key);

  @override
  State<StudentAttendanceMark3> createState() => _StudentAttendanceMark3State();
}

class _StudentAttendanceMark3State extends State<StudentAttendanceMark3> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Mark Attendance".text.black.make(),
          elevation: 0,
          backgroundColor: Colors.blue.withOpacity(0.1),
        ),
        body: Container(
          color: Colors.blue.withOpacity(0.1),
          child: Column(
            children: [
              SizedBox(height: 50,),
              "Select the year of ${widget.branch} students".text.xl.make().px(25),
              SizedBox(height: 10,),
              FirebaseAnimatedList(
                primary: false,
                shrinkWrap: true,
                query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("courses").child(widget.index).child(DateTime.now().year.toString()),
                itemBuilder: (context, DataSnapshot snapshot, animation, index) {
                  // Map<dynamic, dynamic>? values = snapshot.value as Map?;
                  print("object");
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAttendanceMark4(index: widget.index, branch: widget.branch, year: snapshot.key as String,)));
                    },
                    child: Container(
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 0.1, color: Colors.grey, style: BorderStyle.solid),
                      ),
                      child: Text(snapshot.key as String, style: TextStyle(color: Colors.black, fontSize: 18),).px(10).py(5),
                    ),
                  ).px(20).py(5);
                },
                physics: BouncingScrollPhysics(),
              ),
            ],
          ),
        )
    );
  }
}

class AttendanceModel {
  late int rollNo;
  late String enrollment, name;
  late bool status;

  AttendanceModel(this.rollNo, this.enrollment, this.name, this.status);
}

class StudentAttendanceMark4 extends StatefulWidget {
  late String branch, index, year;
  StudentAttendanceMark4({Key? key, required this.branch,  required this.index,  required this.year}) : super(key: key);

  @override
  State<StudentAttendanceMark4> createState() => _StudentAttendanceMark4State();
}

class _StudentAttendanceMark4State extends State<StudentAttendanceMark4> {

  List<AttendanceModel> attendanceModel = [];

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "${widget.branch} branch students year ${widget.year}".text.black.xl.make().px(25),
          elevation: 0,
          backgroundColor: Colors.blue.withOpacity(0.1),
        ),
        body: Container(
          color: Colors.blue.withOpacity(0.1),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            physics: BouncingScrollPhysics(),
            children: [
              TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Enter subject name here'
                ),
                controller: controller,
              ).p(10).px(15),
              SizedBox(height: 10,),
              FirebaseAnimatedList(
                primary: false,
                shrinkWrap: true,
                query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("courses").child(widget.index).child(DateTime.now().year.toString()).child(widget.year).orderByKey(),
                itemBuilder: (context, DataSnapshot snapshot, animation, index) {
                  Map<dynamic, dynamic>? values = snapshot.value as Map?;
                  return ListTile(
                    tileColor: Colors.white,
                    title: Text(values!['nameOfStudent']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5,),
                        Text("Roll no. ${(++index).toString()} | Enrollment no ${values!['enrollmentNo']}"),
                        // Text("Enrollment no ${values!['enrollmentNo']}"),
                      ],
                    ),
                    trailing: Container(
                      width: 85,
                      child: Row(
                        children: [
                          InkWell(onTap: () async {
                            attendanceModel.add(AttendanceModel(index, values!['enrollmentNo'], values!['nameOfStudent'], false));
                            Fluttertoast.showToast(msg: "Roll no ${(index).toString()} Absent", backgroundColor: Colors.redAccent,toastLength: Toast.LENGTH_SHORT);
                          }, child: Container(child: Text("A"), decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.redAccent.withOpacity(0.1)), width: 40, height: 40, alignment: Alignment.center, ),).px(2.5),
                          InkWell(onTap: () {
                            attendanceModel.add(AttendanceModel(index, values!['enrollmentNo'], values!['nameOfStudent'], true));
                            Fluttertoast.showToast(msg: "Roll no ${(index).toString()} Present", backgroundColor: Colors.lightBlueAccent,toastLength: Toast.LENGTH_SHORT);
                          }, child: Container(child: Text("P"), decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.lightGreenAccent.withOpacity(0.1)), width: 40, height: 40, alignment: Alignment.center, ),),
                        ],
                      ),
                    )
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      _openLoadingDialog(context);
                      String? clgCode = UserSimplePreferences.getCollageCode();

                      String postKey = DateTime.now().millisecondsSinceEpoch.toString();

                      if (controller.text.toString().isNotEmpty) {
                        for (int i = 0; i < attendanceModel.length; i++) {

                          DatabaseReference reference = FirebaseDatabase.instance.ref("collage/${clgCode}/staff/${FirebaseAuth.instance.currentUser!.uid}/studentAttendance/${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}/${widget.branch}/${widget.year}/${controller.text.toString()}/${postKey.toString()}/${attendanceModel[i].rollNo.toString()}");
                          await reference.set({
                            "name" : attendanceModel[i].name,
                            "attendance" : attendanceModel[i].status,
                            "enrollment" : attendanceModel[i].enrollment
                          });

                        }
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "Done");
                      } else {
                        Fluttertoast.showToast(msg: 'Enter the subject name first');
                      }
                    },
                    color: Colors.greenAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text("SAVE", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),),
                  ),
                ),
              ).py(20),
            ],
          ),
        )
    );
  }


  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
