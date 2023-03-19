import 'package:collagemanagementsystem/utils/FireAuth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'LoginPage.dart';

class SignupStaffScreen extends StatefulWidget {
  const SignupStaffScreen({Key? key}) : super(key: key);

  @override
  State<SignupStaffScreen> createState() => _SignupStaffScreenState();
}

class _SignupStaffScreenState extends State<SignupStaffScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController collageCodeController, nameController, emailController, passwordController, extraController;
  late String collageCode, email, password;
  bool teachingStaffValue = false;
  bool officeStaffValue = false;

  redirectToLogin(context) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    collageCodeController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Sign up", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 20,),
                      Text("Create an account, It's free", style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700]
                      ),),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      makeInput(label: "Collage code"),
                      makeInput(label: "Name"),
                      makeInput(label: "Email"),
                      makeInput(label: "Password", obscureText: true),
                      SizedBox(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  teachingStaffValue = true;
                                  officeStaffValue = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: teachingStaffValue ? Colors.greenAccent : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: teachingStaffValue ? Colors.grey : Colors.black)
                                ),
                                child: "Teaching Staff".text.xl.black.make().centered().px(15).py(10),
                              ),
                            ),
                            SizedBox(width: 15,),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  teachingStaffValue = false;
                                  officeStaffValue = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: officeStaffValue ? Colors.greenAccent : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: officeStaffValue ? Colors.grey : Colors.black)
                                ),
                                child: "Office Staff".text.xl.black.make().centered().px(15).py(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
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
                      onPressed: () {
                        _formKey.currentState?.validate();
                        if (collageCode.isEmpty && email.isEmpty && password.isEmpty) {
                          Fluttertoast.showToast(msg: "Empty Credentials");
                        } else if (teachingStaffValue==false && officeStaffValue==false) {
                          Fluttertoast.showToast(msg: "Please select staff type");
                        } else {
                          _openLoadingDialog(context);
                          FireAuth.signupStaff(
                              context: context,
                              email: email,
                              collageCode: collageCode,
                              name: nameController.text.toString(),
                              password: password,
                              position: teachingStaffValue ? "Teaching Staff" : officeStaffValue ? "Office Staff" : ""
                          );
                        }
                      },
                      color: Colors.greenAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("SIGNUP", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account?"),
                      InkWell(
                        onTap: () {
                          redirectToLogin(context);
                        },
                        child: Text(" Login", style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18,
                        ),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, number = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextFormField(
          controller: label=="Collage code" ? collageCodeController :
                      label=="Name" ? nameController :
                      label=="Email" ? emailController :
                      label=="Password" ? passwordController :
                      extraController,
          textInputAction: TextInputAction.next,
          keyboardType: label=="Collage code" ? TextInputType.text :
                        label=="Name" ? TextInputType.name :
                        label=="Email" ? TextInputType.emailAddress :
                        label=="Password" ? TextInputType.visiblePassword :
                        TextInputType.text,
          validator: (value) {
            if (label=="Name" && value!.isEmpty) {
              return "Enter a valid name";
            } else if (label=="Collage code" && value!.isEmpty) {
              return "Collage code is empty";
            } else if (label=="Email" && value!.isEmpty) {
              return "Email is empty";
            } else if (label=="Email" && !value!.contains("@")) {
              return "Email is invalid";
            } else if (label=="Email" && !value!.contains(".")) {
              return "Email is invalid";
            } else if (label=="Password" && value!.isEmpty) {
              return "Password is empty";
            } else {
              return null;
            }
          },
          onChanged: (v) {
            if (label == "Collage code") {
              collageCode = v;
            } else if (label == "Email") {
              email = v;
            } else if (label == "Password") {
              password = v;
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
