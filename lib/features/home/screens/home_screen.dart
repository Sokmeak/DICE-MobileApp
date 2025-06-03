import 'package:flutter/material.dart';
import 'package:product_dice/core/config/banner_images.dart';
import 'package:product_dice/core/data/discover_data.dart';
import 'package:product_dice/core/data/my_dice_data.dart';
import 'package:product_dice/core/data/topic_data.dart';
import 'package:product_dice/features/home/widgets/card_banner.dart';
import 'package:product_dice/features/home/widgets/card_image.dart';
import 'package:product_dice/features/home/widgets/card_my_dice.dart';
import 'package:product_dice/features/home/widgets/card_topic.dart';
import 'package:product_dice/features/home/widgets/hori_icon_see_all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CardBannerCarousel(
                images: [
                  AssetImage(AppBanner.banner1),
                  AssetImage(AppBanner.banner2),
                  AssetImage(AppBanner.banner3),
                ],
              ),

              // Your DICE
              SizedBox(height: screenHeight * 0.02),
              HorizontalIconSeeAll(
                icon: Icons.person_rounded,
                title: 'Your DICE',
                onPressed: () {},
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                height: screenHeight * 0.30, // adjust based on your card height
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics:
                      const BouncingScrollPhysics(), // for smooth scrolling
                  itemCount: myDiceData.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final data = myDiceData[index];
                    return SizedBox(
                      width: screenWidth * 0.7,
                      child: CardMyDice(data: data),
                    );
                  },
                ),
              ),

              // Discover
              SizedBox(height: screenHeight * 0.02),
              HorizontalIconSeeAll(
                icon: Icons.explore_outlined,
                title: 'Discover',
                onPressed: () {},
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                height: screenHeight * 0.20, // adjust based on your card height
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics:
                      const BouncingScrollPhysics(), // for smooth scrolling
                  itemCount: discoverData.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final data = discoverData[index];
                    return SizedBox(
                      width: screenWidth * 0.7,
                      child: CardImage(data: data),
                    );
                  },
                ),
              ),

              // Partner Collections
              SizedBox(height: screenHeight * 0.02),
              HorizontalIconSeeAll(
                icon: Icons.group_sharp,
                title: 'Partner Collections',
                onPressed: () {},
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                height: screenHeight * 0.15, // adjust based on your card height
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics:
                      const BouncingScrollPhysics(), // for smooth scrolling
                  itemCount: discoverData.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final data = discoverData[index];
                    return SizedBox(
                      width: screenWidth * 0.7,
                      child: CardImage(data: data),
                    );
                  },
                ),
              ),

              // Partner Collections
              SizedBox(height: screenHeight * 0.02),
              HorizontalIconSeeAll(
                icon: Icons.category_rounded,
                title: 'Categories',
                onPressed: () {},
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                height: screenHeight * 0.10, // adjust based on your card height
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics:
                      const BouncingScrollPhysics(), // for smooth scrolling
                  itemCount: discoverData.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final data = discoverData[index];
                    return SizedBox(
                      width: screenWidth * 0.7,
                      child: CardImage(data: data),
                    );
                  },
                ),
              ),

              // Topic
              SizedBox(height: screenHeight * 0.02),
              HorizontalIconSeeAll(
                icon: Icons.topic_rounded,
                title: 'Topic',
                onPressed: () {},
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                height: screenHeight * 0.30, // adjust based on your card height
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics:
                      const BouncingScrollPhysics(), // for smooth scrolling
                  itemCount: topicData.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final data = topicData[index];
                    return SizedBox(
                      width: screenWidth * 0.5,
                      child: CardTopic(data: data),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
