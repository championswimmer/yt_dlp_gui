import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yt_dlp_gui/features/download_form/controller/thumbnail_pod.dart';


class ThumbnailViewer extends StatelessWidget {
  const ThumbnailViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final thumbnailurl = ref.watch(thumbanailUrlPod);
        if (thumbnailurl != null) {
          return CachedNetworkImage(
            imageUrl: thumbnailurl,
            imageBuilder: (context, imageProvider) {
              return Image(
                image: imageProvider,
                height: 200,
              );
            },
            errorWidget: (context, url, error) =>
                "Unable to get the thumbnail.Please check URL"
                    .toString()
                    .text
                    .make(),
          );
        } else {
          return child!;
        }
      },
      child: const SizedBox.shrink(),
    ).py8();
  }
}
