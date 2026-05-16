import 'package:flutter/material.dart';

class HeaderDesign extends StatelessWidget {
  final String title;
  final List<Widget>? children;
  final Widget? leading;
  final Widget? action;

  const HeaderDesign({
    super.key,
    required this.title,
    this.children,
    this.leading,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [if (action != null) action!],
          backgroundColor: theme.colorScheme.primary,
          expandedHeight: 200,
          pinned: true,
          leading: leading,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -50,
                  right: -100,
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 251, 205, 106),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 30,
                  child: Text(
                    title,
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
        ),

        if (children != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children!,
              ),
            ),
          ),
      ],
    );
  }
}