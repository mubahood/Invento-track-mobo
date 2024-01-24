import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Auth/RegisterScreen.dart';

class MenuRoute extends StatelessWidget {
  const MenuRoute();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Menu"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Register Screen"),
            onTap: () {
              Get.to(() => RegisterScreen());
            },
          ),
        ],
      ),
    );
  }
}
