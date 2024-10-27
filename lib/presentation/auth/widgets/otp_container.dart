import 'package:flutter/material.dart';
import 'package:upai/widgets/custom_text_field.dart';

class OtpContainer extends StatefulWidget {
  const OtpContainer(
      {super.key, required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  State<OtpContainer> createState() => _OtpContainerState();
}

class _OtpContainerState extends State<OtpContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 0),
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(6),
      //     border: Border.all(
      //         width: widget.controller.text.isNotEmpty ? 1 : 0.5,
      //         color: AppColors.kPrimaryColor)),
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CustomTextField(
            inputType: TextInputType.number,
            enableBorderColor: Colors.grey.withOpacity(.5),
            hintText: '-',
            width: 50,
            height: 50,
            textAlign: TextAlign.center,
            onChanged: (value) {
              if (value!.length == 1) {
                FocusScope.of(context).nextFocus();
                setState(() {});
              }
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
                setState(() {});
              }
            },

            // inputFormatters: [
            //   LengthLimitingTextInputFormatter(1),
            //   FilteringTextInputFormatter.digitsOnly,
            // ],

            controller: widget.controller,
          ),
        ),
      ),
    );
  }
}
