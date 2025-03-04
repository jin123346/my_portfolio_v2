// lib/main.dart
import 'package:flutter/material.dart';
import 'package:my_portfolio/providers/theme_provider.dart';
import 'package:my_portfolio/screens/contact_screen.dart';
import 'package:my_portfolio/screens/home_screen.dart';
import 'package:my_portfolio/screens/project_detail_screen.dart';
import 'package:my_portfolio/screens/projects_screen.dart';
import 'package:my_portfolio/screens/responsive_layout_wrapper.dart';
import 'package:my_portfolio/screens/skill_screen.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyPortfolioApp(),
    ),
  );
}

// 포트폴리오 앱의 메인 클래스입니다.
// 앱의 테마와 라우팅을 설정합니다.
class MyPortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp: Flutter에서 Material Design을 사용하는 앱을 만들 때 사용하는 위젯
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        title: '김개발 포트폴리오', // 앱의 제목 설정
        theme: AppTheme.lightTheme, // 커스텀 라이트 테마 적용
        darkTheme: AppTheme.darkTheme, // 커스텀 다크 테마 적용
        themeMode: ThemeMode.light, // 시스템 설정에 따라 테마 변경
        home: ResponsiveLayoutWrapper(child: HomeScreen()), // 첫 화면 설정
        onGenerateRoute: _generateRoute, // 경로 생성 함수 설정
        debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
      );
    });
  }

  // 라우팅 설정 함수
  Route<dynamic> _generateRoute(RouteSettings settings) {
    Widget page;

    // 경로에 따라 적절한 화면으로 이동
    switch (settings.name) {
      case '/projects':
        page = ProjectsScreen();
        break;
      case '/skills':
        page = SkillsScreen();
        break;
      case '/contact':
        page = ContactScreen();
        break;
      default:
        page = HomeScreen();
    }

    // 모든 화면에 ResponsiveLayoutWrapper 적용
    return MaterialPageRoute(
      builder: (context) => ResponsiveLayoutWrapper(child: page),
      settings: settings,
    );
  }
}
