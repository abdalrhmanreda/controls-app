import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:control_app/config/colors/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  // Controller and Focus
  final TextEditingController? controller;
  final FocusNode? focusNode;

  // Text Properties
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final bool readOnly;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;

  // Decoration
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final String? prefixText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;
  final Color? hoverColor;
  final Color? focusColor;
  final bool isDense;
  final String? counterText;
  final Widget? counter;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final TextStyle? errorStyle;

  // Validation and Callbacks
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;

  // Additional Properties
  final bool expands;
  final String obscuringCharacter;
  final bool enableInteractiveSelection;
  final ScrollPhysics? scrollPhysics;
  final Brightness? keyboardAppearance;
  final AutovalidateMode? autovalidateMode;
  final bool enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;

  const AppTextFormField({
    super.key,
    // Controller and Focus
    this.controller,
    this.focusNode,

    // Text Properties
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.maxLengthEnforcement,

    // Decoration
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.contentPadding,
    this.filled,
    this.fillColor,
    this.hoverColor,
    this.focusColor,
    this.isDense = false,
    this.counterText,
    this.counter,

    // Validation and Callbacks
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.enabled,
    this.inputFormatters,

    // Additional Properties
    this.expands = false,
    this.obscuringCharacter = '•',
    this.enableInteractiveSelection = true,
    this.scrollPhysics,
    this.keyboardAppearance,
    this.autovalidateMode,
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
    this.hintStyle,
    this.borderRadius,
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Controller and Focus
      controller: controller,
      focusNode: focusNode,

      initialValue: initialValue,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      style: style,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      autofocus: autofocus,
      readOnly: readOnly,
      obscureText: obscureText,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      // Obscured fields cannot be multiline, force maxLines to 1 when obscureText is true
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,

      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixText: prefixText,
        suffixText: suffixText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle:
            hintStyle ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.kGrayColor,
              fontSize: 14,
            ),
        prefix: prefix,
        suffix: suffix,

        errorStyle:
            errorStyle ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.kRedColor,
              fontSize: 12,
            ),

        border:
            border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
              borderSide: BorderSide(color: AppColors.kGrayColor, width: 1),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 1),
              borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
            ),
        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
              borderSide: BorderSide(color: AppColors.kRedColor, width: 1),
            ),
        focusedErrorBorder:
            focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
              borderSide: BorderSide(color: AppColors.kRedColor, width: 1),
            ),
        disabledBorder:
            disabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.kGrayColor, width: 1),
            ),
        contentPadding: contentPadding,
        filled: filled,
        fillColor: fillColor,
        hoverColor: hoverColor,
        focusColor: focusColor,
        isDense: isDense,
        counterText: counterText,
        counter: counter,
      ),

      // Validation and Callbacks
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      onTap: onTap,
      enabled: enabled,
      inputFormatters: inputFormatters,
      expands: expands,
      obscuringCharacter: obscuringCharacter,
      enableInteractiveSelection: enableInteractiveSelection,
      scrollPhysics: scrollPhysics,
      keyboardAppearance: keyboardAppearance,
      autovalidateMode: autovalidateMode,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      mouseCursor: mouseCursor,
    );
  }
}
