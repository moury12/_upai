import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import '../../core/utils/image_path.dart';
import '../../widgets/custom_text_field2.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ProfileScreenController ctrl = Get.put(ProfileScreenController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? image;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //const SizedBox(height: 10,),
                  Stack(
                    children: [
                      GetBuilder<ProfileScreenController>(builder: (ctrl) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: AppColors.strokeColor, width: 3)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              height: 150,
                              width: 150,
                              imageUrl: "",
                              fit: BoxFit.cover,
                              // placeholder: (context, url) => Image.asset(ImageConstant.senderImg, fit: BoxFit.cover),
                              errorWidget: (context, url, error) =>image==null?Image.asset(ImageConstant.senderImg, fit: BoxFit.cover):
                                  Image.file(File(image!.path).absolute,
                                      fit: BoxFit.cover),
                            ),
                          ),
                        );
                      }),
                      Positioned(
                        bottom: 7,
                        right: 8,
                        child: InkWell(
                          onTap: () {
                            getImage();

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: FaIcon(
                                FontAwesomeIcons.solidPenToSquare, size: 20,

                              ),
                            ),
                          ),
                        ),
                      ),
                    ],

                  ),

                  const SizedBox(height: 20,),
                  const CustomTextField2(
                    isEditable: false,
                    hintText: "User ID",
                    prefixIcon: Icons.numbers,
                  ),
                  const SizedBox(height: 20,),
                   CustomTextField2(
                    controller:ctrl.nameTE,
                    validatorText: "Please Enter Your Name",
                    hintText: "Name",
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(height: 20,),
                  CustomTextField2(
                    controller: ctrl.emailTE,
                    validatorText: "Please Enter an Email Address",
                    hintText: "Email",
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 20,),
                  IntlPhoneField(
                    controller: ctrl.phoneTE,

                    validator: (value) {
                      if (value!.number.isEmpty) {
                        return "Please Enter a Valid Number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(

                      hintText: "Mobile Number",
                      filled: true,
                      fillColor: AppColors.textFieldBackGround,
                      // labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    initialCountryCode: 'BD',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery
                          .sizeOf(context)
                          .width * .85,
                      child: ElevatedButton(onPressed: () {
                        if (_formKey.currentState!.validate()) {


                        }
                      },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.BTNbackgroudgrey,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text("Update Profile"),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      ctrl.update();

       // setState(() {});
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
          "No Image Selected!", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.deepOrange,));
      }
    }
  }
}


