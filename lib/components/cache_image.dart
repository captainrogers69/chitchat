import 'package:chitchat/utils/constants/k_assets.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class CacheImage extends StatelessWidget {
  final double? height, width, roundCorner;
  final String? heroTag, initialsProfile;
  final String image;
  final BoxFit? fit;
  const CacheImage(
      {this.initialsProfile,
      required this.image,
      this.roundCorner,
      this.heroTag,
      this.height,
      this.width,
      super.key,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundCorner ?? 100),
        // border: dummyFallback!
        //     ? Border(
        //         bottom: BorderSide(
        //           width: 0.1,
        //           color: primaryTextGreyColor,
        //         ),
        //       )
        //     : null,
      ),
      width: width ?? 45,
      height: height ?? 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(roundCorner ?? 100),
        child: FastCachedImage(
          url: image,
          alignment: Alignment.center,
          fit: fit ?? BoxFit.cover,
          width: width ?? 45,
          height: height ?? 45,
          loadingBuilder: (context, url) {
            return Image.asset(
              KAssets.loadingGif,
              fit: BoxFit.cover,
            );
          },
          errorBuilder: (context, url, error) {
            if (error.toString() == "Invalid image data") {}
            return Initicon(
              text: initialsProfile ?? image,
              elevation: 4,
            );
          },
        ),
      ),
    );
  }
}
