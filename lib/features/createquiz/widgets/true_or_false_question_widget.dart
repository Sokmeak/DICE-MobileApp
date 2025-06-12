import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/models/quiz_item.dart';

class TrueOrFalseQuestionWidget extends StatefulWidget {
  final TextEditingController questionController;
  final String? selectedAnswer;
  final Function(String?) onAnswerChanged;
  final int timeLimit;
  final Function(int) onTimeLimitChanged;
  final VoidCallback onAddQuestion;
  final Function(File?) onImageSelected;

  const TrueOrFalseQuestionWidget({
    Key? key,
    required this.questionController,
    this.selectedAnswer,
    required this.onAnswerChanged,
    required this.timeLimit,
    required this.onTimeLimitChanged,
    required this.onAddQuestion,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<TrueOrFalseQuestionWidget> createState() => _TrueOrFalseQuestionWidgetState();
}

class _TrueOrFalseQuestionWidgetState extends State<TrueOrFalseQuestionWidget> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(_selectedImage);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image picker section
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: _selectedImage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 50, color: Colors.grey[600]),
                      Text(
                        'Tap to select an image',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_selectedImage!, fit: BoxFit.cover),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        // Question input
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: 402,
              height: 82,
              child: TextField(
                controller: widget.questionController,
                decoration: InputDecoration(
                  hintText: 'Enter Question',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF8B5CF6), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.grey[50],
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // True/False options
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => widget.onAnswerChanged('False'),
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: widget.selectedAnswer == 'False'
                      ? Colors.green[800]
                      : Colors.red[400],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.selectedAnswer == 'False'
                        ? Colors.green[900]!
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  boxShadow: widget.selectedAnswer == 'False'
                      ? [
                          BoxShadow(
                            color: Colors.green[200]!.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: const Center(
                  child: Text(
                    'False',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => widget.onAnswerChanged('True'),
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: widget.selectedAnswer == 'True'
                      ? Colors.green[800]
                      : Colors.blue[600],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.selectedAnswer == 'True'
                        ? Colors.green[900]!
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  boxShadow: widget.selectedAnswer == 'True'
                      ? [
                          BoxShadow(
                            color: Colors.green[200]!.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: const Center(
                  child: Text(
                    'True',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Time limit setting
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Set Time Limit',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<int>(
                    value: widget.timeLimit,
                    items: [15, 30, 60].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value seconds'),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        widget.onTimeLimitChanged(newValue);
                      }
                    },
                    underline: const SizedBox(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Add question button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: widget.onAddQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Add Question',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}