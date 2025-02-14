import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final Color? color;
  const LoaderWidget({super.key, this.color});

  factory LoaderWidget.white() {
    return LoaderWidget(color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
