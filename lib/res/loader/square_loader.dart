import 'package:flutter/material.dart';
import 'package:mohan_impex/res/loader/loader_widget.dart';



class SquareLoader extends StatelessWidget {
  final Color color;

  const SquareLoader({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: 95,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const LoaderWidget(),
    );
  }
}
