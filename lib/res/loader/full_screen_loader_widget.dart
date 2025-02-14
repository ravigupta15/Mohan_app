import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/loader/square_circle_loading_widget.dart';
import 'package:mohan_impex/res/loader/square_loader.dart';

class FullScreenLoaderWidget extends StatelessWidget {
  final String? message;
  final bool showFlashLoading;

  const FullScreenLoaderWidget(
      {super.key, this.message, this.showFlashLoading = false});

  factory FullScreenLoaderWidget.onlyAnimation() {
    return const FullScreenLoaderWidget(showFlashLoading: true);
  }

  factory FullScreenLoaderWidget.message(String message) {
    return FullScreenLoaderWidget(message: message);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: AppColors.whiteColor,
      child: Center(
          child: message != null
              ? txtWithLoading(theme.cardColor)
              : loadingWidget(theme.cardColor)),
    );
  }

  Widget flashLoading(Color color) => SquareCircleLoadingWidget(color: color);
  Widget squareLoader(Color color) => SquareLoader(color: color);

  Widget txtWithLoading(Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        loadingWidget(color),
        const SizedBox(width: 20),
        Text(message!, style: TextStyle(fontSize: 20, color: color))
      ],
    );
  }

  Widget loadingWidget(Color color) {
    return showFlashLoading ? flashLoading(color) : squareLoader(color);
  }
}
