import 'package:flutter/material.dart';
import 'package:quiz_battle/models/quiz.dart';
import 'package:quiz_battle/theme/app_theme.dart';
import 'package:quiz_battle/widgets/gradient_button.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<Question> _questions = [];
  int _currentStep = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _addQuestion() {
    setState(() {
      _questions.add(
        Question(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: '',
          answers: [
            Answer(id: '1', text: '', isCorrect: true),
            Answer(id: '2', text: '', isCorrect: false),
            Answer(id: '3', text: '', isCorrect: false),
            Answer(id: '4', text: '', isCorrect: false),
          ],
        ),
      );
    });
  }

  void _removeQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  void _updateQuestionText(int index, String text) {
    setState(() {
      _questions[index] = Question(
        id: _questions[index].id,
        text: text,
        answers: _questions[index].answers,
        timeLimit: _questions[index].timeLimit,
        image: _questions[index].image,
      );
    });
  }

  void _updateAnswerText(int questionIndex, int answerIndex, String text) {
    final question = _questions[questionIndex];
    final answers = List<Answer>.from(question.answers);
    answers[answerIndex] = Answer(
      id: answers[answerIndex].id,
      text: text,
      isCorrect: answers[answerIndex].isCorrect,
    );

    setState(() {
      _questions[questionIndex] = Question(
        id: question.id,
        text: question.text,
        answers: answers,
        timeLimit: question.timeLimit,
        image: question.image,
      );
    });
  }

  void _setCorrectAnswer(int questionIndex, int answerIndex) {
    final question = _questions[questionIndex];
    final answers = List<Answer>.from(question.answers);

    for (int i = 0; i < answers.length; i++) {
      answers[i] = Answer(
        id: answers[i].id,
        text: answers[i].text,
        isCorrect: i == answerIndex,
      );
    }

    setState(() {
      _questions[questionIndex] = Question(
        id: question.id,
        text: question.text,
        answers: answers,
        timeLimit: question.timeLimit,
        image: question.image,
      );
    });
  }

  void _updateTimeLimit(int questionIndex, int timeLimit) {
    setState(() {
      _questions[questionIndex] = Question(
        id: _questions[questionIndex].id,
        text: _questions[questionIndex].text,
        answers: _questions[questionIndex].answers,
        timeLimit: timeLimit,
        image: _questions[questionIndex].image,
      );
    });
  }

  bool _validateQuizDetails() {
    return _formKey.currentState?.validate() ?? false;
  }

  bool _validateQuestions() {
    if (_questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
             Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 8),
              Text('Please add at least one question'),
            ],
          ),
          backgroundColor: AppTheme.errorColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
      return false;
    }

    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      if (question.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Text('Question ${i + 1} is empty'),
              ],
            ),
            backgroundColor: AppTheme.errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
          ),
        );
        return false;
      }

      for (int j = 0; j < question.answers.length; j++) {
        if (question.answers[j].text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
                  const SizedBox(width: 8),
                  Text('Answer ${j + 1} for Question ${i + 1} is empty'),
                ],
              ),
              backgroundColor: AppTheme.errorColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
            ),
          );
          return false;
        }
      }
    }

    return true;
  }

  void _nextStep() {
    if (_currentStep == 0 && !_validateQuizDetails()) {
      return;
    }

    if (_currentStep == 1 && !_validateQuestions()) {
      return;
    }

    _animationController.reverse().then((_) {
      setState(() {
        _currentStep++;
      });
      _animationController.forward();
    });
  }

  void _previousStep() {
    _animationController.reverse().then((_) {
      setState(() {
        _currentStep--;
      });
      _animationController.forward();
    });
  }

  void _createQuiz() {
    // TODO: Implement quiz creation logic
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress steps
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _buildStepIndicator(0, 'Details'),
                  _buildStepConnector(_currentStep > 0),
                  _buildStepIndicator(1, 'Questions'),
                  _buildStepConnector(_currentStep > 1),
                  _buildStepIndicator(2, 'Preview'),
                ],
              ),
            ),

            // Content
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: [
                    _buildQuizDetailsStep(),
                    _buildQuestionsStep(),
                    _buildPreviewStep(),
                  ][_currentStep],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label) {
    final isActive = _currentStep == step;
    final isCompleted = _currentStep > step;

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isActive || isCompleted
                  ? AppTheme.primaryColor
                  : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : Text(
                      '${step + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppTheme.primaryColor : Colors.grey.shade600,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? AppTheme.primaryColor : Colors.grey.shade300,
    );
  }

  Widget _buildQuizDetailsStep() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          // Quiz cover image
          GestureDetector(
            onTap: () {
              // TODO: Implement image upload
            },
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                // border: DashedBorder(
                //   color: Colors.grey.shade300,
                //   strokeWidth: 2,
                //   dashPattern: [6, 3],
                // ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Add Cover Image',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Recommended size: 800x400',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quiz title
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Quiz Title',
              hintText: 'Enter a catchy title for your quiz',
              prefixIcon: const Icon(Icons.title),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Quiz description
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Describe what your quiz is about',
              prefixIcon: const Icon(Icons.description),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Category dropdown
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Category',
              prefixIcon: const Icon(Icons.category),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            items: [
              'Education',
              'Entertainment',
              'Sports',
              'Science',
              'History',
              'Geography',
              'Art',
              'Music',
              'Movies',
              'Other',
            ].map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              // Handle category selection
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a category';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Difficulty level
          const Text(
            'Difficulty Level',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildDifficultyOption('Easy', Colors.green),
              const SizedBox(width: 12),
              _buildDifficultyOption('Medium', Colors.orange),
              const SizedBox(width: 12),
              _buildDifficultyOption('Hard', Colors.red),
            ],
          ),
          const SizedBox(height: 40),

          // Next button
          GradientButton(
            onPressed: _nextStep,
            text: 'Next: Add Questions',
            gradient: AppTheme.primaryGradient,
            height: 60,
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyOption(String label, Color color) {
    // This is a placeholder for a selectable difficulty option
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        // Questions list
        if (_questions.isEmpty)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://assets5.lottiefiles.com/packages/lf20_ydo1amjm.json',
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'No questions yet',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add your first question to get started',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _questions.length,
            itemBuilder: (context, index) {
              return _buildQuestionCard(index);
            },
          ),

        const SizedBox(height: 24),

        // Add question button
        OutlinedButton.icon(
          onPressed: _addQuestion,
          icon: const Icon(Icons.add),
          label: const Text('Add Question'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),

        const SizedBox(height: 40),

        // Navigation buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GradientButton(
                onPressed: _questions.isNotEmpty ? _nextStep : null,
                text: 'Next: Preview',
                gradient: AppTheme.primaryGradient,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestionCard(int index) {
    final question = _questions[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Question',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeQuestion(index),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: question.text,
              decoration: InputDecoration(
                hintText: 'Enter your question',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              onChanged: (value) => _updateQuestionText(index, value),
            ),
            const SizedBox(height: 20),
            const Text(
              'Answers',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: question.answers.length,
              itemBuilder: (context, answerIndex) {
                final answer = question.answers[answerIndex];
                final isCorrect = answer.isCorrect;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: answerIndex,
                        groupValue:
                            question.answers.indexWhere((a) => a.isCorrect),
                        activeColor: AppTheme.primaryColor,
                        onChanged: (value) {
                          if (value != null) {
                            _setCorrectAnswer(index, value);
                          }
                        },
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: answer.text,
                          decoration: InputDecoration(
                            hintText: 'Answer ${answerIndex + 1}',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: isCorrect
                                ? AppTheme.primaryColor.withOpacity(0.1)
                                : Colors.grey.shade50,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: isCorrect
                                    ? AppTheme.primaryColor
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                          onChanged: (value) =>
                              _updateAnswerText(index, answerIndex, value),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Time limit: '),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButton<int>(
                    value: question.timeLimit,
                    underline: const SizedBox(),
                    items: [10, 20, 30, 45, 60].map((seconds) {
                      return DropdownMenuItem<int>(
                        value: seconds,
                        child: Text('$seconds seconds'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _updateTimeLimit(index, value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        // Quiz preview card
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Quiz cover image placeholder
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 60,
                    color: AppTheme.primaryColor.withOpacity(0.3),
                  ),
                ),
              ),

              // Quiz details
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _titleController.text.isEmpty
                          ? 'Quiz Title'
                          : _titleController.text,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _descriptionController.text.isEmpty
                          ? 'Quiz Description'
                          : _descriptionController.text,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildQuizStat(Icons.help_outline,
                            '${_questions.length} Questions'),
                        const SizedBox(width: 16),
                        _buildQuizStat(
                            Icons.timer, '${_calculateTotalTime()} min'),
                        const SizedBox(width: 16),
                        _buildQuizStat(Icons.bar_chart, 'Medium'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Questions summary
        const Text(
          'Questions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _questions.length,
          itemBuilder: (context, index) {
            final question = _questions[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: AppTheme.primaryColor,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  question.text.isEmpty
                      ? 'Question ${index + 1}'
                      : question.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${question.answers.length} answers • ${question.timeLimit} seconds',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 40),

        // Navigation buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GradientButton(
                onPressed: _createQuiz,
                text: 'Create Quiz',
                gradient: AppTheme.primaryGradient,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuizStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  int _calculateTotalTime() {
    int totalSeconds = 0;
    for (final question in _questions) {
      totalSeconds += question.timeLimit;
    }
    return (totalSeconds / 60).ceil(); // Convert to minutes and round up
  }
}
