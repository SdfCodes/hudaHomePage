import 'package:flutter/material.dart';
import '../models/course.dart';

class ClassCard extends StatelessWidget {
  final Course course;
  const ClassCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            course!.imageURL,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              children: [
                Text(course!.instructor),
                Text(course!.price.toString()),
                Text(course!.tags.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
