import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/utils/validation_helper.dart';

class AppNetworkImage extends StatefulWidget {
  final String imgUrl;
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget? errorPlaceholder;
  final Widget? loadingPlaceholder;
  final BoxFit? boxFit;
  final int? maxWidthDiskCache;
  final int? memCacheWidth;
  final int? maxHeightDiskCache;
  final int? memCacheHeight;
  final bool enableCache;
  final bool canOpenImage;

  const AppNetworkImage({
    super.key,
    required this.imgUrl,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.boxFit,
    this.maxWidthDiskCache,
    this.memCacheWidth,
    this.maxHeightDiskCache,
    this.memCacheHeight,
    this.enableCache = true,
    this.canOpenImage = false,
  });

  @override
  State<AppNetworkImage> createState() => _AppNetworkImageState();
}

class _AppNetworkImageState extends State<AppNetworkImage> {
  @override
  void dispose() {
    _deleteImageFromCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _checkMemory();
    return (widget.imgUrl.isEmpty)
        ? SizedBox(
            height: widget.height,
            width: widget.width,
            child: const _ImageErrorWidget(),
          )
        : GestureDetector(
            onTap: () {
              if (widget.canOpenImage) {
                // FilePreviewScreen.open(context, widget.imageUrl);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: _isSVGImage(widget.imgUrl)
                  ? SvgPicture.network(
                      widget.imgUrl,
                      height: widget.height,
                      width: widget.width,
                      fit: widget.boxFit ?? BoxFit.contain,
                      placeholderBuilder: (context) =>
                          widget.loadingPlaceholder ??
                          const _ImageProgressIndicatorBuilder(),
                    )
                  : CachedNetworkImage(
                    httpHeaders: {
                  'Authorization': "Bearer ${LocalSharePreference.token}",  // If needed for authentication
                     },
                      height: widget.height,
                      width: widget.width,
                      imageUrl: widget.imgUrl,
                      fit: widget.boxFit,
                      /// when enable to cache the image then
                      cacheKey: widget.enableCache ? widget.imgUrl : null,
                      maxWidthDiskCache: widget.maxWidthDiskCache,
                      memCacheWidth: widget.memCacheWidth,
                      maxHeightDiskCache: widget.maxHeightDiskCache,
                      memCacheHeight: widget.memCacheHeight,

                      // placeholder: (context, url) => Image.asset(AppAssetPaths.placeholderIcon),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return widget.loadingPlaceholder ??
                            const _ImageProgressIndicatorBuilder();
                      },
                      errorWidget: (context, url, error) =>
                          widget.errorPlaceholder ?? const _ImageErrorWidget(),
                    ),
            ),
          );
  }

///////////////////////////////////////////////////////////
//////////////////// Helper methods ///////////////////////
///////////////////////////////////////////////////////////

  Future _deleteImageFromCache() async {
    if (!widget.enableCache) {
      await CachedNetworkImage.evictFromCache(widget.imgUrl);
    }
  }

  bool _isSVGImage(String attachmentPath) {
    final String ext = attachmentPath.split(".").last.toLowerCase();
    return ext == "svg";
  }

  // bool get _validURL => ValidationHelper.isUrl(widget.imgUrl);

  void _checkMemory() {
    final ImageCache imageCache = PaintingBinding.instance.imageCache;
    if (imageCache.currentSizeBytes >= 100 << 19 ||
        imageCache.currentSize >= imageCache.maximumSize) {
      imageCache.clear();
      imageCache.clearLiveImages();
    }
  }
}

class AppCachedNetworkImageProvider extends CachedNetworkImageProvider {
  final String imageUrl;

  const AppCachedNetworkImageProvider({
    required this.imageUrl,
    int? maxHeight,
    int? maxWidth,
  }) : super(
          imageUrl,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        );
}

class _ImageProgressIndicatorBuilder extends StatelessWidget {
  const _ImageProgressIndicatorBuilder()
      : super(key: const ValueKey("_ImageProgressIndicatorBuilder"));

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: RepaintBoundary(
        child: CircularProgressIndicator(
          color: AppColors.greenColor,
        ),
      ),
    );
  }
}

class _ImageErrorWidget extends StatelessWidget {
  const _ImageErrorWidget() : super(key: const ValueKey("_ImageErrorWidget"));

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: Center(
        child: Padding(padding: EdgeInsets.all(20.0), child: Icon(Icons.error)),
      ),
    );
  }
}
