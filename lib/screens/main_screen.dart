import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/padded_button.dart';
import '../widgets/padded_text.dart';
import '../widgets/responsive_widget.dart';
import '../providers/providers.dart';
import '../services/api.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text("Dad Quiz")),
        body: Center(
            child: Column(children: [
          const PaddedText("Quiz time"),
          FutureBuilder(
            future: QuestionService().fetchTopics(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Waiting for topics");
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData) {
                return const Text("No topics available");
              } else {
                List content = snapshot.data!;
                List<Widget> contentWidgets = content
                    .map((topic) => PaddedNavigationButton(
                        "/topic/${topic["id"]}", topic["name"]))
                    .toList();
                return content.isEmpty
                    ? const Text("No topics available")
                    : ResponsiveWidget(
                        mobile: Column(children: contentWidgets),
                        desktop: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: contentWidgets));
              }
            },
          ),
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
