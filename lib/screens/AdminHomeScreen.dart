import 'package:collagemanagementsystem/widgets/AdminTab1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/TeachingStaffTab2.dart';
import '../widgets/TeachingStaffTab3.dart';
import '../widgets/TeachingStaffTab4.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
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
                AdminTab1(),
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
