import 'package:collagemanagementsystem/widgets/TeachingStaffTab2.dart';
import 'package:collagemanagementsystem/widgets/TeachingStaffTab3.dart';
import 'package:collagemanagementsystem/widgets/TeachingStaffTab4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/TeachingStaffTab1.dart';

class TeachingStaffHomeScreen extends StatefulWidget {
  const TeachingStaffHomeScreen({Key? key}) : super(key: key);

  @override
  State<TeachingStaffHomeScreen> createState() => _TeachingStaffHomeScreenState();
}

class _TeachingStaffHomeScreenState extends State<TeachingStaffHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(CupertinoIcons.home, color: Colors.black),),
            Tab(icon: Icon(Icons.document_scanner_outlined, color: Colors.black),),
            Tab(icon: Icon(CupertinoIcons.calendar, color: Colors.black),),
            Tab(icon: Icon(Icons.person, color: Colors.black),),
          ],
          splashBorderRadius: BorderRadius.circular(50),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
        body: SafeArea(
          child: Container(
            child: TabBarView(
              children: [
                TeachingStaffTab1(),
                TeachingStaffTab2(),
                TeachingStaffTab3(),
                TeachingStaffTab4(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
