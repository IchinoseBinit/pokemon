import 'package:flutter/material.dart';

class BodyTemplate extends StatelessWidget {
  const BodyTemplate({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
