import 'dart:io';

class QuizItem {
  final String type; // "Quiz", "Slide", or "True or False"
  String? question; // For Quiz and True or False
  String? title; // For Slide
  String? description; // For Slide
  List<String>? options; // For Quiz, list of options
  String? selectedAnswer; // For True or False, "True" or "False"
  int? timeLimit; // Time limit in seconds
  int? correctOptionIndex; // For Quiz, index of the correct option (0-based)
  File? image; // Optional image for any question type

  QuizItem({
    required this.type,
    this.question,
    this.title,
    this.description,
    this.options,
    this.selectedAnswer,
    this.timeLimit,
    this.correctOptionIndex,
    this.image,
  });

  // Convert to a string for display in the questions list
  String toDisplayString() {
    final imageStatus = image != null ? 'Image Attached' : 'No Image';
    switch (type) {
      case 'Quiz':
        return '$question (Options: ${options?.join(', ') ?? 'None'}, Correct: ${options != null && correctOptionIndex != null && correctOptionIndex! < options!.length ? options![correctOptionIndex!] : 'None'}, $imageStatus)';
      case 'Slide':
        return '$title - $description ($imageStatus)';
      case 'True or False':
        return '$question ($selectedAnswer, $imageStatus)';
      default:
        return 'Unknown Question Type ($imageStatus)';
    }
  }
}