import 'package:flutter/material.dart';

class ExamCourse {
  final String title;
  final Color color;
  final String author;

  ExamCourse({
    required this.title,
    required this.color,
    required this.author,
  });
}

class ExamPreparationCard extends StatelessWidget {
  final String title;
  final String description;
  final List<ExamCourse> courses;
  final VoidCallback? onTap;

  const ExamPreparationCard({
    super.key,
    required this.title,
    required this.description,
    required this.courses,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFDB2777)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF8B5CF6).withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins-normal',
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
                fontFamily: 'poppins-normal',
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: courses.map((course) {
                return Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.only(right: courses.last == course ? 0 : 12),
                    height: size.height * 0.15,
                    decoration: BoxDecoration(
                      color: course.color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Course',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'poppins-normal',
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            course.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins-normal',
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                child: Icon(Icons.person,
                                    size: 10, color: Colors.white),
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  course.author,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'poppins-normal',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
