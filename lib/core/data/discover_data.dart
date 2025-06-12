import 'package:flutter/material.dart';
import 'package:product_dice/core/config/banner_images.dart';

class DiscoverData {
  String title;
  ImageProvider image;
  String description;
  String status;
  double totalQuestion;
  bool isCompleted;

  DiscoverData({
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.totalQuestion,
    required this.isCompleted,
  });
}

List<DiscoverData> discoverData = [
  DiscoverData(
    title: 'Create Engaging Quizzes',
    image: const AssetImage(AppBanner.banner4),
    description:
        'Design beautiful quizzes with multiple-choice questions, images, and time limits.',
    status: 'Completed',
    totalQuestion: 10,
    isCompleted: true,
  ),
  DiscoverData(
    title: 'Host Live Games',
    image: const AssetImage(AppBanner.banner5),
    description:
        'Invite players to join with a game code and compete in real-time.',
    status: 'Draft',
    totalQuestion: 5,
    isCompleted: false,
  ),
  DiscoverData(
    title: 'Track Performance',
    image: const AssetImage(AppBanner.banner6),
    description: 'View detailed analytics and insights about quiz performance.',
    status: 'Completed',
    totalQuestion: 3,
    isCompleted: true,
  ),
];
