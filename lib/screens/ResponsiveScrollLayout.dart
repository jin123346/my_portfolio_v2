import 'package:flutter/material.dart';

import 'ResponsiveLayout.dart';

/// 모든 페이지에 일관된 스크롤 가능한 레이아웃을 제공하는 위젯
///
///
class ResponsiveScrollLayout extends StatelessWidget {
  final List<Widget> children;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final bool centerHorizontally;
  final Color? backgroundColor;
  final CrossAxisAlignment crossAxisAlignment;
  final ScrollPhysics? physics;

  const ResponsiveScrollLayout({
    Key? key,
    required this.children,
    this.maxWidth = 1200,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.centerHorizontally = true,
    this.backgroundColor,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      maxWidth: maxWidth,
      padding: padding,
      centerHorizontally: centerHorizontally,
      backgroundColor: backgroundColor,
      child: SingleChildScrollView(
        physics: physics,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      ),
    );
  }
}
