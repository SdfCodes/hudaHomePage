import 'package:flutter/material.dart';
import 'package:huda_home_page/carousel_classes.dart';
import 'package:huda_home_page/headerdesig.dart';
import 'package:flutter/material.dart';
import 'package:huda_home_page/services/api_services.dart';
import 'package:huda_home_page/widgets/class_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ClassModel> Classes = [
    ClassModel(title: "UI/UX Design", imageUrl: "", category: "Design"),
    ClassModel(title: "Flutter Development", imageUrl: "", category: "Coding"),
    ClassModel(title: "Digital Marketing", imageUrl: "", category: "Business"),
  ];

  @override
  Widget build(BuildContext context) {
    return HeaderDesign(
      title: "Home",
      action: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      children: [
        Text("     Newest Classes", style: TextTheme.of(context).headlineSmall),
        const SizedBox(height: 12),
        CarouselClasses(classList: Classes),
        SizedBox(height: 15),
        Text(
          "     Popular Classes",
          style: TextTheme.of(context).headlineSmall,
        ),
      ],
    );
  }
}
