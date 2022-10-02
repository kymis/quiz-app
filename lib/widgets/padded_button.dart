import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PaddedNavigationButton extends ConsumerWidget {
  final String path;
  final String text;
  const PaddedNavigationButton(this.path, this.text);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
        child: ElevatedButton(
          onPressed: () {
            context.go(path);
          },
          child: Text(text),
        ));
  }
}

class PaddedNavigationButtonWithCallBack extends ConsumerWidget {
  final String text;
  final VoidCallback callback;
  const PaddedNavigationButtonWithCallBack(this.text, this.callback);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          onPressed: () => callback(),
          child: Text(text),
        ));
  }
}
