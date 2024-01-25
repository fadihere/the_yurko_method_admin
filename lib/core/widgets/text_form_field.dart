import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool? enabled;
  final String? labelText;
  final String? hintText;
  final VoidCallback? onTap;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String? value)? validator;
  final TextCapitalization? textCapitalization;
  final Widget? prefixIcon;
  final Color? labelCustomColor;
  final bool obscureText;
  final double borderRadius;
  final Color activeBorderColor;
  final Color borderColor;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.onTap,
    this.readOnly,
    this.enabled,
    this.maxLines,
    this.validator,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.hintText,
    this.minLines,
    this.textCapitalization,
    this.inputFormatters,
    this.prefixIcon,
    this.labelCustomColor,
    this.obscureText = false,
    this.borderRadius = 10.0,
    this.activeBorderColor = AppColors.darkgrey,
    this.borderColor = AppColors.outline,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        cursorColor: AppColors.primary,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 16),
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        onChanged: onChanged,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        controller: controller,
        inputFormatters: inputFormatters,
        onTap: onTap,
        validator: validator,
        readOnly: readOnly ?? false,
        minLines: minLines ?? 1,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null
              ? Transform.scale(
                  scale: 0.90,
                  child: prefixIcon,
                )
              : null,
          fillColor: const Color(0xffF1F1F1),
          contentPadding: const EdgeInsets.only(
            left: 18,
            right: 20,
            top: 12,
            bottom: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: AppColors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: AppColors.transparent,
            ),
          ),
          filled: true,
          suffixIcon: suffixIcon,
          suffixIconColor: const Color(0xff949393),
          labelText: labelText,
          floatingLabelStyle: const TextStyle(fontSize: 12),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xff949393)),
          prefixIconColor: const Color(0xff949393),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: labelCustomColor,
          ),
        ),
      ),
    );
  }
}
