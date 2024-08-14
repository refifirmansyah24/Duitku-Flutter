import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:tbduitku/constanta.dart';
import 'package:tbduitku/pages/category_page.dart';
import 'package:tbduitku/pages/help_page.dart';
import 'package:tbduitku/pages/home_page.dart';
import 'package:tbduitku/pages/main_page.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Homepage',
          baseStyle: TextStyle(color: kTextColor),
          selectedStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kTextColor,
          ),
        ),
        MainPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Kategori',
          baseStyle: GoogleFonts.poppins(color: kTextColor),
          selectedStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kTextColor,
          ),
        ),
        CategoryPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Bantuan',
          baseStyle: GoogleFonts.poppins(color: kTextColor),
          selectedStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kTextColor,
          ),
        ),
        HelpPage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.blue.shade900,
      backgroundColorAppBar: Colors.blue.shade900,
      contentCornerRadius: 15.0,
      slidePercent: 45.0,
      screens: _pages,
      initPositionSelected: 0,
    );
  }
}
