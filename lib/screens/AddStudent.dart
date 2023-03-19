import 'package:collagemanagementsystem/utils/UserSimplePreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  late String title;
  final _formKey = GlobalKey<FormState>();
  int listLength = 0;

  @override
  void initState() {

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 200,),
                "Select the branch".text.xl.make().px(25),
                FirebaseAnimatedList(
                  primary: false,
                  shrinkWrap: true,
                  query: FirebaseDatabase.instance.reference().child('collage').child(UserSimplePreferences.getCollageCode()!).child("courses").orderByKey(),
                  itemBuilder: (context, DataSnapshot snapshot, animation, index) {
                    Map<dynamic, dynamic>? values = snapshot.value as Map?;
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudent2(branch: values!['courseName'], year: values!['courseYear'], index: index)));
                      },
                      child: Container(
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 0.1, color: Colors.grey, style: BorderStyle.solid),
                        ),
                        child: Text(values!['courseName'], style: TextStyle(color: Colors.black, fontSize: 18),).px(10).py(5),
                      ),
                    ).px(20).py(5);
                  },
                  physics: BouncingScrollPhysics(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class AddStudent2 extends StatefulWidget {
  late String branch;
  late String year;
  late int index;
  AddStudent2({Key? key, required this.branch, required this.year, required this.index}) : super(key: key);

  @override
  State<AddStudent2> createState() => _AddStudent2State();
}

class _AddStudent2State extends State<AddStudent2> {

  final _formKey = GlobalKey<FormState>();
  int listLength = 0;
  late String yearOfStudy = "", nameOfStudent = "", castOfStudent = "", enrollmentNo = "", fatherName = "", motherName = "", totalFees = "", scholarship = "no", feesCompleted = "", email = "", phoneNumber = "";

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Enter students details", style: TextStyle(color: Colors.black),).px(20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20,),
                makeInput(label: "Year of Study").px(20),
                makeInput(label: "Name of student").px(20),
                makeInput(label: "Cast of student").px(20),
                makeInput(label: "Enrollment number").px(20),
                makeInput(label: "Father name (optional)").px(20),
                makeInput(label: "Mother name (optional)").px(20),
                makeInput(label: "Phone number").px(20),
                makeInput(label: "Email").px(20),
                Text("Eligible for scholar ship").px(20),
                Column(
                  children: [
                    RadioListTile(
                      title: Text("Yes"),
                      value: "Yes",
                      groupValue: scholarship,
                      onChanged: (value){
                        setState(() {
                          scholarship = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("No"),
                      value: "No",
                      groupValue: scholarship,
                      onChanged: (value){
                        setState(() {
                          scholarship = value.toString();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                makeInput(label: "Total fees").px(20),
                makeInput(label: "Fees completed").px(20),
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

                        var dt = DateTime.now();
                        String year = dt.year.toString();

                        if (int.parse(yearOfStudy)<=0) {
                          Fluttertoast.showToast(msg: "Invalid year of study");
                        } else if (int.parse(yearOfStudy)<=int.parse(widget.year)) {
                          DatabaseReference reference = FirebaseDatabase.instance.ref("collage/${UserSimplePreferences.getCollageCode()}/courses/${widget.index}/${year}/${yearOfStudy}/${DateTime.now().millisecondsSinceEpoch.toString()}");
                          await reference.set({
                            "addedByUid" : FirebaseAuth.instance.currentUser?.uid,
                            "nameOfStudent" : nameOfStudent,
                            "castOfStudent" : castOfStudent,
                            "enrollmentNo" : enrollmentNo,
                            "fatherName" : fatherName,
                            "motherName" : motherName,
                            "eligibleForScholarship" : scholarship,
                            "totalFees" : totalFees,
                            "feesCompleted" : feesCompleted,
                            "email" : email,
                            "phoneNumber" : phoneNumber,
                            "date" : "${DateTime.now().minute}:${DateTime.now().hour} - ${DateTime.now().day}:${DateTime.now().month}:${DateTime.now().year}"
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: "Added");
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
                SizedBox(height: 50,),
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
          keyboardType: label=="Year of Study" || label=="Phone number" ? TextInputType.number : TextInputType.text,
          inputFormatters:<TextInputFormatter>[
            label=="Year of Study" || label=="Phone number" ? FilteringTextInputFormatter.digitsOnly :  FilteringTextInputFormatter.singleLineFormatter
          ],
          onChanged: (value) {
            if (label=="Year of Study") {
              yearOfStudy = value;
            } else if (label=="Name of student") {
              nameOfStudent = value;
            } else if (label=="Cast of student") {
              castOfStudent = value;
            } else if (label=="Enrollment number") {
              enrollmentNo = value;
            } else if (label=="Father name (optional)") {
              fatherName = value;
            } else if (label=="Mother name (optional)") {
              motherName = value;
            } else if (label=="Total fees") {
              totalFees = value;
            } else if (label=="Fees completed") {
              feesCompleted = value;
            } else if (label=="Phone number") {
              phoneNumber = value;
            } else if (label=="Email") {
              email = value;
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
