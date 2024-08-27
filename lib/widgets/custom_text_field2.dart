import '/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField2 extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final String? validatorText;
  final bool? isPasswordField;
  final bool? isEditable;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final IconData? prefixIcon;
  final Function(String?value)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField2(
      {super.key, this.controller, this.fieldKey, this.validatorText, this.isPasswordField, this.isEditable, this.hintText, this.labelText, this.helperText, this.onSaved, this.onFieldSubmitted, this.inputType, this.prefixIcon, this.onChanged, this.validator,
        });

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator ??
              (value) {
            if ((value == null || value.isEmpty) &&
                (widget.validatorText != null && widget.validatorText != '')) {
              return '   ${widget.validatorText}';
            }
            return null;
          },
      onChanged: widget.onChanged,
      textInputAction: widget.isPasswordField == true
          ? TextInputAction.done
          : TextInputAction.next,
      style: const TextStyle(color: Colors.black),
      controller: widget.controller,
      keyboardType: widget.inputType,
      enabled: widget.isEditable,
      key: widget.fieldKey,
      obscureText: widget.isPasswordField == true ? _obscureText : false,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      decoration: InputDecoration(
        fillColor: AppColors.textFieldBackGround,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        prefixIcon: Icon(
          widget.prefixIcon,

          color: AppColors.primaryColor,
        ),
        // decoration: InputDecoration(
        //   border: InputBorder.none,
        // filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.colorBlack.withOpacity(0.3)),

        suffixIcon: GestureDetector(
          onTap: () {

            _obscureText = !_obscureText;

          },
          child: widget.isPasswordField == true
              ? Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primaryColor,
          )
              :const SizedBox(),
        ),
      ),
    );
  }
}
