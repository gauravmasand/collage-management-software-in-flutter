import 'package:collagemanagementsystem/models/CourcesModel.dart';
import 'package:collagemanagementsystem/screens/LoginPage.dart';
import 'package:collagemanagementsystem/utils/FireAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminSignupPage1 extends StatefulWidget {
  const AdminSignupPage1({Key? key}) : super(key: key);

  @override
  State<AdminSignupPage1> createState() => _AdminSignupPage1State();
}

class _AdminSignupPage1State extends State<AdminSignupPage1> with TickerProviderStateMixin {

  late TabController _tabController;
  late String collageName, email, password;
  late int coursesCount = -1, roomsInCollageCount = -1, labsInCollageCount = -1;
  List<CoursesModel> courseModel = [];
  late TextEditingController collageNameController, emailController, passwordController, coursesCountController, roomsInCollageCountController, labsInCollageCountController, extraController;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  late List<TextEditingController> controllerList;
  late List<TextEditingController> controllerYearList;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    collageNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    coursesCountController = TextEditingController();
    roomsInCollageCountController = TextEditingController();
    labsInCollageCountController = TextEditingController();
    extraController = TextEditingController();
  }

  redirectToLogin(context) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_tabController.index!=0) {
          _tabController.animateTo((_tabController.index - 1));
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              if (_tabController.index==0) {
                Navigator.pop(context);
              } else {
                _tabController.animateTo((_tabController.index - 1));
              }
            },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            Form(
              key: _formKey1,
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
                          makeInput(label: "Collage name"),
                          makeInput(label: "Email"),
                          makeInput(label: "Password", obscureText: true),
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
                            _formKey1.currentState?.validate();
                            if (email.isNotEmpty && password.isNotEmpty && collageName.isNotEmpty && password.length>=6 && email.contains("@") && email.contains(".")) {
                              _tabController.animateTo(_tabController.index + 1);
                            }
                          },
                          color: Colors.greenAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Text("Next", style: TextStyle(
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
            Form(
              key: _formKey2,
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
                          makeInput(label: "Number of courses in collage"),
                          makeInput(label: "Number of rooms in collage"),
                          makeInput(label: "Number of labs in collage"),
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
                            _formKey2.currentState?.validate();
                            if (!coursesCount!.isNegative && !roomsInCollageCount.isNegative && !labsInCollageCount.isNegative && coursesCount!=0 && roomsInCollageCount!=0 && labsInCollageCount!=0) {
                              controllerList = List.generate(coursesCount, (i) => TextEditingController());
                              controllerYearList = List.generate(coursesCount, (i) => TextEditingController());
                              _tabController.animateTo(_tabController.index + 1);
                            }
                          },
                          color: Colors.greenAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Text("Next", style: TextStyle(
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
            Form(
              key: _formKey3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 40,),
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
                    SizedBox(height: 50,),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: !coursesCount.isNegative ? coursesCount : 0,
                      itemBuilder: (context, index) {
                        return makeCourseInput(index);
                      },
                    ),
                    SizedBox(height: 70,),
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
                          _openLoadingDialog(context);
                          for (int i = 0; i < controllerList.length; i++) {
                            courseModel.add(new CoursesModel(controllerYearList[i].text, controllerList[i].text));
                          }
                          FireAuth.signupAdmin(
                              context: context,
                              collageName: collageName,
                              email: email,
                              pass: password,
                              courseCount: coursesCount.toString(),
                              roomCount: roomsInCollageCount.toString(),
                              labsCount: labsInCollageCount.toString(),
                              coursesModel: courseModel
                          );
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
                    SizedBox(height: 50,),
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
         ],
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, number = false}) {
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
          controller: label=="Collage name" ? collageNameController :
                        label=="Email" ? emailController :
                        label=="Password" ? passwordController :
                        label=="Number of courses in collage" ? coursesCountController :
                        label=="Number of rooms in collage" ? roomsInCollageCountController :
                        label=="Number of labs in collage" ? labsInCollageCountController :
                        extraController,
          textInputAction: TextInputAction.next,
          keyboardType: label=="Collage name" ? TextInputType.name :
                        label=="Email" ? TextInputType.emailAddress :
                        label=="Password" ? TextInputType.visiblePassword :
                        label=="Number of courses in collage" ? TextInputType.number :
                        label=="Number of rooms in collage" ? TextInputType.number :
                        label=="Number of labs in collage" ? TextInputType.number :
                        TextInputType.text,
          inputFormatters: label=="Number of courses in collage" ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] :
                          label=="Number of rooms in collage" ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] :
                          label=="Number of labs in collage" ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] :
                          <TextInputFormatter>[],
          validator: (value) {
            if (label=="Collage name" && value!.isEmpty) {
              return "Collage name is empty";
            } else if (label=="Email" && value!.isEmpty) {
              return "Email is empty";
            }  else if (label=="Email" && !value!.contains("@")) {
              return "Email is not valid";
            }   else if (label=="Email" && !value!.contains(".")) {
              return "Email is not valid";
            } else if (label=="Password" && value!.isEmpty) {
              return "Password is empty";
            } else if (label=="Password" && value!.length<=6) {
              return "Password is too short";
            } else if (label=="Number of courses in collage" && value!.isEmpty) {
              return "Courses count is empty";
            }  else if (label=="Number of courses in collage" && value=="0") {
              return "Courses count can not be zero";
            } else if (label=="Number of rooms in collage" && value!.isEmpty) {
              return "Class room count is empty";
            } else if (label=="Number of rooms in collage" && value=="0") {
              return "Number of rooms in collage can not be zero";
            } else if (label=="Number of labs in collage" && value!.isEmpty) {
              return "Labs count is empty";
            }  else if (label=="Number of labs in collage" && value=="0") {
              return "Number of labs in collage can not be 0";
            } else {
              return null;
            }
          },
          onChanged: (v) {
            if (label=="Collage name") {
              collageName = v;
            } else if (label=="Email") {
              email = v;
            } else if (label=="Password") {
              password = v;
            } else if (label=="Number of courses in collage") {
              coursesCount = int.parse(v);
            } else if (label=="Number of rooms in collage") {
               roomsInCollageCount = int.parse(v);
            } else if (label=="Number of labs in collage") {
              labsInCollageCount = int.parse(v);
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

  Widget makeCourseInput(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter course name", style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: 5,),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: TextFormField(
                controller: controllerList[index],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty credentials";
                  } return null;
                },
                onChanged: (v) {

                },
                decoration: InputDecoration(
                  hintText: "(eg computer science)",
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Flexible(
              child: TextFormField(
                controller: controllerYearList[index],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty credentials";
                  } return null;
                },
                onChanged: (v) {

                },
                decoration: InputDecoration(
                  hintText: "(eg. 3 year)",
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                ),
              ),
            ),
          ],
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
