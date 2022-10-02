import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveWidget({required this.mobile, required this.desktop});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return mobile;
      } else {
        return desktop;
      }
    });
  }
}
