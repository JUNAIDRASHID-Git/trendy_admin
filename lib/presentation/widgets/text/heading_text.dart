import 'package:flutter/material.dart';

Text headingText(String text,Color color) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: color,
    ),
  );
}
