import 'package:flutter/material.dart';
import 'package:product_dice/core/data/topic_data.dart';
import 'package:product_dice/core/theme/colors.dart';

class CardTopic extends StatelessWidget {
  final TopicData data;
  final Color? backgroundColor;

  const CardTopic({
    super.key,
    required this.data,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar with logo and status
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  image: data.logo,
                  height: size.height * 0.020,
                  width: size.height * 0.040,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 12),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.004,
                  ),
                  decoration: BoxDecoration(
                    color:
                        data.status == 'Discount' ? Colors.red : Colors.green,
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
                      fontSize: size.width * 0.03,
                      fontFamily: 'poppins-normal',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main image
          Image(
            image: data.image,
            width: double.infinity,
            height: size.height * 0.1,
            fit: BoxFit.cover,
          ),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.01,
            ),
            child: Text(
              data.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.width * 0.035,
                fontFamily: 'poppins-normal',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.005,
            ),
            child: Text(
              data.description,
              style: TextStyle(
                fontSize: size.width * 0.03,
                fontFamily: 'poppins-normal',
                color: AppColors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // "Progress" text
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.005,
            ),
            child: Text(
              "Progress",
              style: TextStyle(
                fontSize: size.width * 0.03,
                fontFamily: 'poppins-normal',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
