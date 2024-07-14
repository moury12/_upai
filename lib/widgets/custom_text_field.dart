import '/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final IconData? prefixIcon;
  final Function(String?value)? onChanged;
  final String? validatorText;

  const CustomTextField(
      {super.key, this.controller, this.fieldKey, this.isPasswordField, this.hintText, this.labelText, this.helperText, this.onSaved, this.validator, this.onFieldSubmitted, this.inputType, this.prefixIcon, this.onChanged, this.validatorText,
     });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

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
        textInputAction: widget.isPasswordField == true
            ? TextInputAction.done
            : TextInputAction.next,
        style: const TextStyle(color: Colors.black),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator ??
                (value) {
              if ((value == null || value.isEmpty) &&
                  (widget.validatorText != null && widget.validatorText != '')) {
                return ' ${widget.validatorText}';
              }
              return null;
            },
        onFieldSubmitted: widget.onFieldSubmitted,
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        decoration: InputDecoration(
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
      ),
    );
  }
}
