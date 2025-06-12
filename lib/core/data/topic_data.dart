import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:product_dice/core/config/banner_images.dart';
import 'package:product_dice/core/config/get_start_images.dart';

class TopicData {
  ImageProvider logo;
  String title;
  ImageProvider image;
  String description;
  String status;
  bool isCompleted;

  TopicData({
    required this.logo,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.isCompleted,
  });
}

List<TopicData> topicData = [
  TopicData(
    logo: const AssetImage(AppStartImages.logo),
    title: 'Create Engaging Quizzes',
    image: const AssetImage(AppBanner.banner4),
    description:
        'Design beautiful quizzes with multiple-choice questions, images, and time limits.',
    status: 'Free',
    isCompleted: true,
  ),
  TopicData(
    logo: const AssetImage(AppStartImages.logo),
    title: 'Host Live Games',
    image: const AssetImage(AppBanner.banner5),
    description:
        'Invite players to join with a game code and compete in real-time.',
    status: 'Free',
    isCompleted: false,
  ),
  TopicData(
    logo: const AssetImage(AppStartImages.logo),
    title: 'Track Performance',
    image: const AssetImage(AppBanner.banner6),
    description: 'View detailed analytics and insights about quiz performance.',
    status: 'Free',
    isCompleted: true,
  ),
];
