import 'dart:io';

import 'package:collagemanagementsystem/utils/FireRealTime.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/UserSimplePreferences.dart';

class AddEventsScreen extends StatefulWidget {
  const AddEventsScreen({Key? key}) : super(key: key);

  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {

  late String title = "", desc = "";
  final _formKey = GlobalKey<FormState>();
  late XFile? file;
  int listLength = 0;

  getPer() async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
  }

  @override
  void initState() {
    getPer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      body: Form(
        key: _formKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Add Events", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextButton(onPressed: () async {
                        file = null;
                        ImagePicker imgPick = ImagePicker();
                        file = await imgPick.pickImage(source: ImageSource.gallery);
                        listLength = 1;
                        setState(() {});
                      }, child: "Open Gallery".text.make().p(5).px(10)).py(10),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Image.file(File(file!.path));
                        },
                        itemCount: listLength,
                      ),
                      makeInput(label: "Title"),
                      makeInput(label: "Desc"),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        _openLoadingDialog(context);
                        if (file==null) return;
                        print(file!.path);
                        String url;
                        Reference ref = FirebaseStorage.instance.ref();
                        String fileName = "events" + DateTime.now().millisecondsSinceEpoch.toString();
                        Reference refn = ref.child("events");
                        Reference uploadRef = refn.child("${fileName}");
                        try {
                          uploadRef.putFile(File(file!.path));
                          print("completed");

                          String? clgCode = UserSimplePreferences.getCollageCode();
                          DatabaseReference reference = FirebaseDatabase.instance.ref("collage/${clgCode}/events/${DateTime.now().millisecondsSinceEpoch.toString()}");
                          await reference.set({
                            "uid" : FirebaseAuth.instance.currentUser?.uid,
                            "title" : title,
                            "desc" : desc,
                            "fileName" : fileName
                          }).whenComplete(() => () {
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);

                          // FireRealtime.addEvents(context: context, fileName: fileName, title: title, desc: desc);
                        } catch (e) {
                          Fluttertoast.showToast(msg: "Failed to do");
                        }
                      },
                      color: Colors.greenAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("Add", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextFormField(
          onChanged: (value) {
            if (label=="Title") {
              title = value;
            } else if (label=="Desc") {
              desc = value;
            }
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }

  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
