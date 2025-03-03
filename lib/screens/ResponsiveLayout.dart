// lib/widgets/responsive_layout.dart
import 'package:flutter/material.dart';

/// 모든 페이지에 사용할 수 있는 반응형 레이아웃 래퍼 위젯
/// 화면 크기에 따라 적절한 여백과 최대 너비를 제공합니다.
class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final bool centerHorizontally;
  final bool centerVertically;
  final Color? backgroundColor;

  const ResponsiveLayout({
    Key? key,
    required this.child,
    this.maxWidth = 1200,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.centerHorizontally = true,
    this.centerVertically = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 화면 크기에 따라 패딩 조정
    EdgeInsetsGeometry responsivePadding = padding;
    if (screenWidth < 600) {
      // 모바일 화면
      responsivePadding =
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    } else if (screenWidth >= 1200) {
      // 매우 큰 화면
      responsivePadding =
          const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
    }

    Widget content = Padding(
      padding: responsivePadding,
      child: child,
    );

    // 수평 중앙 정렬이 필요한 경우
    if (centerHorizontally) {
      content = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          child: content,
        ),
      );
    }

    // 수직 중앙 정렬이 필요한 경우
    if (centerVertically) {
      content = Center(
        child: content,
      );
    }

    // 배경색이 지정된 경우
    if (backgroundColor != null) {
      content = ColoredBox(
        color: backgroundColor!,
        child: content,
      );
    }

    return content;
  }
}
