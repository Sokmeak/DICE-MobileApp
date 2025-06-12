import 'package:flutter/material.dart';

class QuestionTypeDialog extends StatelessWidget {
  final String quizTitle;
  final Function(String) onQuestionTypeSelected;

  const QuestionTypeDialog({
    Key? key,
    required this.quizTitle,
    required this.onQuestionTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E5E5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Select Question Type',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE53E3E),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildQuestionTypeCard(
                    'Quiz',
                    _buildQuizIcon(),
                    () {
                      Navigator.pop(context);
                      onQuestionTypeSelected('Quiz');
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuestionTypeCard(
                    'True or False',
                    _buildTrueFalseIcon(),
                    () {
                      Navigator.pop(context);
                      onQuestionTypeSelected('True or False');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Slide Presentation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildQuestionTypeCard(
              'Slide',
              _buildSlideIcon(),
              () {
                Navigator.pop(context);
                onQuestionTypeSelected('Slide');
              },
              fullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionTypeCard(String title, Widget icon, VoidCallback onTap,
      {bool fullWidth = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizIcon() {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE53E3E),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(4)),
                  ),
                  child: const Center(
                    child: Icon(Icons.help, color: Colors.white, size: 10),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: Container(
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3182CE),
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(4)),
                  ),
                  child: const Center(
                    child: Icon(Icons.help, color: Colors.white, size: 10),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF59E0B),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(4)),
                    ),
                    child: const Center(
                      child: Icon(Icons.help, color: Colors.white, size: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: Container(
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(4)),
                    ),
                    child: const Center(
                      child: Icon(Icons.help, color: Colors.white, size: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrueFalseIcon() {
    return SizedBox(
      width: 40,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFE53E3E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Container(
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF3182CE),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideIcon() {
    return SizedBox(
      width: 40,
      height: 40,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF3182CE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFE53E3E),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF3182CE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
