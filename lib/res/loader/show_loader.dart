import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';

class ShowLoader {
  static OverlayEntry? _overlayEntry;

  static void loader(BuildContext context) { 
     if (_overlayEntry != null) {
      // If it exists, do not show it again.
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Material(
          color:
              Colors.black.withOpacity(0.4), // Semi-transparent background
          child: Center(
            child: Container(
                width: 37,
                height: 37,
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor, shape: BoxShape.circle),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(7),
                child:  CircularProgressIndicator(
                  color: AppColors.greenColor,
                  strokeWidth: 3,
                )),
          ),
        ),
      ),
    );

    // Insert the overlay entry into the overlay stack
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideLoader() {
    if (_overlayEntry != null) {
      // cancelToken.cancel('request cancel'); /// cancel the request if dispose the loder
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
