import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallWidgets {
  static void openImage(BuildContext context, fileName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(child: Image.network(fileName
        ));
      },
    );
  }
}