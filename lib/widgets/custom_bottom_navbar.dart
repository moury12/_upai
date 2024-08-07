import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upai/core/utils/app_colors.dart';


class CustomBottomNavbar extends StatefulWidget {
   const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  Color selectedColor = Colors.black;

  int _selectedIndex = 0;

  Color unselected = AppColors.appTextColorGrey;

   void _onItemTapped(int index) {
     setState(() {
       _selectedIndex = index;

     });
   }
   @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,

      items: <BottomNavigationBarItem>[

        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/home.svg',color:_selectedIndex==0? selectedColor:unselected,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/inbox.svg',color: _selectedIndex==1? selectedColor:unselected,),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/explore.svg',color: _selectedIndex==2? selectedColor:unselected,),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/person.svg',color: _selectedIndex==3? selectedColor:unselected,),
          label: 'Person',
        ),
      ],
      selectedItemColor: Colors.black,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedItemColor: AppColors.appTextColorGrey,
      selectedIconTheme: IconThemeData(color: selectedColor),
      currentIndex: _selectedIndex,
       onTap: _onItemTapped,

      showUnselectedLabels: true,
    );
  }
}
