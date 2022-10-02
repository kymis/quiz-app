import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionsAsked = StateProvider<int>((ref) => 0);
final questionsCorrect = StateProvider<int>((ref) => 0);