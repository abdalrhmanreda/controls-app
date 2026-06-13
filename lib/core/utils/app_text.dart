import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/colors/app_colors.dart';
import '../helpers/responsive_text.dart';

class MyTextApp extends StatelessWidget {
  final String title;
  final Color? decorationColor;
  final Color? color;
  final double? size;
  final double? letterSpace;
  final double? wordSpace;
  final String? fontFamily;
  final TextAlign? align;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? height;
  final bool? swotWrap;
  final IconData? icon;
  final ImageProvider? image;
  final Color? iconColor;
  final double? iconSize;
  final double? imageSize;
  final VoidCallback? onTap;

  const MyTextApp({
    super.key,
    required this.title,
    this.color,
    this.size,
    this.decorationColor,
    this.align,
    this.fontFamily,
    this.decoration,
    this.letterSpace,
    this.wordSpace,
    this.overflow,
    this.fontWeight,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.onTap,
    this.maxLines,
    this.height,
    this.swotWrap,
  });

  // Named constructor for bold text
  const MyTextApp.bold({
    super.key,
    required this.title,
    this.size = 18,
    this.align = TextAlign.center,
    this.fontFamily,
    this.decoration = TextDecoration.none,
    this.letterSpace,
    this.wordSpace,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.decorationColor,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.maxLines,
    this.height,
    this.swotWrap,
  }) : fontWeight = FontWeight.bold,
       color = AppColors.kPrimaryColor,
       onTap = null;

  const MyTextApp.app({
    super.key,
    required this.title,
    // this.color,
    this.size = 18,
    this.decorationColor,
    this.align = TextAlign.start,
    this.fontFamily,
    this.decoration = TextDecoration.none,
    this.letterSpace,
    this.wordSpace,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.height,
    this.maxLines,
    this.swotWrap,
  }) : fontWeight = FontWeight.bold,
       color = AppColors.kPrimaryColor,
       onTap = null;

  // Named constructor for small text
  const MyTextApp.small({
    super.key,
    this.decorationColor,
    required this.title,
    this.size = 12,
    this.align = TextAlign.start,
    this.fontFamily,
    this.decoration = TextDecoration.none,
    this.letterSpace,
    this.wordSpace,
    this.overflow = TextOverflow.clip,
    this.icon,
    this.image,
    this.height,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.maxLines,
    this.swotWrap,
  }) : fontWeight = FontWeight.normal,
       color = AppColors.kPrimaryColor,
       onTap = null;

  // Named constructor for headings
  const MyTextApp.heading({
    super.key,
    this.decorationColor,
    required this.title,
    this.color = Colors.black,
    this.size = 24,
    this.align = TextAlign.center,
    this.fontFamily,
    this.swotWrap,

    this.decoration = TextDecoration.none,
    this.letterSpace = 1.2,
    this.wordSpace,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.maxLines,
    this.height,
  }) : fontWeight = FontWeight.bold,
       onTap = null;

  // Named constructor for navigable text
  const MyTextApp.nav({
    super.key,
    required this.title,
    this.decorationColor,
    this.color =
        Colors.blue, // يمكن تعديل اللون الافتراضي ليشير إلى قابلية النقر
    this.size = 16,
    this.align = TextAlign.start,
    this.fontFamily,
    this.decoration =
        TextDecoration.underline, // underline to indicate it's clickable
    this.letterSpace,
    this.wordSpace,
    this.swotWrap,

    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.maxLines,
    this.height,
    required this.onTap, // onTap is required for navigation
  }) : fontWeight = FontWeight.normal;

  @override
  Widget build(BuildContext context) {
    // حالة MyTextApp.nav التي تقبل النقر
    return onTap != null
        ? InkWell(onTap: onTap, child: _buildTextRow(context))
        : _buildTextRow(context);
  }

  MyTextApp copyWith({
    String? title,
    Color? color,
    double? size,
    TextAlign? align,
    String? fontFamily,
    TextDecoration? decoration,
    double? letterSpace,
    double? wordSpace,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
    VoidCallback? onTap,
    int? maxLines,
  }) {
    return MyTextApp(
      title: title ?? this.title,
      color: color ?? this.color,
      size: size ?? this.size,
      align: align,
      fontFamily: fontFamily,
      decoration: decoration,
      letterSpace: letterSpace,
      wordSpace: wordSpace,
      overflow: overflow,
      fontWeight: fontWeight,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
      onTap: onTap,
      maxLines: maxLines,
      height: height,
      swotWrap: swotWrap,
    );
  }

  Widget _buildTextRow(BuildContext context) {
    return Wrap(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: iconColor ?? Colors.black,
            size:
                iconSize ??
                getResponsiveFontSize(context, fontSize: size ?? 16),
          ),
        if (image != null)
          Image(image: image!, width: imageSize ?? 24, height: imageSize ?? 24),
        SizedBox(width: (icon != null || image != null) ? 8.0 : 0),
        Text(
          title,
          textAlign: align ?? TextAlign.start,
          style: GoogleFonts.exo2(
            color: color,
            fontSize: size != null
                ? getResponsiveFontSize(context, fontSize: size!)
                : null,
            letterSpacing: letterSpace,
            wordSpacing: wordSpace,
            decorationColor: decorationColor ?? color,
            decoration: decoration ?? TextDecoration.none,
            fontWeight: fontWeight ?? FontWeight.normal,
            height: height,
          ),
          maxLines: maxLines,
          overflow: overflow,
        ),
      ],
    );
  }
}
