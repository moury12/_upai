import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';

class FavouriteOfferScreen extends StatelessWidget {
  const FavouriteOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:AppColors.kprimaryColor,foregroundColor: Colors.white,title: Text('Favourite Offer'),),
    );
  }
}
