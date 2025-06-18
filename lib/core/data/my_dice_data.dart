import 'package:flutter/material.dart';
import 'package:product_dice/core/config/banner_images.dart';
import 'package:product_dice/core/models/quiz_item.dart';

class MyDiceData {
  String title;
  ImageProvider image;
  String description;
  String status;
  double totalQuestion;
  bool isCompleted;
  List<QuizItem>? questions;

  MyDiceData({
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.totalQuestion,
    required this.isCompleted,
    this.questions,
  });
}

List<MyDiceData> myDiceData = [
  MyDiceData(
    title: 'Create Engaging Quizzes',
    image: const AssetImage(AppBanner.banner1),
    description:
        'Design beautiful quizzes with multiple-choice questions, images, and time limits.',
    status: 'Completed',
    totalQuestion: 10,
    isCompleted: true,
    questions: [
      QuizItem(
        type: 'Quiz',
        question: 'What is the best way to start creating an engaging quiz?',
        options: [
          'Start with a catchy title',
          'Begin with easy questions',
          'Add colorful images first',
          'Set a theme and objective'
        ],
        correctOptionIndex: 3,
        timeLimit: 60,
      ),
      QuizItem(
        type: 'True or False',
        question:
            'Multiple-choice questions are the only way to create engaging quizzes.',
        selectedAnswer: 'False',
        timeLimit: 30,
      ),
      QuizItem(
        type: 'Slide',
        title: 'Quiz Design Principles',
        description:
            'When creating quizzes, remember to keep questions clear, provide balanced difficulty, and include engaging visuals to maintain participant interest.',
        timeLimit: 45,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which element is most important for quiz engagement?',
        options: [
          'Background music',
          'Time pressure',
          'Clear and relevant questions',
          'Colorful animations'
        ],
        correctOptionIndex: 2,
        timeLimit: 45,
      ),
      QuizItem(
        type: 'True or False',
        question:
            'Adding images to quiz questions can improve participant engagement.',
        selectedAnswer: 'True',
        timeLimit: 25,
      ),
      QuizItem(
        type: 'Quiz',
        question:
            'What is the recommended time limit for a multiple-choice question?',
        options: [
          '10-15 seconds',
          '30-60 seconds',
          '2-3 minutes',
          'No time limit'
        ],
        correctOptionIndex: 1,
        timeLimit: 50,
      ),
      QuizItem(
        type: 'Slide',
        title: 'Question Types Overview',
        description:
            'There are various question types you can use: Multiple choice, True/False, Fill in the blank, and Information slides. Each serves different purposes in your quiz.',
        timeLimit: 40,
      ),
      QuizItem(
        type: 'Quiz',
        question:
            'How many options should a multiple-choice question typically have?',
        options: [
          '2 options',
          '3-4 options',
          '5-6 options',
          'As many as possible'
        ],
        correctOptionIndex: 1,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'True or False',
        question:
            'Quiz questions should always be arranged from easiest to hardest.',
        selectedAnswer: 'False',
        timeLimit: 35,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What makes a quiz question "engaging"?',
        options: [
          'It\'s very difficult',
          'It relates to real-world scenarios',
          'It has many options',
          'It uses complex vocabulary'
        ],
        correctOptionIndex: 1,
        timeLimit: 55,
      ),
    ],
  ),
  MyDiceData(
    title: 'Host Live Games',
    image: const AssetImage(AppBanner.banner1),
    description:
        'Invite players to join with a game code and compete in real-time.',
    status: 'Draft',
    totalQuestion: 5,
    isCompleted: false,
    questions: [
      QuizItem(
        type: 'Quiz',
        question: 'What do players need to join a live quiz game?',
        options: [
          'Email address',
          'Game code',
          'Phone number',
          'Social media account'
        ],
        correctOptionIndex: 1,
        timeLimit: 45,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Players can join a live game after it has already started.',
        selectedAnswer: 'False',
        timeLimit: 30,
      ),
      QuizItem(
        type: 'Slide',
        title: 'Live Game Features',
        description:
            'Live games allow real-time participation, instant feedback, leaderboards, and interactive elements that make learning fun and competitive.',
        timeLimit: 40,
      ),
      QuizItem(
        type: 'Quiz',
        question:
            'What happens when a player answers incorrectly in a live game?',
        options: [
          'They are eliminated',
          'They lose points',
          'They get a second chance',
          'Nothing happens'
        ],
        correctOptionIndex: 1,
        timeLimit: 50,
      ),
      QuizItem(
        type: 'True or False',
        question: 'The host can see all player responses in real-time.',
        selectedAnswer: 'True',
        timeLimit: 25,
      ),
    ],
  ),
  MyDiceData(
    title: 'Track Performance',
    image: const AssetImage(AppBanner.banner1),
    description: 'View detailed analytics and insights about quiz performance.',
    status: 'Completed',
    totalQuestion: 3,
    isCompleted: true,
    questions: [
      QuizItem(
        type: 'Quiz',
        question: 'Which metric is most important for measuring quiz success?',
        options: [
          'Number of participants',
          'Average completion time',
          'Learning outcomes achieved',
          'Number of questions'
        ],
        correctOptionIndex: 2,
        timeLimit: 60,
      ),
      QuizItem(
        type: 'Slide',
        title: 'Analytics Dashboard',
        description:
            'Track participant progress, identify difficult questions, monitor engagement levels, and generate detailed reports for better insights.',
        timeLimit: 45,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Performance analytics can help improve future quiz designs.',
        selectedAnswer: 'True',
        timeLimit: 30,
      ),
    ],
  ),
  MyDiceData(
    title: 'Science Basics',
    image: const AssetImage('assets/images/banner2.jpg'),
    description: 'Basic science concepts and principles.',
    status: 'Completed',
    totalQuestion: 15,
    isCompleted: true,
    questions: [
      QuizItem(
        type: 'Quiz',
        question: 'What is the chemical symbol for water?',
        options: ['H2O', 'CO2', 'NaCl', 'O2'],
        correctOptionIndex: 0,
        timeLimit: 30,
      ),
      QuizItem(
        type: 'True or False',
        question: 'The Earth revolves around the Sun.',
        selectedAnswer: 'True',
        timeLimit: 20,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which planet is closest to the Sun?',
        options: ['Venus', 'Mercury', 'Earth', 'Mars'],
        correctOptionIndex: 1,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'Slide',
        title: 'States of Matter',
        description:
            'Matter exists in three main states: solid, liquid, and gas. Each state has unique properties based on molecular movement and energy.',
        timeLimit: 50,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What gas do plants absorb during photosynthesis?',
        options: ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
        correctOptionIndex: 2,
        timeLimit: 35,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Sound travels faster than light.',
        selectedAnswer: 'False',
        timeLimit: 25,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is the hardest natural substance on Earth?',
        options: ['Gold', 'Iron', 'Diamond', 'Quartz'],
        correctOptionIndex: 2,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'How many bones are in an adult human body?',
        options: ['186', '206', '226', '246'],
        correctOptionIndex: 1,
        timeLimit: 45,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Lightning is hotter than the surface of the Sun.',
        selectedAnswer: 'True',
        timeLimit: 30,
      ),
      QuizItem(
        type: 'Slide',
        title: 'The Scientific Method',
        description:
            'The scientific method involves observation, hypothesis formation, experimentation, analysis, and conclusion. It\'s the foundation of scientific discovery.',
        timeLimit: 60,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is the fastest land animal?',
        options: ['Lion', 'Cheetah', 'Leopard', 'Tiger'],
        correctOptionIndex: 1,
        timeLimit: 30,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Humans only use 10% of their brain.',
        selectedAnswer: 'False',
        timeLimit: 35,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What type of animal is a whale?',
        options: ['Fish', 'Reptile', 'Mammal', 'Amphibian'],
        correctOptionIndex: 2,
        timeLimit: 35,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which blood type is known as the universal donor?',
        options: ['A', 'B', 'AB', 'O'],
        correctOptionIndex: 3,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Antibiotics are effective against viral infections.',
        selectedAnswer: 'False',
        timeLimit: 40,
      ),
    ],
  ),
  MyDiceData(
    title: 'History Quiz',
    image: const AssetImage('assets/images/banner3.jpg'),
    description: 'Test your knowledge of world history.',
    status: 'Draft',
    totalQuestion: 8,
    isCompleted: false,
    questions: [
      QuizItem(
        type: 'Quiz',
        question: 'In which year did World War II end?',
        options: ['1944', '1945', '1946', '1947'],
        correctOptionIndex: 1,
        timeLimit: 45,
      ),
      QuizItem(
        type: 'True or False',
        question: 'The Great Wall of China was built in a single dynasty.',
        selectedAnswer: 'False',
        timeLimit: 30,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Who was the first person to walk on the moon?',
        options: [
          'Buzz Aldrin',
          'Neil Armstrong',
          'John Glenn',
          'Alan Shepard'
        ],
        correctOptionIndex: 1,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'Slide',
        title: 'Ancient Civilizations',
        description:
            'Ancient civilizations like Egypt, Mesopotamia, and the Indus Valley laid the foundations for modern society through innovations in writing, agriculture, and governance.',
        timeLimit: 50,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which empire was ruled by Julius Caesar?',
        options: [
          'Greek Empire',
          'Roman Empire',
          'Byzantine Empire',
          'Persian Empire'
        ],
        correctOptionIndex: 1,
        timeLimit: 35,
      ),
      QuizItem(
        type: 'True or False',
        question: 'The Berlin Wall fell in 1989.',
        selectedAnswer: 'True',
        timeLimit: 25,
      ),
      QuizItem(
        type: 'Quiz',
        question:
            'Which country gifted the Statue of Liberty to the United States?',
        options: ['Britain', 'Spain', 'France', 'Italy'],
        correctOptionIndex: 2,
        timeLimit: 35,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Napoleon Bonaparte was born in France.',
        selectedAnswer: 'False',
        timeLimit: 30,
      ),
    ],
  ),
  MyDiceData(
    title: 'Math Challenge',
    image: const AssetImage('assets/images/banner4.jpg'),
    description: 'Mathematical problems and solutions.',
    status: 'Completed',
    totalQuestion: 12,
    isCompleted: true,
    questions: [
      QuizItem(
        type: 'Quiz',
        question: 'What is 15 × 8?',
        options: ['110', '120', '130', '140'],
        correctOptionIndex: 1,
        timeLimit: 30,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Zero is a positive number.',
        selectedAnswer: 'False',
        timeLimit: 20,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is the square root of 144?',
        options: ['10', '12', '14', '16'],
        correctOptionIndex: 1,
        timeLimit: 35,
      ),
      QuizItem(
        type: 'Slide',
        title: 'Basic Algebra',
        description:
            'Algebra uses letters and symbols to represent numbers and quantities in formulas and equations. It\'s the foundation for advanced mathematics.',
        timeLimit: 45,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'If x + 5 = 12, what is x?',
        options: ['5', '6', '7', '8'],
        correctOptionIndex: 2,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'True or False',
        question: 'A triangle has 180 degrees.',
        selectedAnswer: 'True',
        timeLimit: 25,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is 25% of 200?',
        options: ['25', '50', '75', '100'],
        correctOptionIndex: 1,
        timeLimit: 35,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is the value of π (pi) approximately?',
        options: ['2.14', '3.14', '4.14', '5.14'],
        correctOptionIndex: 1,
        timeLimit: 30,
      ),
      QuizItem(
        type: 'True or False',
        question: 'A prime number has exactly two factors.',
        selectedAnswer: 'True',
        timeLimit: 30,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is 2³ (2 to the power of 3)?',
        options: ['6', '8', '9', '12'],
        correctOptionIndex: 1,
        timeLimit: 25,
      ),
      QuizItem(
        type: 'Slide',
        title: 'Geometry Basics',
        description:
            'Geometry deals with shapes, sizes, and properties of space. It includes concepts like area, perimeter, volume, and angles.',
        timeLimit: 40,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'How many sides does a hexagon have?',
        options: ['5', '6', '7', '8'],
        correctOptionIndex: 1,
        timeLimit: 25,
      ),
    ],
  ),
  MyDiceData(
    title: 'Literature Review',
    image: const AssetImage('assets/images/banner5.jpg'),
    description: 'Classic literature and modern works.',
    status: 'Completed',
    totalQuestion: 7,
    isCompleted: true,
    questions: [
      QuizItem(
        type: 'Quiz',
        question: 'Who wrote "Romeo and Juliet"?',
        options: [
          'Charles Dickens',
          'William Shakespeare',
          'Jane Austen',
          'Mark Twain'
        ],
        correctOptionIndex: 1,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'True or False',
        question: '"To Kill a Mockingbird" was written by Harper Lee.',
        selectedAnswer: 'True',
        timeLimit: 30,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'In which novel would you find the character Atticus Finch?',
        options: [
          '1984',
          'To Kill a Mockingbird',
          'The Great Gatsby',
          'Pride and Prejudice'
        ],
        correctOptionIndex: 1,
        timeLimit: 45,
      ),
      QuizItem(
        type: 'Slide',
        title: 'Literary Genres',
        description:
            'Literature encompasses various genres including fiction, non-fiction, poetry, drama, and essays. Each genre has unique characteristics and purposes.',
        timeLimit: 50,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is the first book in the Harry Potter series?',
        options: [
          'Chamber of Secrets',
          'Philosopher\'s Stone',
          'Prisoner of Azkaban',
          'Goblet of Fire'
        ],
        correctOptionIndex: 1,
        timeLimit: 35,
      ),
      QuizItem(
        type: 'True or False',
        question: 'George Orwell wrote "Brave New World".',
        selectedAnswer: 'False',
        timeLimit: 35,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which poet wrote "The Road Not Taken"?',
        options: [
          'Robert Frost',
          'Emily Dickinson',
          'Walt Whitman',
          'Maya Angelou'
        ],
        correctOptionIndex: 0,
        timeLimit: 40,
      ),
    ],
  ),
  MyDiceData(
    title: 'Geography Explorer',
    image: const AssetImage('assets/images/banner6.jpg'),
    description: 'Countries, capitals, and landmarks.',
    status: 'Draft',
    totalQuestion: 20,
    isCompleted: false,
    questions: [
      QuizItem(
        type: 'Quiz',
        question: 'What is the capital of France?',
        options: ['London', 'Berlin', 'Paris', 'Madrid'],
        correctOptionIndex: 2,
        timeLimit: 30,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Australia is both a country and a continent.',
        selectedAnswer: 'True',
        timeLimit: 25,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which is the largest ocean on Earth?',
        options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
        correctOptionIndex: 3,
        timeLimit: 35,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is the highest mountain in the world?',
        options: ['K2', 'Mount Everest', 'Kangchenjunga', 'Lhotse'],
        correctOptionIndex: 1,
        timeLimit: 35,
      ),
      QuizItem(
        type: 'True or False',
        question: 'The Nile is the longest river in the world.',
        selectedAnswer: 'True',
        timeLimit: 30,
      ),
      QuizItem(
        type: 'Slide',
        title: 'World Continents',
        description:
            'There are seven continents: Asia, Africa, North America, South America, Antarctica, Europe, and Australia. Each has unique geographical features.',
        timeLimit: 45,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which country has the most time zones?',
        options: ['Russia', 'United States', 'China', 'Canada'],
        correctOptionIndex: 0,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is the smallest country in the world?',
        options: ['Monaco', 'San Marino', 'Vatican City', 'Liechtenstein'],
        correctOptionIndex: 2,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'True or False',
        question: 'The Amazon rainforest is primarily located in Brazil.',
        selectedAnswer: 'True',
        timeLimit: 30,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which desert is the largest in the world?',
        options: ['Sahara', 'Gobi', 'Antarctic Desert', 'Arabian'],
        correctOptionIndex: 2,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is the capital of Japan?',
        options: ['Osaka', 'Tokyo', 'Kyoto', 'Hiroshima'],
        correctOptionIndex: 1,
        timeLimit: 30,
      ),
      QuizItem(
        type: 'True or False',
        question:
            'The Great Barrier Reef is located off the coast of Australia.',
        selectedAnswer: 'True',
        timeLimit: 25,
      ),
      QuizItem(
        type: 'Slide',
        title: 'Climate Zones',
        description:
            'Earth has various climate zones including tropical, temperate, polar, and arid. These zones affect weather patterns, vegetation, and wildlife.',
        timeLimit: 50,
      ),
      QuizItem(
        type: 'Quiz',
        question:
            'Which African country is completely surrounded by South Africa?',
        options: ['Swaziland', 'Lesotho', 'Botswana', 'Zimbabwe'],
        correctOptionIndex: 1,
        timeLimit: 45,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is the currency of the United Kingdom?',
        options: ['Euro', 'Dollar', 'Pound Sterling', 'Franc'],
        correctOptionIndex: 2,
        timeLimit: 30,
      ),
      QuizItem(
        type: 'True or False',
        question: 'The Panama Canal connects the Atlantic and Pacific Oceans.',
        selectedAnswer: 'True',
        timeLimit: 30,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which city is known as the "Big Apple"?',
        options: ['Los Angeles', 'Chicago', 'New York City', 'Boston'],
        correctOptionIndex: 2,
        timeLimit: 25,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What is the deepest point on Earth?',
        options: [
          'Mariana Trench',
          'Dead Sea',
          'Grand Canyon',
          'Challenger Deep'
        ],
        correctOptionIndex: 0,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Mount Kilimanjaro is located in Kenya.',
        selectedAnswer: 'False',
        timeLimit: 35,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which country is home to Machu Picchu?',
        options: ['Ecuador', 'Bolivia', 'Peru', 'Colombia'],
        correctOptionIndex: 2,
        timeLimit: 35,
      ),
    ],
  ),
  MyDiceData(
    title: 'Technology Trends',
    image: const AssetImage('assets/images/banner1.jpg'),
    description: 'Latest technology and innovations.',
    status: 'Completed',
    totalQuestion: 9,
    isCompleted: true,
    questions: [
      QuizItem(
        type: 'Quiz',
        question: 'What does AI stand for?',
        options: [
          'Advanced Intelligence',
          'Artificial Intelligence',
          'Automated Integration',
          'Applied Information'
        ],
        correctOptionIndex: 1,
        timeLimit: 30,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Machine learning is a subset of artificial intelligence.',
        selectedAnswer: 'True',
        timeLimit: 30,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'Which company developed the first iPhone?',
        options: ['Samsung', 'Google', 'Apple', 'Microsoft'],
        correctOptionIndex: 2,
        timeLimit: 25,
      ),
      QuizItem(
        type: 'Slide',
        title: 'Cloud Computing',
        description:
            'Cloud computing provides on-demand access to computing resources over the internet, enabling scalable and flexible technology solutions.',
        timeLimit: 45,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What does VR stand for?',
        options: [
          'Video Recording',
          'Virtual Reality',
          'Visual Recognition',
          'Voice Response'
        ],
        correctOptionIndex: 1,
        timeLimit: 30,
      ),
      QuizItem(
        type: 'True or False',
        question: 'Blockchain technology is only used for cryptocurrency.',
        selectedAnswer: 'False',
        timeLimit: 35,
      ),
      QuizItem(
        type: 'Quiz',
        question:
            'Which programming language is most commonly used for web development?',
        options: ['Python', 'Java', 'JavaScript', 'C++'],
        correctOptionIndex: 2,
        timeLimit: 40,
      ),
      QuizItem(
        type: 'Quiz',
        question: 'What does IoT stand for?',
        options: [
          'Internet of Things',
          'Integration of Technology',
          'Information over Time',
          'Interactive Online Tools'
        ],
        correctOptionIndex: 0,
        timeLimit: 35,
      ),
      QuizItem(
        type: 'True or False',
        question:
            'Quantum computers use quantum bits (qubits) instead of traditional bits.',
        selectedAnswer: 'True',
        timeLimit: 40,
      ),
    ],
  ),
];
