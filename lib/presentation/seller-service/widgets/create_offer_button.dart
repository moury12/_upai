import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/create-offer/create_offer_screen.dart';

class CreateOfferButton extends StatefulWidget {
  const CreateOfferButton({
    super.key,
  });

  @override
  State<CreateOfferButton> createState() => _CreateOfferButtonState();
}

class _CreateOfferButtonState extends State<CreateOfferButton>
    with TickerProviderStateMixin {
  late AnimationController mainController;
  late AnimationController backgroundController;
  late Animation<double> mainSizeAnimation;
  late Animation<double> backgroundSizeAnimation;
  late Animation<double> backgroundOpacityAnimation;
  late Animation<double> textBoldAnimation;
  @override
  void initState() {
    mainController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    backgroundController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    mainSizeAnimation = Tween<double>(begin: 40, end: 32).animate(
        CurvedAnimation(parent: mainController, curve: Curves.easeInOut));
    backgroundSizeAnimation = Tween<double>(begin: 32, end: 80).animate(
        CurvedAnimation(parent: backgroundController, curve: Curves.easeInOut));
    backgroundOpacityAnimation = Tween<double>(begin: .5, end: 0).animate(
        CurvedAnimation(parent: backgroundController, curve: Curves.easeInOut));
    textBoldAnimation = Tween<double>(begin: 0.3, end: 1.3).animate(
        CurvedAnimation(parent: mainController, curve: Curves.easeInOut));
    mainSizeAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          mainController.stop();

          backgroundController.forward(from: 0);
        }
      },
    );
    backgroundController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          backgroundController.reset();
          mainController.reset();

          mainController.forward();
        }
      },
    );
    mainController.forward();
    super.initState();
  }

  @override
  void dispose() {
    mainController.dispose();
    backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(

        hoverColor: AppColors.kprimaryColor,
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        onPressed: () {
          Get.toNamed(CreateOfferScreen.routeName);
        },
        child: AnimatedBuilder(
          animation: Listenable.merge([mainController, backgroundController]),
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: backgroundOpacityAnimation.value,
                  child: Container(
                    width: backgroundSizeAnimation.value,
                    height: backgroundSizeAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kprimaryColor,
                    ),
                  ),
                ),
                Container(
                  width: mainSizeAnimation.value,
                  height: mainSizeAnimation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kprimaryColor,
                  ),
                  child: Center(
                    child: Text(
                      '+',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 25,
                        height: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.lerp(FontWeight.w900,
                            FontWeight.w500, textBoldAnimation.value),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
