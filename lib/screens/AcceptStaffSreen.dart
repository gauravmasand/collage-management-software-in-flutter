import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/UserSimplePreferences.dart';

class AcceptStaff extends StatefulWidget {
  const AcceptStaff({Key? key}) : super(key: key);

  @override
  State<AcceptStaff> createState() => _AcceptStaffState();
}

class _AcceptStaffState extends State<AcceptStaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Request"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: FirebaseAnimatedList(
            query: FirebaseDatabase.instance.reference().child('collage').child(FirebaseAuth.instance.currentUser!.uid.toString()).child("staff"),
            itemBuilder: (context, DataSnapshot snapshot, animation, index) {
              Map<dynamic, dynamic>? values = snapshot.value as Map?;

              final ref = FirebaseDatabase.instance.ref();
              String? clgCode = UserSimplePreferences.getCollageCode();

              // final snapshot1 = await ref.child('collage/collageStaff/${FirebaseAuth.instance.currentUser!.uid}').get();
              // if (snapshot1.exists) {
              //   print(snapshot1.value.toString());
              // }

              return ListTile(
                title: Text(values!['staffName']),
                subtitle: Text(values!['position']),
                trailing: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: () async {
                        DatabaseReference reference = FirebaseDatabase.instance.ref("collageStaff/${clgCode}/");

                        await reference.update({
                          values!['uid'] : false,
                        }).whenComplete(() => () {
                          Navigator.pop(context);
                        });

                        Fluttertoast.showToast(msg: "Removed");

                      }, icon: Icon(Icons.remove)),
                      IconButton(onPressed: () async {
                        DatabaseReference reference = FirebaseDatabase.instance.ref("collageStaff/${clgCode}/");

                        await reference.update({
                          values!['uid'] : true,
                        }).whenComplete(() => () {
                          Navigator.pop(context);
                        });
                        Fluttertoast.showToast(msg: "Added");
                      }, icon: Icon(Icons.add))
                    ],
                  ),
                ),
              );
              // return noticeItem(getFireNoticeUrl(values!['fileName']), values!['title'], values!['desc']);
            },
            physics: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
