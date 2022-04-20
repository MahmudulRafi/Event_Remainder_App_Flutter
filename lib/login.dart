import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? loginEmail;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  @override
  void initState() {
    getValidator();
    super.initState();
  }

   getValidator() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userEmail = sharedPreferences.getString('email');
     if(userEmail != null){
       Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Home()));
     }
     setState(() {

     });
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 140, bottom: 32, right: 50, left: 50),
                        child: CircleAvatar(
                          radius: 68,
                          backgroundColor: Colors.deepOrange,
                          child: CircleAvatar(
                            radius: 67,
                            backgroundImage: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/295/295128.png"),
                          ),
                        ),
                      ),
                      const Text("Employee Login",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 23,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 35, left: 28, right: 28, bottom: 10),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 25, left: 28, right: 28, bottom: 32),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              "email", emailController.text);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => Home()));
                        },
                        child: const Text("Login"),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(180, 50),
                            primary: Colors.deepOrange),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
