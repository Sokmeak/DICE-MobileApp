import 'package:flutter/material.dart';
import '../widgets/question_type_dialog.dart';
// import 'package:uuid/uuid.dart'; // For generating unique IDs if needed

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
  final TextEditingController _slideDescriptionController = TextEditingController();
  List<TextEditingController> _optionControllers = List.generate(4, (_) => TextEditingController());
  int? _correctOptionIndex; // Track the correct option index for Quiz
  String? _selectedAnswer; // For True or False
  int _timeLimit = 30; // Default time limit

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
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () => _showMoreOptions(context),
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
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.image, color: Colors.grey[600], size: 30),
                            ),
                            const SizedBox(height: 12),
                            Text('Add a Media', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Quiz Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Quiz Title',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          prefixIcon: Icon(Icons.title, color: Colors.grey[600]),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                          errorText: _titleController.text.isEmpty ? 'Title is required' : null,
                        ),
                        onChanged: (value) => setState(() {}),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Quiz Description',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          prefixIcon: Icon(Icons.description, color: Colors.grey[600]),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.image, color: Colors.grey[600], size: 20),
                        ),
                        title: Text(_selectedTheme, style: TextStyle(color: _selectedTheme == 'Select Theme' ? Colors.grey[600] : Colors.black)),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        onTap: _showThemeSelector,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Quiz Difficulty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildDifficultyButton('Easy', Colors.green)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildDifficultyButton('Medium', Colors.orange)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildDifficultyButton('Hard', Colors.red)),
                      ],
                    ),
                  ],
                  if (_currentStep == 2) ...[
                    const Text('Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(height: 20),
                    if (_selectedQuestionType.isNotEmpty) _buildQuestionInput() else const Text('Please select a question type to begin.'),
                    const SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: _addQuestion,
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: const Color(0xFF8B5CF6),
                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    //     elevation: 0,
                    //   ),
                    //   child: const Text('Add More Question', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                    // ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      children: _questionsList.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final item = entry.value;
                        return Chip(
                          label: Text('$index. ${item.toDisplayString()}'),
                          onDeleted: () => setState(() => _questionsList.removeAt(index - 1)),
                          deleteIcon: const Icon(Icons.close),
                        );
                      }).toList(),
                    ),
                  ],
                  if (_currentStep == 3) ...[
                    const Text('Preview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _questionsList.length,
                      itemBuilder: (context, index) => ListTile(title: Text('${index + 1}. ${_questionsList[index].toDisplayString()}')),
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
                  if (_currentStep == 1 || _currentStep == 2) {
                    if (_titleController.text.isEmpty) {
                      setState(() {});
                      return;
                    }
                    _showQuestionTypeDialog();
                  } else if (_currentStep == 2) {
                    if (_questionsList.isNotEmpty) {
                      setState(() {
                        _currentStep = 3;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text(
                  _currentStep == 1 ||  _currentStep == 2 ? 'Add a question' : 'Next',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if ((step == 1 && _titleController.text.isNotEmpty) || step <= _currentStep) {
          setState(() {
            _currentStep = step;
          });
        }
      },
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _currentStep == step ? const Color(0xFF8B5CF6) : Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: TextStyle(
                  color: _currentStep == step ? const Color(0xFF8B5CF6) : Colors.grey[600],
                  fontSize: 12,
                  fontWeight: _currentStep == step ? FontWeight.w600 : FontWeight.normal)),
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
          border: Border.all(color: isSelected ? color : Colors.grey[300]!, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(difficulty,
              style: TextStyle(
                  color: isSelected ? color : Colors.grey[600],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 16)),
        ),
      ),
    );
  }

  void _showQuestionTypeDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return QuestionTypeDialog(
          quizTitle: _titleController.text,
          onQuestionTypeSelected: _handleQuestionTypeSelection,
        );
      },
    );
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
    });
  }

  Widget _buildQuestionInput() {
    switch (_selectedQuestionType) {
      case 'Quiz':
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: _questionController,
                decoration: const InputDecoration(
                  hintText: 'Enter the Question',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _correctOptionIndex = _correctOptionIndex == 0 ? null : 0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _correctOptionIndex == 0 ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _optionControllers[0],
                        decoration: const InputDecoration(
                          hintText: 'Option 1',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _correctOptionIndex = _correctOptionIndex == 1 ? null : 1),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _correctOptionIndex == 1 ? Colors.green : Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _optionControllers[1],
                        decoration: const InputDecoration(
                          hintText: 'Option 2',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _correctOptionIndex = _correctOptionIndex == 2 ? null : 2),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _correctOptionIndex == 2 ? Colors.green : Colors.yellow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _optionControllers[2],
                        decoration: const InputDecoration(
                          hintText: 'Option 3',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _correctOptionIndex = _correctOptionIndex == 3 ? null : 3),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _correctOptionIndex == 3 ? Colors.green : Colors.green[700],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _optionControllers[3],
                        decoration: const InputDecoration(
                          hintText: 'Option 4',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Set Time limit', style: TextStyle(fontSize: 16)),
                  ),
                  Expanded(
                    child: DropdownButton<int>(
                      value: _timeLimit,
                      items: [15, 30, 60].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value seconds'),
                        );
                      }).toList(),
                      onChanged: (int? newValue) => setState(() => _timeLimit = newValue!),
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 'Slide':
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: _slideTitleController,
                decoration: const InputDecoration(
                  hintText: 'Enter the Slide Title',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: _slideDescriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Slide Description',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Set Time limit', style: TextStyle(fontSize: 16)),
                  ),
                  Expanded(
                    child: DropdownButton<int>(
                      value: _timeLimit,
                      items: [15, 30, 60].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value seconds'),
                        );
                      }).toList(),
                      onChanged: (int? newValue) => setState(() => _timeLimit = newValue!),
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 'True or False':
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: _questionController,
                decoration: const InputDecoration(
                  hintText: 'Enter the Question',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedAnswer = 'False'),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _selectedAnswer == 'False' ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text('False', style: TextStyle(color: Colors.white, fontSize: 16))),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedAnswer = 'True'),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _selectedAnswer == 'True' ? Colors.green : Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text('True', style: TextStyle(color: Colors.white, fontSize: 16))),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Set Time limit', style: TextStyle(fontSize: 16)),
                  ),
                  Expanded(
                    child: DropdownButton<int>(
                      value: _timeLimit,
                      items: [15, 30, 60].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value seconds'),
                        );
                      }).toList(),
                      onChanged: (int? newValue) => setState(() => _timeLimit = newValue!),
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _addQuestion() {
    if (_selectedQuestionType == 'Quiz' &&
        _questionController.text.isNotEmpty &&
        _optionControllers.any((controller) => controller.text.isNotEmpty)) {
      _questionsList.add(QuizItem(
        type: _selectedQuestionType,
        question: _questionController.text,
        options: _optionControllers.map((controller) => controller.text).where((text) => text.isNotEmpty).toList(),
        timeLimit: _timeLimit,
        correctOptionIndex: _correctOptionIndex,
      ));
    } else if (_selectedQuestionType == 'Slide' && _slideTitleController.text.isNotEmpty) {
      _questionsList.add(QuizItem(
        type: _selectedQuestionType,
        title: _slideTitleController.text,
        description: _slideDescriptionController.text,
        timeLimit: _timeLimit,
      ));
    } else if (_selectedQuestionType == 'True or False' &&
        _questionController.text.isNotEmpty &&
        _selectedAnswer != null) {
      _questionsList.add(QuizItem(
        type: _selectedQuestionType,
        question: _questionController.text,
        selectedAnswer: _selectedAnswer,
        timeLimit: _timeLimit,
      ));
    }
    setState(() {
      _questionController.clear();
      _slideTitleController.clear();
      _slideDescriptionController.clear();
      _optionControllers = List.generate(4, (_) => TextEditingController());
      _correctOptionIndex = null;
      _selectedAnswer = null;
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
              const Text('Select Theme', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
              ListTile(title: const Text('Save Draft'), onTap: () => Navigator.pop(context)),
              ListTile(title: const Text('Settings'), onTap: () => Navigator.pop(context)),
            ],
          ),
        );
      },
    );
  }

  void _pickCoverImage() {
    print('Opening image picker...');
  }
}

// QuizItem model (assumed to be in quiz_item.dart)
class QuizItem {
  final String type;
  String? question;
  String? title;
  String? description;
  List<String>? options;
  String? selectedAnswer;
  int? timeLimit;
  int? correctOptionIndex;

  QuizItem({
    required this.type,
    this.question,
    this.title,
    this.description,
    this.options,
    this.selectedAnswer,
    this.timeLimit,
    this.correctOptionIndex,
  });

  String toDisplayString() {
    switch (type) {
      case 'Quiz':
        return '$question (Options: ${options?.join(', ') ?? 'None'}, Correct: ${options?[correctOptionIndex ?? -1] ?? 'None'})';
      case 'Slide':
        return '$title - $description';
      case 'True or False':
        return '$question ($selectedAnswer)';
      default:
        return 'Unknown Question Type';
    }
  }
}