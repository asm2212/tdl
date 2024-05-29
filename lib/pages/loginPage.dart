import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdl/config.dart'; // Ensure this file contains the correct URL for your server
import 'package:tdl/dashboard.dart';
import 'package:tdl/logo.dart';
import 'package:tdl/pages/registerPage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> loginUser() async {
    setState(() {
      _isNotValidate = false;
    });

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      try {
        final response = await http.post(
          Uri.parse(login), // Ensure the `login` variable contains the correct URL
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody),
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);

          if (jsonResponse['status']) {
            final myToken = jsonResponse['token'];
            prefs.setString('token', myToken);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboard(token: myToken)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Invalid email or password')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Server error: ${response.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error: $e')),
        );
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0XFFF95A3B), Color(0XFFF96713)],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 0.8],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonLogo(),
                  HeightBox(10),
                  "Email Sign-In".text.size(22).yellow100.make(),
                  buildTextField(
                    controller: emailController,
                    hintText: "Email",
                  ),
                  buildTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  HeightBox(10),
                  buildLoginButton(),
                  HeightBox(10),
                  buildSignUpLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          errorText: _isNotValidate ? "Enter Proper Info" : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return GestureDetector(
      onTap: loginUser,
      child: HStack([
        VxBox(child: "LogIn".text.white.makeCentered().p16())
            .green600
            .roundedLg
            .make(),
      ]),
    );
  }

  Widget buildSignUpLink() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      child: Container(
        height: 25,
        color: Color.fromARGB(255, 5, 234, 74),
        child: Center(
          child: "Create a new Account..! Sign Up".text.white.makeCentered(),
        ),
      ),
    );
  }
}
