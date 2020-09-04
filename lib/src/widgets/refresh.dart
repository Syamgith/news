import 'package:flutter/material.dart';

class Refresh extends StatelessWidget {
  final child;
  Refresh({this.child});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () {
        return;
      },
    );
  }
}
