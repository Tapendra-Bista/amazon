import 'package:flutter/material.dart';

class Globalvariable {
  static var discount = 99;
  static var itemindex = 11;
// colors
  static const appbargradient = LinearGradient(colors: [
    Color.fromARGB(255, 29, 201, 192),
    Color.fromARGB(255, 125, 221, 216)
  ], stops: [
    0.5,
    1.0
  ]);
  static const appbarclr = appbargradient;
  static const secondarycolor = Color.fromRGBO(255, 153, 0, 1);
  static final backgroundcolor = Colors.white.withOpacity(0.92);
  static const greybackgroundcolor = Color(0xffebecee);
  static var selectednavbarcolor = Colors.cyan[800]!;
  static const unselectednavbarcolor = Colors.black87;

// theme for app

  static ThemeData mytheme = ThemeData(
      colorScheme: const ColorScheme.light(),
      primaryColor: Globalvariable.secondarycolor,
      scaffoldBackgroundColor: Globalvariable.backgroundcolor,
      appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          )));

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'image/Mobiles.jpg',
    },
    {
      'title': 'Electronics',
      'image': 'image/electronics.jpg',
    },
    {
      'title': 'Fashion',
      'image': 'image/fashion.jpg',
    },
    {
      'title': 'Home',
      'image': 'image/home.jpeg',
    },
    {
      'title': 'Mini tv',
      'image': 'image/minitv.jpg',
    },
    {
      'title': 'Deals',
      'image': 'image/deals.jpg',
    },
    {
      'title': 'Beauty',
      'image': 'image/beauty.jpeg',
    },
    {
      'title': 'Books',
      'image': 'image/Books.jpg',
    },
    {
      'title': 'Appliances',
      'image': 'image/appliances.jpg',
    },
    {
      'title': 'Grocery',
      'image': 'image/Grocery.jpg',
    },
    {
      'title': 'Essentials',
      'image': 'image/Essentials.jpg',
    },
  ];
}
