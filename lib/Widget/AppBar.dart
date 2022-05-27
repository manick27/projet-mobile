import 'package:flutter/material.dart';

AppBarMenu(title){
  return AppBar(
    title: Text(title),
    centerTitle: true,
    leading: Icon(Icons.reorder),
    actions: [
      Container(
        margin: EdgeInsets.only(right: 10.0),
      )
    ],
  );
}