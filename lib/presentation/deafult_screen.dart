import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/Explore/explore_screen.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/Inbox/inbox.dart';
import 'package:upai/presentation/Profile/profile_screen.dart';
import 'package:upai/widgets/custom_bottom_navbar.dart';

class DeafultScreen extends StatefulWidget {
   DeafultScreen({super.key});

  @override
  State<DeafultScreen> createState() => _DeafultScreenState();
}

class _DeafultScreenState extends State<DeafultScreen> {
  final List<Widget> _children = [
    HomeScreen(),
    InboxScreen(),
    ExploreScreen(),
    ProfileScreen()
  ];
   Color selectedColor = Colors.black;
   int _selectedIndex = 0;
   Color unselected = AppColors.appTextColor;
   void _onItemTapped(int index) {
     setState(() {
       _selectedIndex = index;

     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
        unselectedItemColor: AppColors.appTextColor,
        selectedIconTheme: IconThemeData(color: selectedColor),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}
