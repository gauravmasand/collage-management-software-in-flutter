import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/UserSimplePreferences.dart';

class CheckStudentFees extends StatefulWidget {
  const CheckStudentFees({Key? key}) : super(key: key);

  @override
  State<CheckStudentFees> createState() => _CheckStudentFeesState();
}

class _CheckStudentFeesState extends State<CheckStudentFees> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Check Fees".text.black.make(),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckStudentFees2(index: index.toString(), branch: values!['courseName'],)));
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

class CheckStudentFees2 extends StatefulWidget {
  late String branch, index;
  CheckStudentFees2({Key? key, required this.branch,  required this.index}) : super(key: key);

  @override
  State<CheckStudentFees2> createState() => _CheckStudentFees2State();
}

class _CheckStudentFees2State extends State<CheckStudentFees2> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Check Fees".text.black.make(),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckStudentFees3(index: widget.index, branch: widget.branch, dataOfYear: snapshot.key as String)));
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

class CheckStudentFees3 extends StatefulWidget {
  late String branch, index, dataOfYear;
  CheckStudentFees3({Key? key, required this.branch,  required this.index,  required this.dataOfYear}) : super(key: key);

  @override
  State<CheckStudentFees3> createState() => _CheckStudentFees3State();
}

class _CheckStudentFees3State extends State<CheckStudentFees3> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: "Check Fees".text.black.make(),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckStudentFees4(index: widget.index, branch: widget.branch, year: snapshot.key as String, dataOfYear: widget.dataOfYear)));
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

class CheckStudentFees4 extends StatefulWidget {
  late String branch, index, year, dataOfYear;
  CheckStudentFees4({Key? key, required this.branch,  required this.index, required this.year, required this.dataOfYear}) : super(key: key);

  @override
  State<CheckStudentFees4> createState() => _CheckStudentFees4State();
}

class _CheckStudentFees4State extends State<CheckStudentFees4> {
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
            children: [
              SizedBox(height: 10,),
              FirebaseAnimatedList(
                primary: false,
                shrinkWrap: true,
                query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("courses").child(widget.index).child(widget.dataOfYear).child(widget.year).orderByKey(),
                itemBuilder: (context, DataSnapshot snapshot, animation, index) {
                  Map<dynamic, dynamic>? values = snapshot.value as Map?;
                  return ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateFees(
                        branch: widget.branch,
                        index: widget.index,
                        year: widget.year,
                        dataOfYear: widget.dataOfYear,
                        specificID: snapshot.key as String,
                        name: values!['nameOfStudent'],
                      )));
                    },
                    tileColor: Colors.white,
                    title: Text(values!['nameOfStudent']),
                    subtitle: Text("Total fees ₹${values!['totalFees']}"),
                    trailing: Text("₹${values!['feesCompleted']}", style: TextStyle(color: Colors.green)),
                    leading: Container(
                      child: Text((++index).toString(), style: TextStyle(),).p(20),
                    ),
                  );
                },
                physics: BouncingScrollPhysics(),
              ),
            ],
          ),
      )
    );
  }
}


class UpdateFees extends StatefulWidget {
  late String branch, index, year, specificID, dataOfYear, name;
  UpdateFees({Key? key, required this.branch,  required this.index,  required this.year,  required this.specificID, required this.dataOfYear, required this.name}) : super(key: key);

  @override
  State<UpdateFees> createState() => _UpdateFeesState();
}

class _UpdateFeesState extends State<UpdateFees> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Enter the total amount fees paid by ${widget.name}",
                ),
              ),
              TextButton(onPressed: () async {
                String? clgCode = UserSimplePreferences.getCollageCode();
                DatabaseReference reference = FirebaseDatabase.instance.ref("collage/${clgCode}/courses/${widget.index}/${widget.dataOfYear}/${widget.year}/${widget.specificID}");

                await reference.update({
                  "feesCompleted" : controller.text,
                });
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "${widget.name} fees updated to ${controller.text}");

              }, child: Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
