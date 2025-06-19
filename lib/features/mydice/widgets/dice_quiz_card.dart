import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';
import 'package:product_dice/core/theme/colors.dart';

class DiceQuizCard extends StatelessWidget {
  final MyDiceData data;
  final VoidCallback? onTap;

  const DiceQuizCard({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.008,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: Row(
            children: [
              // Quiz image
              Container(
                width: width * 0.2,
                height: width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: data.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: width * 0.04),

              // Quiz content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and question count
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${data.totalQuestion.toInt()} - ${data.title}',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Dropdown/menu icon
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey[600],
                          size: width * 0.06,
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.005),

                    // Status indicator
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.025,
                        vertical: height * 0.003,
                      ),
                      decoration: BoxDecoration(
                        color: data.status == 'Draft'
                            ? Colors.orange.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        data.status,
                        style: TextStyle(
                          color: data.status == 'Draft'
                              ? Colors.orange[700]
                              : Colors.green[700],
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.01),

                    // Progress bar (if needed)
                    if (!data.isCompleted)
                      Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.6, // 60% progress as example
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.purple,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
