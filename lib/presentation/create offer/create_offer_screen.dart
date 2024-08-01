import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/widgets/custom_text_field.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({super.key});

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.strokeColor2,
      appBar: AppBar(
        title: Text("Create New Offer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Text("Job Title"),
               CustomTextField(
                 validatorText: "Please Enter Job Title",
                 prefixIcon: Icons.lock,
                 hintText: "Job Title",
                 // onChanged: (value) => controller.emailController.text.trim() = value!,
             ),
             Text("Job Description"),
             CustomTextField(

               validatorText: "Please Enter Job Description",
               prefixIcon: Icons.description,
               hintText: "Job Description",


               // onChanged: (value) => controller.emailController.text.trim() = value!,
             ),
           ],
        ),
      ),
    );
  }
}
