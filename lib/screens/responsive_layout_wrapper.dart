import 'package:flutter/material.dart';

import 'ResponsiveLayout.dart';

class ResponsiveLayoutWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveLayoutWrapper({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 각 화면에 반응형 레이아웃을 적용
    // Scaffold 위젯을 포함하고 있지 않은 위젯인 경우 대비
    if (child is Scaffold) {
      return _applyResponsiveToScaffold(child as Scaffold);
    }

    // Scaffold가 아닌 경우 Scaffold로 감싸서 적용
    return Scaffold(
      body: ResponsiveLayout(
        child: child,
      ),
    );
  }

  // Scaffold 위젯에 반응형 레이아웃 적용
  Widget _applyResponsiveToScaffold(Scaffold scaffold) {
    // 기존 Scaffold의 body에 ResponsiveLayout 적용
    final responsiveBody = ResponsiveLayout(
      child: scaffold.body ?? Container(),
    );

    // 수정된 body로 새 Scaffold 반환
    return Scaffold(
      appBar: scaffold.appBar,
      body: responsiveBody,
      floatingActionButton: scaffold.floatingActionButton,
      floatingActionButtonLocation: scaffold.floatingActionButtonLocation,
      bottomNavigationBar: scaffold.bottomNavigationBar,
      drawer: scaffold.drawer,
      endDrawer: scaffold.endDrawer,
      backgroundColor: scaffold.backgroundColor,
      resizeToAvoidBottomInset: scaffold.resizeToAvoidBottomInset,
    );
  }
}
