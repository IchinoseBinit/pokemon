import 'package:flutter/material.dart';

navigate(BuildContext context, Widget screen) async {
  return await Navigator.push(
      context, MaterialPageRoute(builder: (_) => screen));
}