import 'package:go_router/go_router.dart';

import '../screens/main_screen.dart';
import '../screens/result_screen.dart';
import '../screens/question_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => MainScreen()),
    GoRoute(
        path: '/topic/:id',
        builder: (context, state) => QuestionScreen(state.params['id']!)),
    GoRoute(
        path: '/results/:correct/:id',
        builder: (context, state) =>
            ResultScreen(state.params['correct']!, state.params['id']!)),
  ],
);
