import 'package:flutter/material.dart';
import 'package:flutter_ui/data/my_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColors.primary,
        appBar: AppBar(
          title: Text("Register Screen"),
        ),
        body: Container(
          child: Center(
            child: Text("Register Screen"),
          ),
        ));
  }
}
