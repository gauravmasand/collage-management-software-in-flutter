import 'package:collagemanagementsystem/utils/UserSimplePreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowTimeTable extends StatefulWidget {
  const ShowTimeTable({Key? key}) : super(key: key);

  @override
  State<ShowTimeTable> createState() => _ShowTimeTableState();
}

class _ShowTimeTableState extends State<ShowTimeTable> {

  late String lac1 = "", lac2 = "", lac3 = "",  lac4 = "", lac5 = "", lac6 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Time Table", style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),),
        centerTitle: true,
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
        primary: true,
        physics: BouncingScrollPhysics(),
        children: [

          showTimeTableOf("Monday"),
          showTimeTableOf("Tuesday"),
          showTimeTableOf("Wednesday"),
          showTimeTableOf("Thursday"),
          showTimeTableOf("Friday"),
          showTimeTableOf("Saturday"),
          SizedBox(height: 100,),

        ],
      ),
    );
  }

  showTimeTableOf(String day) {
    return Column(
      children: [
        Text(day, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),).px(10),
        FirebaseAnimatedList(
          primary: false,
          shrinkWrap: true,
          query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!.toString()).child("staff").child(FirebaseAuth.instance.currentUser!.uid).child("timetable").child(day).orderByKey(),
          itemBuilder: (context, DataSnapshot snapshot, animation, index) {
            Map<dynamic, dynamic>? values = snapshot.value as Map?;
            return values!['lecture']!="" ? ListTile(
              title: Text(values!['lecture']),
              subtitle: Text(values!['classRoom']),
              trailing: Text("${values!['from']} - ${values!['to']}"),
            ) : SizedBox(height: 0, width: 0,);
            // return noticeItem(getFireNoticeUrl(values!['fileName']), values!['title'], values!['desc']);
          },
          physics: BouncingScrollPhysics(),
        ),
        Divider(),
      ],
    );
  }
}