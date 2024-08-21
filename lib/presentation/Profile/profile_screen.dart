import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import '../../core/utils/custom_text_style.dart';
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
  String img = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // shadowColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        // backgroundColor: AppColors.strokeColor2,
        // foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        // leading: IconButton(
        //   icon: Icon(CupertinoIcons.back),
        //   onPressed: () {
        //     Get.back();
        //   },
        // ),
        title: Text(
          "Profile",
          style: AppTextStyle.bodyTitle700,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Obx( () {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: AppColors.strokeColor, width: 3)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              height: 150,
                              width: 150,
                              imageUrl: ctrl.profileImageUrl.value,
                              fit: BoxFit.cover,
                              // placeholder: (context, url) => Image.asset(ImageConstant.senderImg, fit: BoxFit.cover),
                              errorWidget: (context, url, error) =>
                                  /* ctrl.profileImageUrl.isNotEmpty
                                  ? Image.network(ctrl.profileImageUrl.value,fit: BoxFit.cover,):*/
                                  image == null
                                      ? Image.asset(ImageConstant.senderImg,
                                          fit: BoxFit.cover)
                                      : Image.file(File(image!.path).absolute,
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
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: FaIcon(
                                FontAwesomeIcons.solidPenToSquare,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField2(
                    isEditable: false,
                    hintText: ctrl.userInfo.userId.toString(),
                    prefixIcon: Icons.call,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField2(
                    isEditable: false,
                    controller: ctrl.nameTE,
                    validatorText: "Please Enter Your Name",
                    hintText: ctrl.userInfo.name.toString(),
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField2(
                    isEditable: false,
                    controller: ctrl.emailTE,
                    validatorText: "Please Enter an Email Address",
                    hintText: ctrl.userInfo.email.toString(),
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // IntlPhoneField(
                  //   controller: ctrl.phoneTE,
                  //
                  //   validator: (value) {
                  //     if (value!.number.isEmpty) {
                  //       return "Please Enter a Valid Number";
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //
                  //     hintText: "Mobile Number",
                  //     filled: true,
                  //    enabled: false,
                  //     fillColor: AppColors.textFieldBackGround,
                  //     // labelText: 'Phone Number',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //   ),
                  //   initialCountryCode: 'BD',
                  //   onChanged: (phone) {
                  //     print(phone.completeNumber);
                  //   },
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * .85,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.BTNbackgroudgrey,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text("Update Profile"),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //     onPressed: () async {
                  //       ImagePicker imagePicker = ImagePicker();
                  //       XFile? file = await imagePicker.pickImage(
                  //           source: ImageSource.camera);
                  //       print(file!.path.toString());
                  //       Reference ref = FirebaseStorage.instance.ref();
                  //       Reference refDir = ref.child('photos');
                  //       Reference refload = refDir.child(
                  //           DateTime.now().millisecondsSinceEpoch.toString());
                  //
                  //       try {
                  //         await refload.putFile(File(file.path));
                  //         img = await refload.getDownloadURL();
                  //       } catch (e) {}
                  //     },
                  //     child: Text('upload'))
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
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      ctrl.update();
      ctrl.save.value = true;
      await uploadFile();
      // setState(() {});
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "No Image Selected!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange,
        ));
      }
    }
  }

  Future uploadFile() async {
    if (image == null) return;
    final fileName = 'profile';
    ;
    final destination = '${ctrl.userInfo.userId}/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      // Uint8List imageData = await File(image!.path).readAsBytes();

      await ref.putFile(image!);
    } catch (e) {
      print('error occured');
    }
  }
}
