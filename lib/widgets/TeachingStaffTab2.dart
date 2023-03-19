import 'package:collagemanagementsystem/utils/UserSimplePreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'SmallWidgets.dart';

class TeachingStaffTab2 extends StatefulWidget {
  const TeachingStaffTab2({Key? key}) : super(key: key);

  @override
  State<TeachingStaffTab2> createState() => _TeachingStaffTab2State();
}

class NoticeModel {
  late String sno, title, desc, image;
  NoticeModel(this.sno, this.title, this.desc, this.image);
}

class _TeachingStaffTab2State extends State<TeachingStaffTab2> {

  late double width;
  late double height;
  List<NoticeModel> list = [];

  String? clgUid = UserSimplePreferences.getCollageCode();


  @override
  void initState() {
    super.initState();
  }

  getFireNoticeUrl(String fileName) {
    return "https://firebasestorage.googleapis.com/v0/b/collage-management-syste-9dc73.appspot.com/o/notices%2F" + fileName + "?alt=media&token=ecde1d53-2509-49dd-8460-db6f9359a47d";
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
        title: "NOTICE".text.black.make(),
        elevation: 0,
        backgroundColor: Colors.blue.withOpacity(0.1),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
        ),
        child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.reference().child('collage').child(clgUid!).child("notices").orderByKey(),
          reverse: true,
          itemBuilder: (context, DataSnapshot snapshot, animation, index) {
            Map<dynamic, dynamic>? values = snapshot.value as Map?;
            return noticeItem(getFireNoticeUrl(values!['fileName']), values!['title'], values!['desc']);
          },
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
  
  Widget noticeItem(String url, String title, String subTitle) {
    return InkWell(
      onTap: () {
        SmallWidgets.openImage(context, url);
      },
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Image.network(
                url,
                width: title=="" || subTitle=="" ? width-30 : width*0.5,
                height: width*0.5,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10,),
            title=="" || subTitle=="" ? SizedBox() : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title!="" ? SizedBox(
                  width: width*0.4,
                  child: title.text.xl2.black.maxLines(1).overflow(TextOverflow.ellipsis).make(),
                ) : SizedBox(),
                subTitle!="" ? SizedBox(
                  width: width*0.4,
                  child: subTitle.text.xl.black.maxLines(5).overflow(TextOverflow.ellipsis).make(),
                ) : SizedBox(),
              ],
            ),
          ],
        ),
      ).py(5).px(5),
    );
  }
}