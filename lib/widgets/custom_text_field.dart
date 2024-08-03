import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';

import '/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final dynamic data;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialText;
  final String? hintText;
  final int? maxLine;
  final String? lebelText;
  final dynamic formatter;
  final TextInputType? inputType;
  final bool? obscureText;
  final Color? fillColor;
  final void Function(String)? onChanged;
  final String? validatorText;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final bool? readOnly;
  final int? minLines;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final String? counterText;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool? textCopyPaste;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final double? textFieldHeight;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const CustomTextField(
      {super.key, this.controller, this.data, this.prefixIcon, this.suffixIcon, this.initialText, this.hintText, this.maxLine, this.lebelText, this.formatter, this.inputType, this.obscureText, this.fillColor, this.onChanged, this.validatorText, this.padding, this.radius, this.readOnly, this.minLines, this.textInputAction, this.maxLength, this.textAlign, this.textAlignVertical, this.counterText, this.onTap, this.textStyle, this.hintStyle, this.textCopyPaste, this.floatingLabelBehavior, this.textFieldHeight, this.validator, this.focusNode,
     });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.white.withOpacity(.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(

        onChanged: widget.onChanged,
        // textInputAction: widget.isPasswordField == true
        //     ? TextInputAction.done
        //     : TextInputAction.next,
        style: const TextStyle(color: Colors.black),
        obscureText: widget.obscureText??false,
        controller: widget.controller,
        keyboardType: widget.inputType,
        // key: widget.fieldKey,
        // obscureText: widget.isPasswordField ==true? widget.obSecureText! : false,
        // onSaved: widget.onSaved,
        validator: widget.validator ??
                (value) {
              if ((value == null || value.isEmpty) &&
                  (widget.validatorText != null && widget.validatorText != '')) {
                return ' ${widget.validatorText}';
              }
              return null;
            },
        // onFieldSubmitted: widget.onFieldSubmitted,
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColors.colorBlack.withOpacity(0.3)),
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.strokeColor2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.strokeColor2)),
          focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black,)),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            //color: AppColors.primaryColor,
          ),

          ),

    );
  }
}
