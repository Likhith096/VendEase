import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageView extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry margin;
  final BorderRadius? radius;
  final BoxBorder? border;
  final String placeHolder;

  CustomImageView({
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.cover,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin = EdgeInsets.zero,
    this.border,
    this.placeHolder = 'assets/images/image_not_found.png',
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  Widget _buildCircleImage() {
    return radius != null
        ? ClipRRect(
            borderRadius: radius!,
            child: _buildImageWithBorder(),
          )
        : _buildImageWithBorder();
  }

  Widget _buildImageWithBorder() {
    return border != null
        ? Container(
            decoration: BoxDecoration(
              border: border,
              borderRadius: radius,
            ),
            child: _buildImageView(),
          )
        : _buildImageView();
  }

  Widget _buildImageView() {
    return _getImageWidget();
  }

  Widget _getImageWidget() {
    switch (imagePath.imageType) {
      case ImageType.svg:
        return _buildSvgImage();
      case ImageType.file:
        return _buildFileImage();
      case ImageType.network:
        return _buildNetworkImage();
      case ImageType.png:
        return _buildPngImage();
      case ImageType.unknown:
        return _buildPlaceholderImage();
    }
  }

  Widget _buildSvgImage() {
    return Container(
      height: height,
      width: width,
      child: SvgPicture.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        color: color,
      ),
    );
  }

  Widget _buildFileImage() {
    return Image.file(
      File(imagePath),
      height: height,
      width: width,
      fit: fit,
      color: color,
    );
  }

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: fit,
      imageUrl: imagePath,
      color: color,
      placeholder: (context, url) => Container(
        height: 30,
        width: 30,
        child: LinearProgressIndicator(
          color: Colors.grey.shade200,
          backgroundColor: Colors.grey.shade100,
        ),
      ),
      errorWidget: (context, url, error) => _buildPlaceholderImage(),
    );
  }

  Widget _buildPngImage() {
    return Image.asset(
      imagePath,
      height: height,
      width: width,
      fit: fit,
      color: color,
    );
  }

  Widget _buildPlaceholderImage() {
    return Image.asset(
      placeHolder,
      height: height,
      width: width,
      fit: fit,
    );
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (this.startsWith('http') || this.startsWith('https')) {
      return ImageType.network;
    } else if (this.endsWith('.svg')) {
      return ImageType.svg;
    } else if (this.startsWith('file://')) {
      return ImageType.file;
    } else if (this.endsWith('.png')) {
      return ImageType.png;
    } else {
      return ImageType.unknown;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }
