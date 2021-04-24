import 'package:flutter/material.dart';

/// Fixed sized loader to indicate progress
class BetLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
