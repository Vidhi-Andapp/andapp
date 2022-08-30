import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';
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
  final String placeholderImage;
  final String errorImage;
  final BoxFit errorImageFit;

  const CustomNetworkImage(
      {Key? key,
      this.width = 150,
      this.height = 180,
      this.fit = BoxFit.cover,
      this.image = '',
      this.radius = 0,
      this.placeholderImage = '',
      this.errorImage = '',
      this.errorImageFit = BoxFit.contain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: appTheme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(
          color: Colors.white,
          width: 5.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: image,
          width: width,
          height: height,
          errorWidget: (context, url, error) => Image.asset(
            placeholderImage,
            width: width,
            height: height,
          ),
          placeholder: (context, url) => Center(
            child: SizedBox(
              width: width,
              height: height,
              child: ShimmerLoading(
                isLoading: true,
                child: Container(
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage(placeholderImage))),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    /* ClipRRect(
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
                    image:
                        DecorationImage(image: AssetImage(placeholderImage))),
              ),
            ),
          ),
        ),
      ),
    );*/
  }
}