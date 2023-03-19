import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/UserSimplePreferences.dart';

class AdminShowAttendance extends StatefulWidget {
  AdminShowAttendance({Key? key}) : super(key: key);

  @override
  State<AdminShowAttendance> createState() => _AdminShowAttendanceState();
}

class _AdminShowAttendanceState extends State<AdminShowAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: FirebaseAnimatedList(
            primary: false,
            shrinkWrap: true,
            query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("staff"),
            itemBuilder: (context, DataSnapshot snapshot, animation, index) {
              Map<dynamic, dynamic>? values = snapshot.value as Map?;
              return values!['position']=="Teaching Staff" ? ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAttendance(uid: snapshot.key as String)));
                },
                title: Text("${values!['staffName']}'s lecture attendance"),
              ) : SizedBox();
            },
            physics: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class ShowAttendance extends StatefulWidget {
  String uid;
  ShowAttendance({Key? key, required this.uid}) : super(key: key);

  @override
  State<ShowAttendance> createState() => _ShowAttendanceState();
}

class _ShowAttendanceState extends State<ShowAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: FirebaseAnimatedList(
            primary: false,
            shrinkWrap: true,
            query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("staff").child(widget.uid).child("studentAttendance"),
            itemBuilder: (context, DataSnapshot snapshot, animation, index) {
              // Map<dynamic, dynamic>? values = snapshot.value as Map?;
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAttendance1(uid: widget.uid, date: snapshot.key as String,)));
                },
                title: Text(snapshot.key as String),
              );
            },
            physics: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class ShowAttendance1 extends StatefulWidget {
  String uid, date;
  ShowAttendance1({Key? key, required this.uid, required this.date}) : super(key: key);

  @override
  State<ShowAttendance1> createState() => _ShowAttendance1State();
}

class _ShowAttendance1State extends State<ShowAttendance1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select course'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: FirebaseAnimatedList(
            primary: false,
            shrinkWrap: true,
            query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("staff").child(widget.uid).child("studentAttendance").child(widget.date),
            itemBuilder: (context, DataSnapshot snapshot, animation, index) {
              // Map<dynamic, dynamic>? values = snapshot.value as Map?;
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAttendance2(uid: widget.uid, date: widget.date, courses: snapshot.key as String,)));
                },
                title: Text(snapshot.key as String),
              );
            },
            physics: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class ShowAttendance2 extends StatefulWidget {
  String uid, date, courses;
  ShowAttendance2({Key? key, required this.uid, required this.date, required this.courses}) : super(key: key);

  @override
  State<ShowAttendance2> createState() => _ShowAttendance2State();
}

class _ShowAttendance2State extends State<ShowAttendance2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select year of students'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: FirebaseAnimatedList(
            primary: false,
            shrinkWrap: true,
            query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("staff").child(widget.uid).child("studentAttendance").child(widget.date).child(widget.courses),
            itemBuilder: (context, DataSnapshot snapshot, animation, index) {
              // Map<dynamic, dynamic>? values = snapshot.value as Map?;
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAttendance3(uid: widget.uid, date: widget.date, courses: widget.courses, yearOfStudent: snapshot.key as String,)));
                },
                title: Text(snapshot.key as String),
              );
            },
            physics: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class ShowAttendance3 extends StatefulWidget {
  String uid, date, courses, yearOfStudent;
  ShowAttendance3({Key? key, required this.uid, required this.date, required this.courses, required this.yearOfStudent}) : super(key: key);

  @override
  State<ShowAttendance3> createState() => _ShowAttendance3State();
}

class _ShowAttendance3State extends State<ShowAttendance3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select the subject'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: FirebaseAnimatedList(
            primary: false,
            shrinkWrap: true,
            query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("staff").child(widget.uid).child("studentAttendance").child(widget.date).child(widget.courses).child(widget.yearOfStudent),
            itemBuilder: (context, DataSnapshot snapshot, animation, index) {
              // Map<dynamic, dynamic>? values = snapshot.value as Map?;
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAttendance4(uid: widget.uid, date: widget.date, courses: widget.courses, yearOfStudent: widget.yearOfStudent, subject: snapshot.key as String,)));
                },
                title: Text(snapshot.key as String),
              );
            },
            physics: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class ShowAttendance4 extends StatefulWidget {
  String uid, date, courses, yearOfStudent, subject;
  ShowAttendance4({Key? key, required this.uid, required this.date, required this.courses, required this.yearOfStudent, required this.subject}) : super(key: key);

  @override
  State<ShowAttendance4> createState() => _ShowAttendance4State();
}

class _ShowAttendance4State extends State<ShowAttendance4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select the number of lecture'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: FirebaseAnimatedList(
            primary: false,
            shrinkWrap: true,
            query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("staff").child(widget.uid).child("studentAttendance").child(widget.date).child(widget.courses).child(widget.yearOfStudent).child(widget.subject),
            itemBuilder: (context, DataSnapshot snapshot, animation, index) {
              // Map<dynamic, dynamic>? values = snapshot.value as Map?;
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAttendance5(uid: widget.uid, date: widget.date, courses: widget.courses, yearOfStudent: widget.yearOfStudent, subject: widget.subject, specialId: snapshot.key as String, lectureNo: (++index).toString(),)));
                },
                title: Text((++index).toString()),
              );
            },
            physics: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class ShowAttendance5 extends StatefulWidget {
  String uid, date, courses, yearOfStudent, subject, specialId, lectureNo;
  ShowAttendance5({Key? key, required this.uid, required this.date, required this.courses, required this.yearOfStudent, required this.subject, required this.specialId, required this.lectureNo}) : super(key: key);

  @override
  State<ShowAttendance5> createState() => _ShowAttendance5State();
}

class _ShowAttendance5State extends State<ShowAttendance5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.date} - ${widget.courses} - ${widget.yearOfStudent} - ${widget.subject} - ${widget.lectureNo}"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: FirebaseAnimatedList(
            primary: false,
            shrinkWrap: true,
            query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("staff").child(widget.uid).child("studentAttendance").child(widget.date).child(widget.courses).child(widget.yearOfStudent).child(widget.subject).child(widget.specialId),
            itemBuilder: (context, DataSnapshot snapshot, animation, index) {
              Map<dynamic, dynamic>? values = snapshot.value as Map?;
              return ListTile(
                tileColor: values!['attendance'] ? Colors.lightGreenAccent.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
                title: Text(values!['name']),
                subtitle: Text(values!['enrollment']),
              );
            },
            physics: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
