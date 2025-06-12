import 'package:flutter/material.dart';
import 'package:product_dice/core/data/faq_data.dart';
import 'package:product_dice/features/setting/widgets/app_bar_setting.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarSetting(title: 'FAQ'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...faqData.map((faq) {
                return Container(
                  margin: EdgeInsets.only(bottom: size.height * 0.015),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E7E7),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tilePadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.01,
                    ),
                    childrenPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.01,
                    ),
                    title: Text(
                      faq.question,
                      style: const TextStyle(
                        fontFamily: 'poppins-normal',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    children: [
                      Text(
                        faq.answer,
                        style: const TextStyle(
                          fontFamily: 'poppins-normal',
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: size.height * 0.04),
              Center(
                child: Text(
                  'Last Updated: 27/03/2025\nContact: support@DICE.com',
                  style: TextStyle(fontSize: size.height * 0.017),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
