import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double? Width;
  final double? height;
  const AppNetworkImage({super.key, required this.imgUrl,this.Width,this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: Width,
      height: height,
      fit: BoxFit.cover,
  imageUrl: imgUrl,
   placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
);
  }
}