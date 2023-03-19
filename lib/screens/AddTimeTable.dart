import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:collagemanagementsystem/screens/SignupOptionsPage.dart';
import 'package:collagemanagementsystem/utils/FireAuth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/UserSimplePreferences.dart';





class AddTimeTable extends StatefulWidget {
  const AddTimeTable({Key? key}) : super(key: key);

  @override
  State<AddTimeTable> createState() => _AddTimeTableState();
}

class _AddTimeTableState extends State<AddTimeTable> {

  late String lac1 = "", lac2 = "", lac3 = "",  lac4 = "", lac5 = "", lac6 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Select day", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),
              makeButton("Monday"),
              makeButton("Tuesday"),
              makeButton("Wednesday"),
              makeButton("Thursday"),
              makeButton("Friday"),
              makeButton("Saturday"),
            ],
          ),
        ],
      ),
    );
  }

  makeButton(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddTimeTableOfDay(day: text)));

          },
          color: Colors.greenAccent,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
          ),
          child: Text(text, style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18
          ),),
        ),
      ),
    );
  }

}

class AddTimeTableOfDay extends StatefulWidget {
  late String day;
  AddTimeTableOfDay({Key? key, required this.day}) : super(key: key);

  @override
  State<AddTimeTableOfDay> createState() => _AddTimeTableOfDayState();
}

class _AddTimeTableOfDayState extends State<AddTimeTableOfDay> {


  late TimeOfDay from1, from2, from3,  from4, from5, from6;
  late TimeOfDay to1, to2, to3,  to4, to5, to6;
  late String lac1 = "", lac2 = "", lac3 = "",  lac4 = "", lac5 = "", lac6 = "";
  late String at1 = "", at2 = "", at3 = "",  at4 = "", at5 = "", at6 = "";

  @override
  void initState() {
    from1 = new TimeOfDay(hour: 10, minute: 30);
    from2 = new TimeOfDay(hour: 10, minute: 30);
    from3 = new TimeOfDay(hour: 10, minute: 30);
    from4 = new TimeOfDay(hour: 10, minute: 30);
    from5 = new TimeOfDay(hour: 10, minute: 30);
    from6 = new TimeOfDay(hour: 10, minute: 30);
    to1 = new TimeOfDay(hour: 11, minute: 30);
    to2 = new TimeOfDay(hour: 11, minute: 30);
    to3 = new TimeOfDay(hour: 11, minute: 30);
    to4 = new TimeOfDay(hour: 11, minute: 30);
    to5 = new TimeOfDay(hour: 11, minute: 30);
    to6 = new TimeOfDay(hour: 11, minute: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(widget.day, style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        TextButton(onPressed: () async {
                          from1 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("From Time")),
                        TextButton(onPressed: () async {
                          to1 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("To Time")),
                      ],
                    ),
                    makeInput(label: "Lecture 1", index: 1),
                    makeInput(label: "At of 1", index: 1),
                    Divider(),

                    Row(
                      children: [
                        TextButton(onPressed: () async {
                          from2 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("From Time")),
                        TextButton(onPressed: () async {
                          to2 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("To Time")),
                      ],
                    ),
                    makeInput(label: "Lecture 2", index: 2),
                    makeInput(label: "At of 2", index: 2),
                    Divider(),

                    Row(
                      children: [
                        TextButton(onPressed: () async {
                          from3 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("From Time")),
                        TextButton(onPressed: () async {
                          to3 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("To Time")),
                      ],
                    ),
                    makeInput(label: "Lecture 3", index: 3),
                    makeInput(label: "At of 3", index: 3),
                    Divider(),

                    Row(
                      children: [
                        TextButton(onPressed: () async {
                          from4 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("From Time")),
                        TextButton(onPressed: () async {
                          to4 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("To Time")),
                      ],
                    ),
                    makeInput(label: "Lecture 4", index: 4),
                    makeInput(label: "At of 4", index: 4),
                    Divider(),

                    Row(
                      children: [
                        TextButton(onPressed: () async {
                          from5 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("From Time")),
                        TextButton(onPressed: () async {
                          to5 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("To Time")),
                      ],
                    ),
                    makeInput(label: "Lecture 5", index: 5),
                    makeInput(label: "At of 5", index: 5),
                    Divider(),

                    Row(
                      children: [
                        TextButton(onPressed: () async {
                          from6 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("From Time")),
                        TextButton(onPressed: () async {
                          to6 = (await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ))!;
                        }, child: Text("To Time")),
                      ],
                    ),
                    makeInput(label: "Lecture 6", index: 6),
                    makeInput(label: "At of 6", index: 6),
                    Divider(),
                  ],
                ),
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
                      String? clgCode = UserSimplePreferences.getCollageCode();
                      DatabaseReference reference = FirebaseDatabase.instance.ref("collage/${clgCode}/staff/${FirebaseAuth.instance.currentUser!.uid}/timetable/${widget.day}");
                      print(lac1);
                      print(from1.hour.toString()  + " - " + to1.minute.toString());
                      print(from2.hour.toString() + " - " + to2.minute.toString());

                      print(lac2);
                      print(lac3);
                      print(lac4);
                      print(lac5);
                      print(lac6);
                      await reference.set({
                        "01" : {
                          "from" : from1.hour.toString()  + "." + from1.minute.toString(),
                          "to" : to1.hour.toString()  + "." + to1.minute.toString(),
                          "lecture" : lac1,
                          "classRoom" : at1,
                        },
                        "02" : {
                          "from" : from2.hour.toString()  + "." + from2.minute.toString(),
                          "to" : to2.hour.toString()  + "." + to2.minute.toString(),
                          "lecture" : lac2,
                          "classRoom" : at2,
                        },
                        "03" : {
                          "from" : from3.hour.toString()  + "." + from3.minute.toString(),
                          "to" : to3.hour.toString()  + "." + to3.minute.toString(),
                          "lecture" : lac3,
                          "classRoom" : at3,
                        },
                        "04" : {
                          "from" : from4.hour.toString()  + "." + from4.minute.toString(),
                          "to" : to4.hour.toString()  + "." + to4.minute.toString(),
                          "lecture" : lac4,
                          "classRoom" : at4,
                        },
                        "05" : {
                          "from" : from5.hour.toString()  + "." + from5.minute.toString(),
                          "to" : to5.hour.toString()  + "." + to5.minute.toString(),
                          "lecture" : lac5,
                          "classRoom" : at5,
                        },
                        "06" : {
                          "from" : from6.hour.toString()  + "." + from6.minute.toString(),
                          "to" : to6.hour.toString()  + "." + to6.minute.toString(),
                          "lecture" : lac6,
                          "classRoom" : at6,
                        },
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.greenAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text("Save", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget makeInput({label, obscureText = false, index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextFormField(
          onChanged: (value) {
            if (label=="Lecture 1") {
              lac1 = value;
            } else if (label=="Lecture 2") {
              lac2 = value;
            } else if (label=="Lecture 3") {
              lac3 = value;
            } else if (label=="Lecture 4") {
              lac4 = value;
            } else if (label=="Lecture 5") {
              lac5 = value;
            } else if (label=="Lecture 6") {
              lac6 = value;
            }

            // for AT
            if (index==1) {
              at1 = value;
            } else if (index==2) {
              at2 = value;
            } else if (index==3) {
              at3 = value;
            } else if (index==4) {
              at4 = value;
            } else if (index==5) {
              at5 = value;
            } else if (index==6) {
              at6 = value;
            }
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}
