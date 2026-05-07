import 'package:flutter/material.dart';

class HeaderDesign extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? leading;
  final Color? iconColor;
  final Widget? action;

  const HeaderDesign({
    super.key,
    required this.title,
    required this.children,
    this.leading,
    this.action,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 251, 205, 106),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 30,
                    child: Text(title, style: theme.textTheme.headlineLarge),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
