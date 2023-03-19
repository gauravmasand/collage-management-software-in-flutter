import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/UserSimplePreferences.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Student List".text.black.make(),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentList2(index: index.toString(), branch: values!['courseName'],)));
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

class StudentList2 extends StatefulWidget {
  late String branch, index;
  StudentList2({Key? key, required this.branch,  required this.index}) : super(key: key);

  @override
  State<StudentList2> createState() => _StudentList2State();
}

class _StudentList2State extends State<StudentList2> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Student List".text.black.make(),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentList3(index: widget.index, branch: widget.branch,)));
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

class StudentList3 extends StatefulWidget {
  late String branch, index;
  StudentList3({Key? key, required this.branch,  required this.index}) : super(key: key);

  @override
  State<StudentList3> createState() => _StudentList3State();
}

class _StudentList3State extends State<StudentList3> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Student List".text.black.make(),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentList4(index: widget.index, branch: widget.branch, year: snapshot.key as String,)));
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

class StudentList4 extends StatefulWidget {
  late String branch, index, year;
  StudentList4({Key? key, required this.branch,  required this.index,  required this.year}) : super(key: key);

  @override
  State<StudentList4> createState() => _StudentList4State();
}

class _StudentList4State extends State<StudentList4> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "${widget.branch} Branch students year ${widget.year}".text.black.xl.make().px(25),
          elevation: 0,
          backgroundColor: Colors.blue.withOpacity(0.1),
        ),
        body: Container(
          color: Colors.blue.withOpacity(0.1),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            physics: BouncingScrollPhysics(),
            children: [
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
                    subtitle: Text("Enrollment no ${values!['enrollmentNo']}"),
                    trailing: Text("Roll no. ${(++index).toString()}", style: TextStyle(color: Colors.black)),
                    // leading: Container(
                    //   // child: Text((++index).toString(), style: TextStyle(),).p(20),
                    // ),
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}
