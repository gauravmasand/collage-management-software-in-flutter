import 'package:collagemanagementsystem/screens/AboutScreen.dart';
import 'package:collagemanagementsystem/screens/AddEvents.dart';
import 'package:collagemanagementsystem/screens/AddNoticeScreen.dart';
import 'package:collagemanagementsystem/screens/HelpScreen.dart';
import 'package:collagemanagementsystem/utils/FireAuth.dart';
import 'package:collagemanagementsystem/utils/UserSimplePreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TeachingStaffTab4 extends StatefulWidget {
  static String name = "";
  TeachingStaffTab4({Key? key}) : super(key: key);

  @override
  State<TeachingStaffTab4> createState() => _TeachingStaffTab4State();
}

class _TeachingStaffTab4State extends State<TeachingStaffTab4> {

  late double width;
  late double height;
  String position = "", email = "";

  fetchData() async {

    email = FirebaseAuth.instance.currentUser!.email!;

    if (FirebaseAuth.instance.currentUser!.uid.toString()==UserSimplePreferences.getCollageCode()) {
      position = "Admin";
    } else {
      DatabaseReference ref = FirebaseDatabase.instance.ref("collage/${UserSimplePreferences.getCollageCode()}/staff/${FirebaseAuth.instance.currentUser!.uid.toString()}/");
      DatabaseEvent event = await ref.once();
      Map value = event.snapshot.value as Map;
      TeachingStaffTab4.name = value['staffName'];
      position = value['position'];
      email = value['email'];
      setState(() {});
    }



  }

  @override
  void initState() {
    fetchData();
  }

  dimension() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    dimension();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "PROFILE".text.black.make(),
        elevation: 0,
        backgroundColor: Colors.blue.withOpacity(0.1),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.edit, color: Colors.black,),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
        ),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        child: Image.asset(
                          "assets/img/profile.png",
                          width: width*0.3,
                          height: width*0.3,
                          fit: BoxFit.cover,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TeachingStaffTab4.name.text.xl2.black.make(),
                          position.text.xl.black.make(),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(height: 15,),
                  // Row(
                  //   children: [
                  //     SizedBox(width: 25,),
                  //     Icon(CupertinoIcons.phone),
                  //     SizedBox(width: 10,),
                  //     Text("+91 9871237654"),
                  //   ],
                  // ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      SizedBox(width: 25,),
                      Icon(Icons.email_outlined),
                      SizedBox(width: 10,),
                      Text(email),
                    ],
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddNoticeScreen()));
                    },
                    leading: Icon(Icons.document_scanner_outlined),
                    title: "Add Notice".text.make(),
                    tileColor: Colors.white,
                    iconColor: Colors.black,
                  ).py(1),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventsScreen()));
                    },
                    leading: Icon(CupertinoIcons.calendar_today),
                    title: "Add Event".text.make(),
                    tileColor: Colors.white,
                    iconColor: Colors.black,
                  ).py(1),
                  ListTile(
                    onTap: () {

                    },
                    leading: Icon(CupertinoIcons.settings),
                    title: "Settings".text.make(),
                    tileColor: Colors.white,
                    iconColor: Colors.black,
                  ).py(1),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
                    },
                    leading: Image.asset("assets/img/about.png", width: 25,),
                    title: "About".text.make(),
                    tileColor: Colors.white,
                    iconColor: Colors.black,
                  ).py(1),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HelpScreen()));
                    },
                    leading: Icon(Icons.help_outline_rounded),
                    title: "Help".text.make(),
                    tileColor: Colors.white,
                    iconColor: Colors.black,
                  ).py(1),
                  ListTile(
                    onTap: () {
                      _openLogoutDialog(context);
                    },
                    leading: Icon(Icons.logout),
                    title: "Logout".text.make(),
                    tileColor: Colors.white,
                    iconColor: Colors.black,
                  ).py(1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openLogoutDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(child: Container(
          width: width*0.9,
          height: width*0.35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              SizedBox(height: 20,),
              "Are you sure you want to logout".text.xl2.make(),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(onPressed: () => Navigator.pop(context) , child: "No".text.make()),
                  SizedBox(width: 10,),
                  OutlinedButton(onPressed: () {
                    FireAuth.logout(context);
                  }, child: "Yes".text.make()),
                  SizedBox(width: 35,),
                ],
              )
            ],
          ),
        ));
      },
    );
  }
}
