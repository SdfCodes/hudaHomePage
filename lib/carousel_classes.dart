import 'package:flutter/material.dart';

class ClassModel {
  final String title;
  final String imageUrl;
  final String category;

  ClassModel({
    required this.title,
    required this.imageUrl,
    required this.category,
  });
}

class CarouselClasses extends StatefulWidget {
  final List<ClassModel> classList;
  const CarouselClasses({super.key, required this.classList});

  @override
  State<CarouselClasses> createState() => _CarouselClassesState();
}

class _CarouselClassesState extends State<CarouselClasses> {
  late final PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.classList.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.classList.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: NewestClassesCard(data: widget.classList[index]),
              );
            },
          ),
        ),
        SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.classList.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: _currentIndex == index ? 18 : 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),

                color: _currentIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).dividerTheme.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewestClassesCard extends StatelessWidget {
  final ClassModel data;
  const NewestClassesCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerTheme.color!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: data.imageUrl.isEmpty
                    ? Icon(Icons.image, color: theme.disabledColor)
                    : Image.network(data.imageUrl, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.category.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.secondary,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    data.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
