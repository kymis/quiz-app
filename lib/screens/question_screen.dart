import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/padded_button.dart';
import '../widgets/responsive_widget.dart';
import '../providers/providers.dart';
import '../services/api.dart';
import 'package:go_router/go_router.dart';

class QuestionScreen extends ConsumerWidget {
  String id;
  QuestionScreen(this.id);

  void correctAnswer(BuildContext context, WidgetRef ref) {
    ref.watch(questionsAsked.notifier).update((s) => s + 1);
    ref.watch(questionsCorrect.notifier).update((s) => s + 1);
    context.go("/results/1/$id");
  }

  void incorrectAnswer(BuildContext context, WidgetRef ref) {
    ref.watch(questionsAsked.notifier).update((s) => s + 1);
    context.go("/results/0/$id");
  }

  void fetchTopics(
      BuildContext context, String answer, String path, WidgetRef ref) async {
    await QuestionService.results(path, answer).fetchTopicResults().then(
        (r) => r ? correctAnswer(context, ref) : incorrectAnswer(context, ref));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text("Dad Quiz")),
        body: Center(
            child: ListView(children: [
          FutureBuilder(
            future: QuestionService.questions(id).fetchTopicQuestions(),
            builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Waiting for question");
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData) {
                return const Text("No question available");
              } else {
                Map content = snapshot.data!;
                List<Widget> answers = [
                  for (var i in content["options"])
                    PaddedNavigationButtonWithCallBack(
                        i,
                        () => fetchTopics(
                            context, i, content["answer_post_path"], ref))
                ];
                return content.isEmpty
                    ? const Text("No question available")
                    : Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(content["question"], textScaleFactor: 2),
                        ),
                        if (content.containsKey("image_url"))
                          Image(
                            image: NetworkImage(content["image_url"]),
                          ),
                        ResponsiveWidget(
                            mobile: Column(children: answers),
                            desktop: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: answers))
                      ]);
              }
            },
          ),
          Column(
              children: const [PaddedNavigationButton("/", "Back to topics")])
        ])));
  }
}
