import '/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFeild extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final IconData? prefixIcon;
  final Function(String?value)? onChanged;

  const CustomTextFeild(
      {super.key,
      this.onChanged,
      this.controller,
      this.isPasswordField,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputType,
      this.prefixIcon});

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFeildState createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.35),
        borderRadius: BorderRadius.circular(7),
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
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1)),
          filled: false,
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
