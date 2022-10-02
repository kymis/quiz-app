import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/responsive_widget.dart';
import 'routes/router.dart';

main() {
  runApp(ProviderScope(
      child: ResponsiveWidget(
          mobile:
              MaterialApp.router(theme: ThemeData.dark(), routerConfig: router),
          desktop: MaterialApp.router(
              theme: ThemeData.light(), routerConfig: router))));
}
