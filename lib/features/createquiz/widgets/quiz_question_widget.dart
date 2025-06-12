import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/models/quiz_item.dart';

class QuizQuestionWidget extends StatefulWidget {
  final TextEditingController questionController;
  final List<TextEditingController> optionControllers;
  final int? correctOptionIndex;
  final Function(int?) onCorrectOptionChanged;
  final int timeLimit;
  final Function(int) onTimeLimitChanged;
  final VoidCallback onAddQuestion;
  final Function(File?) onImageSelected;

  const QuizQuestionWidget({
    Key? key,
    required this.questionController,
    required this.optionControllers,
    this.correctOptionIndex,
    required this.onCorrectOptionChanged,
    required this.timeLimit,
    required this.onTimeLimitChanged,
    required this.onAddQuestion,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<QuizQuestionWidget> createState() => _QuizQuestionWidgetState();
}

class _QuizQuestionWidgetState extends State<QuizQuestionWidget> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.optionControllers.length < 4) {
      widget.optionControllers.addAll(List.generate(
          4 - widget.optionControllers.length, (_) => TextEditingController()));
    }
  }

  @override
  void dispose() {
    for (var controller in widget.optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    // Define background colors for each option when not selected
    final List<Color> optionColors = [
      Colors.red[400]!, // Option 1
      Colors.blue[600]!, // Option 2
      Colors.yellow[700]!, // Option 3
      Colors.green[500]!, // Option 4
    ];

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
        // Option 1 and 2
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: optionColors[0],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.correctOptionIndex == 0
                        ? Colors.green[800]!
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  boxShadow: widget.correctOptionIndex == 0
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
                child: Row(
                  children: [
                    Radio<int>(
                      value: 0,
                      groupValue: widget.correctOptionIndex,
                      onChanged: widget.onCorrectOptionChanged,
                      activeColor: Colors.white,
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.optionControllers[0],
                        decoration: InputDecoration(
                          hintText: 'Option 1',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        style: TextStyle(
                          color: widget.correctOptionIndex == 0
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: optionColors[1],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.correctOptionIndex == 1
                        ? Colors.green[800]!
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  boxShadow: widget.correctOptionIndex == 1
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
                child: Row(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: widget.correctOptionIndex,
                      onChanged: widget.onCorrectOptionChanged,
                      activeColor: Colors.white,
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.optionControllers[1],
                        decoration: InputDecoration(
                          hintText: 'Option 2',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        style: TextStyle(
                          color: widget.correctOptionIndex == 1
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Option 3 and 4
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color:  optionColors[2],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.correctOptionIndex == 2
                        ? Colors.green[800]!
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  boxShadow: widget.correctOptionIndex == 2
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
                child: Row(
                  children: [
                    Radio<int>(
                      value: 2,
                      groupValue: widget.correctOptionIndex,
                      onChanged: widget.onCorrectOptionChanged,
                      activeColor: Colors.white,
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.optionControllers[2],
                        decoration: InputDecoration(
                          hintText: 'Option 3',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        style: TextStyle(
                          color: widget.correctOptionIndex == 2
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color:  optionColors[3],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.correctOptionIndex == 3
                        ? Colors.green[800]!
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  boxShadow: widget.correctOptionIndex == 3
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
                child: Row(
                  children: [
                    Radio<int>(
                      value: 3,
                      groupValue: widget.correctOptionIndex,
                      onChanged: widget.onCorrectOptionChanged,
                      activeColor: Colors.white,
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.optionControllers[3],
                        decoration: InputDecoration(
                          hintText: 'Option 4',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        style: TextStyle(
                          color: widget.correctOptionIndex == 3
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
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
