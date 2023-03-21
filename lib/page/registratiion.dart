import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medrec/core/color.dart';
import 'package:medrec/extras/user.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'loginPage.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  String url = "http://localhost:8080/signup";
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    User user = User('', '');
    Future save() async {
      var res = await http.post(Uri.parse(url), headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      }, body: <String, String>{
        'email': user.email,
        'password': user.password
      });
      if (res.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
        print(res.body);
      } else {
        print(res.body);
      }
    }

    return Scaffold(
      backgroundColor: white,
      body: Container(
        key: _formKey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/register.jpeg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HeightBox(10),
                "CREATE YOUR ACCOUNT".text.size(25).bold.yellow100.make(),
                TextField(
                  onChanged: (value) {
                    user.email = value;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.white),
                      errorText: _isNotValidate ? "Enter Proper Info" : null,
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ).p4().px24(),
                TextField(
                  onChanged: (value) {
                    user.password = value;
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.white),
                      errorText: _isNotValidate ? "Enter Proper Info" : null,
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ).p4().px24(),
                HStack([
                  GestureDetector(
                    onTap: () {
                      save();
                    },
                    child:
                        VxBox(child: "Register".text.white.makeCentered().p16())
                            .green600
                            .roundedLg
                            .make()
                            .px16()
                            .py16(),
                  ),
                ]),
                GestureDetector(
                  onTap: () {
                    print("Sign In");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                  child: HStack([
                    "Already Registered?".text.yellow50.bold.size(22).make(),
                    " Sign In".text.yellow200.bold.size(22).make()
                  ]).centered(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
