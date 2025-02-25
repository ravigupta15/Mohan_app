import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/res/app_cashed_network.dart';

class ViewImage extends StatefulWidget {
 final String image;
  const ViewImage({super.key, required this.image});

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: ''),
      body: AppNetworkImage(
        imgUrl: widget.image,
      ),
    );
  }
}