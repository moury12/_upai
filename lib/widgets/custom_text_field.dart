import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final bool? isEmail;
  final bool? isEnable;
  final double? height;
  final double? width;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final int? maxLines;
  final double? inputFontSize;
  final TextAlign? textAlign;
  final FormFieldSetter<String>? onSaved;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final IconData? prefixIcon;
  final Function(String? value)? onChanged;
  final Function()? onPressed;
  final String? validatorText;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final EdgeInsets? padding;
  final List<TextInputFormatter>? textInputFormatter;

  const CustomTextField({
    super.key,
    this.controller,
    this.fieldKey,
    this.isPasswordField = false,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
    this.prefixIcon,
    this.onChanged,
    this.validatorText,
    this.textAlign,
    this.maxLines,
    this.suffixIcon,
    this.onPressed,
    this.isEmail = false,
    this.hintStyle,
    this.inputFontSize,
    this.height,
    this.width,
    this.textInputFormatter,
    this.padding,
    this.isEnable,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: TextFormField(
        inputFormatters: widget.textInputFormatter ?? [],
        enabled: widget.isEnable ?? true,
        onTap: widget.onPressed ?? () {},
        textAlign: widget.textAlign ?? TextAlign.left,
        maxLines: widget.maxLines ?? 1,
        onChanged: widget.onChanged,
        textInputAction: widget.isPasswordField == true ? TextInputAction.done : TextInputAction.next,
        style: TextStyle(color: Colors.black, fontSize: widget.inputFontSize ?? null),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator ??
            (value) {
              if ((value == null || value.isEmpty || (widget.isEmail == true && !value.isEmail)) && (widget.validatorText != null && widget.validatorText != '')) {
                if (widget.isEmail == true) {
                  return 'Please provide valid email';
                } else {
                  return ' ${widget.validatorText}';
                }
              }
              return null;
            },
        onFieldSubmitted: widget.onFieldSubmitted,
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: widget.labelText,
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.kprimaryColor)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.kprimaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:  BorderSide(
                color:AppColors.kprimaryColor,
              )),
          filled: true,
          contentPadding: widget.padding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: AppColors.kprimaryColor,
                )
              : null,
          // decoration: InputDecoration(
          //   border: InputBorder.none,
          // filled: true,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ?? TextStyle(fontSize: 13, color: AppColors.colorBlack.withOpacity(0.3)),

          suffixIcon: widget.suffixIcon != null
              ? widget.suffixIcon
              : widget.isPasswordField!
                  ? GestureDetector(
                      onTap: () {
                        _obscureText = !_obscureText;
                        setState(() {});
                      },
                      child: widget.isPasswordField!
                          ? Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.primaryColor,
                            )
                          : const SizedBox(),
                    )
                  : null,
        ),
      ),
    );
  }
}
