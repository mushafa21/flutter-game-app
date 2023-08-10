import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final String? errorFile;
  final BoxFit? fit;
  const ImageView({Key? key, required this.url,this.height,this.width,this.fit,this.errorFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: url ,width: width,height: height,fit: fit, placeholder: (context,url) => Center(child: const CircularProgressIndicator()),
      errorWidget: (context,url,error) => Image.asset(errorFile ?? "asset/images/img_null.png",fit: fit,),
    );
  }
}