
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString("token"),));
}

class MyApp extends StatelessWidget{
  final token;
  const MyApp ({
    @required this.token,
    Key? key,
  }): super(key: key);

  
}