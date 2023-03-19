import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collagemanagementsystem/screens/AdminSignupPage.dart';
import 'package:collagemanagementsystem/screens/LoginPage.dart';
import 'package:velocity_x/velocity_x.dart';

import 'SignupStaff.dart';

class SignupOptionsScreen extends StatelessWidget {

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 75,
                height: 75,
                child: Icon(
                  CupertinoIcons.back,
                  size: 25,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Signup", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),),
                      SizedBox(height: 20,),
                      Text("Select an signup option",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15
                        ),),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/Illustration.png'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupStaffScreen()));
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black
                            ),
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text("Staff Signup", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),),
                      ),
                      SizedBox(height: 20,),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSignupPage1()));
                          },
                          color: Colors.yellow,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Text("Create Collage Profile", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}

