class Quiz {
  final String id;
  final String title;
  final String description;
  final String creatorId;
  final String creatorName;
  final List<Question> questions;
  final DateTime createdAt;
  final int plays;
  final String? coverImage;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.creatorId,
    required this.creatorName,
    required this.questions,
    required this.createdAt,
    this.plays = 0,
    this.coverImage,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      creatorId: json['creatorId'],
      creatorName: json['creatorName'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      plays: json['plays'] ?? 0,
      coverImage: json['coverImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creatorId': creatorId,
      'creatorName': creatorName,
      'questions': questions.map((q) => q.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'plays': plays,
      'coverImage': coverImage,
    };
  }
}

class Question {
  final String id;
  final String text;
  final List<Answer> answers;
  final int timeLimit; // in seconds
  final String? image;

  Question({
    required this.id,
    required this.text,
    required this.answers,
    this.timeLimit = 30,
    this.image,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'],
      answers: (json['answers'] as List)
          .map((a) => Answer.fromJson(a))
          .toList(),
      timeLimit: json['timeLimit'] ?? 30,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'answers': answers.map((a) => a.toJson()).toList(),
      'timeLimit': timeLimit,
      'image': image,
    };
  }
}

class Answer {
  final String id;
  final String text;
  final bool isCorrect;

  Answer({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      text: json['text'],
      isCorrect: json['isCorrect'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isCorrect': isCorrect,
    };
  }
}

