import 'dart:convert';
import 'package:http/http.dart' as http;

class QuestionService {
  String topicId = "";
  String answerpath = "";
  String answer = "";
  QuestionService();
  QuestionService.questions(this.topicId);
  QuestionService.results(this.answerpath, this.answer);

  final String endpoint = "https://dad-quiz-api.deno.dev";

  Future<List> fetchTopics() async {
    var response = await http.get(Uri.parse('$endpoint/topics'));
    return jsonDecode(response.body);
  }

  Future<Map> fetchTopicQuestions() async {
    var response =
        await http.get(Uri.parse('$endpoint/topics/$topicId/questions'));
    return jsonDecode(response.body);
  }

  Future<bool> fetchTopicResults() async {
    var response = await http.post(Uri.parse('$endpoint$answerpath'),
        body: jsonEncode({'answer': answer}));
    var data = jsonDecode(response.body);
    return data['correct'];
  }
}
