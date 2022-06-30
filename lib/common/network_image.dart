import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/image_utils.dart';

import 'shimmer_loading.dart';

///
/// This class provides shimmer widget when data is being fetched from server
///
class CustomNetworkImage extends StatelessWidget {
  final double width;
  final double height;
  final BoxFit fit;
  final String image;
  final double radius;
  final String errorImage;
  final BoxFit errorImageFit;
  const CustomNetworkImage(
      {Key? key,
      this.width = 150,
      this.height = 180,
      this.fit = BoxFit.cover,
      this.image = '',
      this.radius = 0,
      this.errorImage = '',
      this.errorImageFit = BoxFit.contain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: image,
        width: width,
        height: height,
        fit: fit,
        errorWidget: (context, url, error) => Image.asset(
          errorImage.isNotEmpty ? errorImage : AssetImages.imagePlaceholder,
          width: width,
          height: height,
          fit: errorImageFit,
        ),
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: width,
            height: height,
            child: ShimmerLoading(
              isLoading: true,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetImages.imagePlaceholder))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
