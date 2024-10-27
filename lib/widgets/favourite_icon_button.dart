import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/helper_function/helper_function.dart';

class FavouriteIconButton extends StatefulWidget {
  final OfferList offerItem;

  const FavouriteIconButton({super.key,required this.offerItem});

  @override
  State<FavouriteIconButton> createState() => _FavouriteIconButtonState();
}

class _FavouriteIconButtonState extends State<FavouriteIconButton> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 30.0, end: 40.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: IconButton(
          highlightColor: Colors.transparent,
          onPressed: () async {
            await _controller.forward();
            await _controller.reverse();

            if (!widget.offerItem.isFav!) {
              widget.offerItem.isFav = true;
              saveOfferToHive(widget.offerItem);
            } else {
              widget.offerItem.isFav = false;
              deleteFavOffers(
                  widget.offerItem.offerId.toString());
              // HomeController.to.favOfferList.refresh();
              // HomeController.to.getOfferList.refresh();
            }
            debugPrint(widget.offerItem.isFav.toString());
            setState(() {});
          },
          icon: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Center(
                  child: Icon(
                    widget.offerItem!.isFav!
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: AppColors.kprimaryColor,
                    size: _animation.value,
                  ),
                );
              })),
    );
  }
}
