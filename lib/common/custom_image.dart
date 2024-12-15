import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:library_user_app/utils/images.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String placeholder;
  const CustomNetworkImage({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = ''});

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      imageUrl: image, height: height, width: width, fit: fit,
      placeholder: (context, url) => Image.asset(Images.placeholder, height: height, width: width, fit: fit),
      errorWidget: (context, url, error) => Image.asset(Images.placeholder, height: height, width: width, fit: fit),
    );
  }
}