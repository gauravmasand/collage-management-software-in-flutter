import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/UserSimplePreferences.dart';
import 'SmallWidgets.dart';

class TeachingStaffTab3 extends StatefulWidget {
  const TeachingStaffTab3({Key? key}) : super(key: key);

  @override
  State<TeachingStaffTab3> createState() => _TeachingStaffTab3State();
}

class EventsModel {
  late String sno, title, desc, image;
  EventsModel(this.sno, this.title, this.desc, this.image);
}

class _TeachingStaffTab3State extends State<TeachingStaffTab3> {

  late double width;
  late double height;
  List<EventsModel> list = [];
  String? clgUid = UserSimplePreferences.getCollageCode();
  ScrollController controller = ScrollController();

  getFireEventsUrl(String fileName) {
    return "https://firebasestorage.googleapis.com/v0/b/collage-management-syste-9dc73.appspot.com/o/events%2F" + fileName + "?alt=media&token=b86fe3ca-d19f-4115-8980-4529b344137f";
  }

  @override
  void initState() {
    super.initState();

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
        title: "EVENTS".text.black.make(),
        elevation: 0,
        backgroundColor: Colors.blue.withOpacity(0.1),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
        ),
        child: FirebaseAnimatedList(
          controller: controller,
          query: FirebaseDatabase.instance.reference().child('collage').child(clgUid!).child("events").orderByKey(),
          reverse: true,
          shrinkWrap: true,
          itemBuilder: (context, DataSnapshot snapshot, animation, index) {
            Map<dynamic, dynamic>? values = snapshot.value as Map?;
            return eventsItem(getFireEventsUrl(values!['fileName']), values!['title'], values!['desc']);
          },
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }

  Widget eventsItem(String url, String title, String subTitle) {
    return InkWell(
      onTap: () {
        SmallWidgets.openImage(context, url);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Image.network(
                url,
                width: width,
                height: width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: width,
                  child: title.text.xl2.black.maxLines(1).overflow(TextOverflow.ellipsis).make(),
                ),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: width,
                  child: subTitle.text.xl.black.maxLines(2).overflow(TextOverflow.ellipsis).make(),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ],
        ),
      ).py(5).px(5),
    );
  }
}