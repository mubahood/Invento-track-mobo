import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/data/my_colors.dart';

Widget titleDetail(String title, String detail) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 14,
            height: 1,
            fontWeight: FontWeight.w300,
            color: Colors.grey.shade800),
      ),
      Text(
        detail.isNotEmpty ? detail : "-",
        style:
            TextStyle(fontSize: 18, height: 1.1, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget emptyListWidget(String message, String btnMsg, Function btnAction) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        SizedBox(
          height: 15,
        ),
        CupertinoButton(
          child: Text(btnMsg),
          onPressed: () {
            btnAction();
          },
          borderRadius: BorderRadius.circular(20),
          color: MyColors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
        )
      ],
    ),
  );
}
