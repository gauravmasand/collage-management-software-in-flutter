import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MessageScreen extends StatelessWidget {
  String msg;
  MessageScreen({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: msg.text.black.make().centered(),
        ),
      ),
    );
  }
}
