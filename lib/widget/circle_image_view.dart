
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImageView extends StatelessWidget {
  final String url;
  final String? errorFile;
  final double? radius;
  final File? imageFile;
  const CircleImageView({Key? key,this.radius,required this.url,this.errorFile, this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox.fromSize(
        size: Size.fromRadius(radius ?? 30), // Image radius
        child: imageFile != null ?Image.file(imageFile!,fit: BoxFit.cover,) :CachedNetworkImage(imageUrl: url,placeholder: (context,url)=> Center(child: CircularProgressIndicator()), errorWidget: (context,url,error)=> Image.asset(errorFile ?? "asset/images/img_profil_null.jpg"),fit: BoxFit.cover,),
      ),
    );
  }
}
