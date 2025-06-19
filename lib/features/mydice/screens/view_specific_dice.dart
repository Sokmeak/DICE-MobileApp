import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/core/models/quiz_item.dart';

class ViewSpecificDiceScreen extends StatefulWidget {
  final MyDiceData quizData;

  const ViewSpecificDiceScreen({
    super.key,
    required this.quizData,
  });

  @override
  State<ViewSpecificDiceScreen> createState() => _ViewSpecificDiceScreenState();
}

class _ViewSpecificDiceScreenState extends State<ViewSpecificDiceScreen> {
  List<QuizItem> get questions => widget.quizData.questions ?? [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'View Quiz',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: width * 0.04),
            child: ElevatedButton(
              onPressed: () {
                _onHostQuiz();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.01,
                ),
              ),
              child: const Text(
                'Host',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header with quiz image and brain illustration
              Container(
                width: double.infinity,
                height: height * 0.25,
                margin: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: widget.quizData.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Quiz Info Section
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Quiz Info',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.edit,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),

                    // Quiz Title
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.quizData.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.015),

                    // Quiz Description
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.quizData.description,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.015),

                    // Theme Selection
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                          const Text(
                            'Select Theme',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.015),

                    // Quiz Difficulty
                    Row(
                      children: [
                        const Text(
                          'Quiz Difficulty',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(width: width * 0.04),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04,
                            vertical: height * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Easy',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              // Questions Section
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Questions (${questions.length})',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    // Questions List
                    questions.isEmpty
                        ? Container(
                            padding: EdgeInsets.all(width * 0.04),
                            child: Text(
                              'No questions available for this quiz yet.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: questions.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: height * 0.01),
                            itemBuilder: (context, index) {
                              final question = questions[index];
                              return _buildQuestionCard(
                                  question, index + 1, width, height);
                            },
                          ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
      QuizItem question, int questionNumber, double width, double height) {
    IconData questionIcon;
    Color iconColor;
    String questionText;

    switch (question.type) {
      case 'Quiz':
        questionIcon = Icons.quiz;
        iconColor = Colors.blue;
        questionText = question.question ?? 'Multiple Choice Question';
        break;
      case 'True or False':
        questionIcon = Icons.check_circle;
        iconColor = Colors.green;
        questionText = question.question ?? 'True or False Question';
        break;
      case 'Slide':
        questionIcon = Icons.slideshow;
        iconColor = Colors.orange;
        questionText = question.title ?? 'Information Slide';
        break;
      default:
        questionIcon = Icons.help;
        iconColor = Colors.grey;
        questionText = 'Unknown Question Type';
    }

    return Container(
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Question icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              questionIcon,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: width * 0.03),

          // Question content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$questionNumber. Question',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: height * 0.005),
                Text(
                  questionText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (question.type == 'Quiz' && question.options != null) ...[
                  SizedBox(height: height * 0.005),
                  Text(
                    '${question.options!.length} options',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[500],
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
                if (question.timeLimit != null) ...[
                  SizedBox(height: height * 0.005),
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: width * 0.01),
                      Text(
                        '${question.timeLimit}s',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[500],
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Edit icon
          IconButton(
            onPressed: () {
              _onEditQuestion(question, questionNumber - 1);
            },
            icon: Icon(
              Icons.edit,
              color: Colors.grey[400],
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  void _onHostQuiz() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Hosting quiz: ${widget.quizData.title}'),
        backgroundColor: AppColors.purple,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onEditQuestion(QuizItem question, int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing question ${index + 1}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
