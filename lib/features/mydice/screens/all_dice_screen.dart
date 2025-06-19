import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/features/mydice/widgets/dice_quiz_card.dart';
import 'package:product_dice/features/mydice/screens/view_specific_dice.dart';

class AllDiceScreen extends StatefulWidget {
  const AllDiceScreen({super.key});

  @override
  State<AllDiceScreen> createState() => _AllDiceScreenState();
}

class _AllDiceScreenState extends State<AllDiceScreen> {
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
          'All DICEs',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Add search functionality
            },
            icon: const Icon(Icons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              // Add filter/sort functionality
            },
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header section with count or filters (optional)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.02,
              ),
              child: Text(
                '${myDiceData.length} quizzes available',
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: Colors.grey[600],
                  fontFamily: 'Poppins',
                ),
              ),
            ),

            // Scrollable quiz list
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  bottom: height * 0.02,
                ),
                itemCount: myDiceData.length,
                itemBuilder: (context, index) {
                  final quiz = myDiceData[index];
                  return DiceQuizCard(
                    data: quiz,
                    onTap: () {
                      // Navigate to quiz details or start quiz
                      _onQuizTap(quiz);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating action button for creating new quiz
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create quiz screen
          // _onCreateQuiz();
          Navigator.pushNamed(context, '/create-quiz');
        },
        backgroundColor: AppColors.purple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _onQuizTap(MyDiceData quiz) {
    // Navigate to the specific quiz view screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewSpecificDiceScreen(quizData: quiz),
      ),
    );
  }
}
