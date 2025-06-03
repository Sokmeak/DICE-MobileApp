import 'package:flutter/material.dart';
import 'package:product_dice/core/config/banner_images.dart';

class MyDiceData {
  String title;
  ImageProvider image;
  String description;
  String status;
  double totalQuestion;
  bool isCompleted;

  MyDiceData({
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.totalQuestion,
    required this.isCompleted,
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
  ),
  MyDiceData(
    title: 'Host Live Games',
    image: const AssetImage(AppBanner.banner1),
    description:
        'Invite players to join with a game code and compete in real-time.',
    status: 'Draft',
    totalQuestion: 5,
    isCompleted: false,
  ),
  MyDiceData(
    title: 'Track Performance',
    image: const AssetImage(AppBanner.banner1),
    description: 'View detailed analytics and insights about quiz performance.',
    status: 'Completed',
    totalQuestion: 3,
    isCompleted: true,
  ),
];
