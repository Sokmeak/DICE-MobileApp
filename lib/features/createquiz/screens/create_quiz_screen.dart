import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/question_type_dialog.dart';
import '../widgets/true_or_false_question_widget.dart';
import '../widgets/slide_question_widget.dart';
import '../widgets/quiz_question_widget.dart';
import '../../../core/models/quiz_item.dart';
import 'package:image_picker/image_picker.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedDifficulty = 'Easy';
  String _selectedTheme = 'Select Theme';
  int _currentStep = 1;
  String _selectedQuestionType = '';
  final List<QuizItem> _questionsList = [];
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _slideTitleController = TextEditingController();
  final TextEditingController _slideDescriptionController =
      TextEditingController();
  List<TextEditingController> _optionControllers =
      List.generate(4, (_) => TextEditingController());
  int? _correctOptionIndex;
  String? _selectedAnswer;
  int _timeLimit = 30;
  File? _coverImage;
  File? _currentQuestionImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _questionController.dispose();
    _slideTitleController.dispose();
    _slideDescriptionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showQuestionTypeDialog() {
    if (_titleController.text.isNotEmpty) {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return QuestionTypeDialog(
            quizTitle: _titleController.text,
            onQuestionTypeSelected: _handleQuestionTypeSelection,
          );
        },
      );
    }
  }

  void _handleQuestionTypeSelection(String type) {
    setState(() {
      _selectedQuestionType = type;
      _currentStep = 2;
      _questionController.clear();
      _slideTitleController.clear();
      _slideDescriptionController.clear();
      _optionControllers = List.generate(4, (_) => TextEditingController());
      _correctOptionIndex = null;
      _selectedAnswer = null;
      _timeLimit = 30;
      _currentQuestionImage = null;
    });
  }

  void _showThemeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select Theme',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              ...[
                'Science',
                'History',
                'Geography',
                'Literature',
                'Sports',
                'Entertainment'
              ]
                  .map((theme) => ListTile(
                        title: Text(theme),
                        onTap: () {
                          setState(() => _selectedTheme = theme);
                          Navigator.pop(context);
                        },
                      ))
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: const Text('Save Draft'),
                  onTap: () => Navigator.pop(context)),
              ListTile(
                  title: const Text('Settings'),
                  onTap: () => Navigator.pop(context)),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickCoverImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _coverImage = File(pickedFile.path);
      });
    }
  }

  Widget _buildProgressStep(int step, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if ((step == 1 && _titleController.text.isNotEmpty) ||
            step <= _currentStep) {
          setState(() => _currentStep = step);
        }
      },
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _currentStep == step
                  ? const Color(0xFF8B5CF6)
                  : Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: _currentStep == step
                  ? const Color(0xFF8B5CF6)
                  : Colors.grey[600],
              fontSize: 12,
              fontWeight:
                  _currentStep == step ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 24, left: 8, right: 8),
        color: isActive ? const Color(0xFF8B5CF6) : Colors.grey[300],
      ),
    );
  }

  Widget _buildDifficultyButton(String difficulty, Color color) {
    bool isSelected = _selectedDifficulty == difficulty;
    return GestureDetector(
      onTap: () => setState(() => _selectedDifficulty = difficulty),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[50],
          border: Border.all(
              color: isSelected ? color : Colors.grey[300]!, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            difficulty,
            style: TextStyle(
              color: isSelected ? color : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create Quiz',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _showMoreOptions(context),
            child:
                const Text('SAVE', style: TextStyle(color: Color(0xFF8B5CF6))),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _buildProgressStep(1, 'Details', _currentStep >= 1),
                _buildProgressLine(_currentStep > 1),
                _buildProgressStep(2, 'Questions', _currentStep >= 2),
                _buildProgressLine(_currentStep > 2),
                _buildProgressStep(3, 'Preview', _currentStep >= 3),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_currentStep == 1) ...[
                    GestureDetector(
                      onTap: _pickCoverImage,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.grey[300]!, width: 1),
                        ),
                        child: _coverImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image,
                                      size: 50, color: Colors.grey[600]),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Add a Media',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 16),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child:
                                    Image.file(_coverImage!, fit: BoxFit.cover),
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Quiz Info',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Quiz Title',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          prefixIcon:
                              const Icon(Icons.title, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.grey[300]!, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Color(0xFF8B5CF6), width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.grey[300]!, width: 1),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          errorText: _titleController.text.isEmpty
                              ? 'Title is required'
                              : null,
                        ),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                        onChanged: (value) => setState(() {}),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Quiz Description',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          prefixIcon:
                              const Icon(Icons.description, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.grey[300]!, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Color(0xFF8B5CF6), width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.grey[300]!, width: 1),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.image,
                              color: Colors.grey, size: 20),
                        ),
                        title: Text(_selectedTheme,
                            style: TextStyle(
                                color: _selectedTheme == 'Select Theme'
                                    ? Colors.grey[600]
                                    : Colors.black,
                                fontSize: 16)),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        onTap: _showThemeSelector,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Quiz Difficulty',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child:
                                _buildDifficultyButton('Easy', Colors.green)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildDifficultyButton(
                                'Medium', Colors.orange)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildDifficultyButton('Hard', Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text('Questions (${_questionsList.length})',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      children: _questionsList.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final item = entry.value;
                        return Chip(
                          label: Text('$index. ${item.toDisplayString()}'),
                          onDeleted: () => setState(
                              () => _questionsList.removeAt(index - 1)),
                          deleteIcon: const Icon(Icons.close),
                        );
                      }).toList(),
                    ),
                  ],
                  if (_currentStep == 2) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Questions (${_questionsList.length})',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        TextButton(
                          onPressed: _showQuestionTypeDialog,
                          child: const Text('Add a question',
                              style: TextStyle(color: Color(0xFF8B5CF6))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_selectedQuestionType == 'True or False')
                      TrueOrFalseQuestionWidget(
                        questionController: _questionController,
                        selectedAnswer: _selectedAnswer,
                        timeLimit: _timeLimit,
                        onTimeLimitChanged: (limit) =>
                            setState(() => _timeLimit = limit),
                        onAnswerChanged: (answer) =>
                            setState(() => _selectedAnswer = answer),
                        onAddQuestion: () {
                          if (_questionController.text.isNotEmpty &&
                              _selectedAnswer != null) {
                            _questionsList.add(QuizItem(
                              type: 'True or False',
                              question: _questionController.text,
                              selectedAnswer: _selectedAnswer,
                              timeLimit: _timeLimit,
                              image: _currentQuestionImage,
                            ));
                            setState(() {
                              _questionController.clear();
                              _selectedAnswer = null;
                              _currentQuestionImage = null;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Please enter a question and select an answer')),
                            );
                          }
                        },
                        onImageSelected: (image) {
                          setState(() => _currentQuestionImage = image);
                        },
                      )
                    else if (_selectedQuestionType == 'Slide')
                      SlideQuestionWidget(
                        titleController: _slideTitleController,
                        descriptionController: _slideDescriptionController,
                        timeLimit: _timeLimit,
                        onTimeLimitChanged: (limit) =>
                            setState(() => _timeLimit = limit),
                        onAddQuestion: () {
                          if (_slideTitleController.text.isNotEmpty) {
                            _questionsList.add(QuizItem(
                              type: 'Slide',
                              title: _slideTitleController.text,
                              description: _slideDescriptionController.text,
                              timeLimit: _timeLimit,
                              image: _currentQuestionImage,
                            ));
                            setState(() {
                              _slideTitleController.clear();
                              _slideDescriptionController.clear();
                              _currentQuestionImage = null;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Please enter a slide title')),
                            );
                          }
                        },
                        onImageSelected: (image) {
                          setState(() => _currentQuestionImage = image);
                        },
                      )
                    else if (_selectedQuestionType == 'Quiz')
                      QuizQuestionWidget(
                        questionController: _questionController,
                        optionControllers: _optionControllers,
                        correctOptionIndex: _correctOptionIndex,
                        onCorrectOptionChanged: (index) =>
                            setState(() => _correctOptionIndex = index),
                        timeLimit: _timeLimit,
                        onTimeLimitChanged: (limit) =>
                            setState(() => _timeLimit = limit),
                        onAddQuestion: () {
                          if (_questionController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Please enter a question')),
                            );
                            return;
                          }
                          final nonEmptyOptions = _optionControllers
                              .where((c) => c.text.isNotEmpty)
                              .length;
                          if (nonEmptyOptions < 2) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Please enter at least two options')),
                            );
                            return;
                          }
                          if (_correctOptionIndex == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Please select a correct option')),
                            );
                            return;
                          }
                          final options = _optionControllers
                              .map((c) => c.text)
                              .where((text) => text.isNotEmpty)
                              .toList();
                          _questionsList.add(QuizItem(
                            type: 'Quiz',
                            question: _questionController.text,
                            options: options,
                            timeLimit: _timeLimit,
                            correctOptionIndex: _correctOptionIndex,
                            image: _currentQuestionImage,
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Question added successfully')),
                          );
                          setState(() {
                            _questionController.clear();
                            for (var c in _optionControllers) c.clear();
                            _correctOptionIndex = null;
                            _currentQuestionImage = null;
                          });
                        },
                        onImageSelected: (image) {
                          setState(() => _currentQuestionImage = image);
                        },
                      )
                    else
                      const Text('Please select a question type to begin.'),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      children: _questionsList.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return Chip(
                          label:
                              Text('${index + 1}. ${item.toDisplayString()}'),
                          onDeleted: () =>
                              setState(() => _questionsList.removeAt(index)),
                          deleteIcon: const Icon(Icons.close),
                        );
                      }).toList(),
                    ),
                  ],
                  if (_currentStep == 3) ...[
                    const Text(
                      'Preview',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 2,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_coverImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _coverImage!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 16),
                            Text(
                              _titleController.text.isNotEmpty
                                  ? _titleController.text
                                  : 'Untitled Quiz',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _descriptionController.text.isNotEmpty
                                  ? _descriptionController.text
                                  : 'No description provided',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Chip(
                                  label: Text(_selectedTheme),
                                  backgroundColor: Colors.grey[100],
                                ),
                                const SizedBox(width: 8),
                                Chip(
                                  label: Text(_selectedDifficulty),
                                  backgroundColor: Colors.grey[100],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Questions',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _questionsList.length,
                              itemBuilder: (context, index) {
                                final item = _questionsList[index];
                                final hasError = index ==
                                    1; // Example: 2nd question has an error
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: hasError
                                          ? Colors.red
                                          : Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(12),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Row(
                                      children: [
                                        if (item.image != null)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              item.image!,
                                              height: 40,
                                              width: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        else
                                          Icon(Icons.image,
                                              color: Colors.grey[400]),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            item.toDisplayString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: hasError
                                        ? const Icon(Icons.error,
                                            color: Colors.red, size: 20)
                                        : null,
                                    subtitle: Text(
                                      'Time: ${item.timeLimit ?? 30} sec',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentStep == 1) {
                    if (_titleController.text.isEmpty) {
                      setState(() {});
                      return;
                    }
                    _showQuestionTypeDialog();
                  } else if (_currentStep == 2) {
                    if (_questionsList.isNotEmpty) {
                      setState(() => _currentStep = 3);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please add at least one question')),
                      );
                    }
                  } else if (_currentStep == 3) {
                    // Add save logic here if needed
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: Text(
                  _currentStep == 1
                      ? 'Add a question'
                      : _currentStep == 2
                          ? 'Next'
                          : 'Finish',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
