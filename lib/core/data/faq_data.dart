class FaqData {
  final String question;
  final String answer;

  FaqData({required this.question, required this.answer});
}

List<FaqData> faqData = [
  FaqData(
    question: 'Q1: What is dice mobile?',
    answer:
        'DICE is a mobile quiz app that allows users to play, create, and share interactive quizzes across various topics and difficulty levels. It combines learning and entertainment in an engaging, competitive format.',
  ),
  FaqData(
    question: 'Q2: How do I create an account?',
    answer:
        'You can create an account by: \n - Downloading the app from App Store or Google Play \n - Signing up using your email address \n - Alternatively, use Google, Facebook, or Apple ID login \n -Choose a unique username and set up your profile',
  ),
  FaqData(
    question: 'Q3: Is DICE free to use?',
    answer:
        'DICE offers both free and premium features: \n - Basic account is completely free \n - Free users can play most quizzes and create unlimited quizzes \n - Premium subscription available with additional features like advanced analytics and ad-free experience',
  ),
];
