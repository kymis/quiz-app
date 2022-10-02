import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/padded_button.dart';
import '../widgets/padded_text.dart';
import '../providers/providers.dart';

class ResultScreen extends ConsumerWidget {
  String correct;
  String id;
  ResultScreen(this.correct, this.id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text("Dad Quiz")),
        body: Center(
            child: Column(children: [
          correct == "1"
              ? const PaddedText("Answer correct")
              : const PaddedText("Answer incorrect"),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const PaddedNavigationButton("/", "Back to topics"),
            PaddedNavigationButton("/topic/$id", "Show new question")
          ]),
          if (ref.watch(questionsAsked) > 0)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                  padding: const EdgeInsets.all(24),
                  child:
                      Text("Questions answered: ${ref.watch(questionsAsked)}")),
              Padding(
                  padding: const EdgeInsets.all(24),
                  child:
                      Text("Correct answers: ${ref.watch(questionsCorrect)}"))
            ])
        ])));
  }
}
