import 'package:flutter/material.dart';
import 'package:mono/constants/app_color.dart';

InputDecoration dropdowndecor() {
   
    return InputDecoration(
        //  isCollapsed: true,
        isDense: false,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainHexcolor, width: 1.0),
            borderRadius: BorderRadius.circular(4)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(4)));
  }

   InputDecoration textfielddecor(String text) {
    return InputDecoration(
        errorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: mainHexcolor)),
        hintText: text,
        border: const OutlineInputBorder());
  }
  Text textstyle(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 116, 112, 112)),
    );
  }