import 'package:flutter/material.dart';
import 'package:medrec/extras/user.dart';
import 'package:medrec/page/home_page.dart';
import 'package:medrec/page/registratiion.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String url = "http://localhost:8080/signin";
  @override
  Widget build(BuildContext context) {
    User user = User('', '');
    Future save() async {
      try {
        var res = await http.post(Uri.parse(url), headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        }, body: <String, String>{
          'email': user.email,
          'password': user.password
        });
        if (res.statusCode == 200) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          print(res.body);
        } else {
          print(res.body);
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/register.jpeg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const HeightBox(10),
                "Email Sign-In".text.size(25).bold.yellow100.make(),
                TextField(
                    onChanged: (value) {
                      user.email = value;
                    },
                  keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ).p4().px24(),
                TextField(
                    onChanged: (value) {
                    user.password = value;
                    },
                  keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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
                    child: VxBox(child: "Login".text.white.makeCentered().p16())
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registration()));
                  },
                  child: HStack([
                    "Create a new account?".text.yellow50.bold.size(22).make(),
                    " Sign Up".text.yellow200.bold.size(22).make()
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
