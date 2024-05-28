import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdl/config.dart';
import 'package:tdl/logo.dart';
import 'package:velocity_x/velocity_x.dart';
import 'loginPage.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  bool _isPasswordVisible = false;

  void registerUser() async {
    setState(() {
      _isNotValidate = false;
    });

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      final response = await http.post(
        Uri.parse(register),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong, please try again.')),
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
                  "CREATE YOUR ACCOUNT".text.size(22).yellow100.make(),
                  buildTextField(
                    controller: emailController,
                    hintText: "Email",
                  ),
                  buildPasswordField(),
                  HeightBox(10),
                  buildRegisterButton(),
                  HeightBox(10),
                  buildSignInLink(),
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          errorText: _isNotValidate ? "Enter proper info" : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: TextField(
        controller: passwordController,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Password",
          errorText: _isNotValidate ? "Enter proper info" : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          prefixIcon: IconButton(
            icon: Icon(Icons.password),
            onPressed: () {
              String passGen = generatePassword();
              passwordController.text = passGen;
              setState(() {});
            },
          ),
          suffixIcon: IconButton(
            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildRegisterButton() {
    return GestureDetector(
      onTap: registerUser,
      child: HStack([
        VxBox(child: "Register".text.white.makeCentered().p16())
            .green600
            .roundedLg
            .make()
            .px16()
            .py16(),
      ]),
    );
  }

  Widget buildSignInLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: HStack([
        "Already Registered?".text.make(),
        " Sign In".text.white.make(),
      ]).centered(),
    );
  }
}

String generatePassword() {
  const String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String lower = 'abcdefghijklmnopqrstuvwxyz';
  const String numbers = '1234567890';
  const String symbols = '!@#\$%^&*()<>,./';

  const int passLength = 20;
  String seed = upper + lower + numbers + symbols;
  

  List<String> list = seed.split('');
  Random rand = Random();

  return List.generate(passLength, (index) {
    int randomIndex = rand.nextInt(list.length);
    return list[randomIndex];
  }).join();
}
