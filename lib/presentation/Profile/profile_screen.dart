import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/widgets/custom_network_image.dart';
import '../../core/utils/custom_text_style.dart';
import '../../core/utils/image_path.dart';
import '../../widgets/custom_text_field2.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ctrl = ProfileScreenController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _picker = ImagePicker();
  String img = '';
  @override
  void initState() {
    ctrl.canEdit.value = false;
    ctrl.nameTE.text = ctrl.userInfo.value.name ?? '';
    ctrl.emailTE.text = ctrl.userInfo.value.email ?? '';
    ctrl.phoneTE.text = ctrl.userInfo.value.mobile ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(ctrl.canEdit.value.toString());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          "profile".tr,
          style: AppTextStyle.bodyTitle700,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                      Obx(() {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: AppColors.strokeColor, width: 3),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: ctrl.canEdit.value == true && ProfileScreenController.to.image.value != null
                                  ? Image.file(
                                      File(ProfileScreenController.to.image.value!.path),
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : CustomNetworkImage(
                                imgPreview: true,
                                      imageUrl:
                                          ctrl.profileImageUrl.value.isNotEmpty
                                              ? ctrl.profileImageUrl.value
                                              : ImageConstant.senderImg,
                                      height: 150,
                                      width: 150,
                                    )),
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
                              child: Icon(
                                Icons.add_a_photo,
                                color: AppColors.kprimaryColor,
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
                    hintText: ctrl.userInfo.value.userId.toString(),
                    prefixIcon: Icons.call,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField2(
                    isEditable: true,
                    controller: ctrl.nameTE,
                    validatorText: "Please Enter Your Name",
                    hintText: "Enter Your Name",
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField2(
                    isEditable: true,
                    controller: ctrl.emailTE,
                    validatorText: "Please Enter an Email Address",
                    hintText: "Enter an Email Address",
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * .85,
                      child: ElevatedButton(
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {}
                          if (ProfileScreenController.to.image.value != null) {
                            uploadFile();
                          }

                          ProfileScreenController.to.updateProfile(
                              ctrl.nameTE.text, ctrl.emailTE.text);
                          FirebaseAPIs.updateUserDetails(
                              ctrl.nameTE.text, ctrl.emailTE.text);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.kprimaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child:Text("update_profile".tr),
                      ),
                    ),
                  ),
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
      ProfileScreenController.to.image.value = File(pickedFile.path);
      ctrl.canEdit.value = true;

      print('--------------');
      ctrl.update();
    } else {
      ctrl.canEdit.value = false;
      print('//////');
    }
  }

  Future uploadFile() async {
    if (ProfileScreenController.to.image.value == null) return;
    final destination = 'ProfileImages/${ctrl.userInfo.value.userId}/';
    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');

      await ref.putFile(ProfileScreenController.to.image.value!);
      ctrl.fetchProfileImage();
      ctrl.update();
    } catch (e) {
      ctrl.canEdit.value = false;
      print('error occured');
    }
  }
}
