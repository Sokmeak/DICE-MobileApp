import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';

class CardMyDice extends StatelessWidget {
  final MyDiceData data;
  const CardMyDice({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + question count overlay
          Stack(
            children: [
              Image(
                image: data.image,
                width: double.infinity,
                height: height * 0.15,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: height * 0.01,
                left: width * 0.02,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.025,
                    vertical: height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF373A3B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${data.totalQuestion.toInt()} questions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.03,
                      fontFamily: 'poppins-normal',
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Title and status
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.025,
                    vertical: height * 0.004,
                  ),
                  decoration: BoxDecoration(
                    color: data.status == 'Draft' ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Text(
                    data.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.03,
                      fontFamily: 'poppins-normal',
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: Text(
                    data.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.035,
                      fontFamily: 'poppins-normal',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Progress bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Text(
              "Progress",
              style: TextStyle(
                fontSize: width * 0.03,
                fontFamily: 'poppins-normal',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.02,
            ),
            child: LinearProgressIndicator(
              value: data.isCompleted ? 1.0 : 0.5,
              backgroundColor: Colors.grey.shade300,
              color: data.isCompleted ? Colors.green : Colors.red,
              minHeight: height * 0.008,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }
}
