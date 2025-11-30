import 'package:flutter/material.dart';
import 'package:smarket_app/style/branding_colors.dart';

import 'navigation_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        // the central theme of the app, add further data to access it from the app context
        theme: ThemeData(
          primaryColor: BrandingColors.primaryColor,
          colorScheme: BrandingColors.colorScheme,
          cardTheme: const CardTheme(elevation: 1.5),
          errorColor: BrandingColors.dangerColor,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: BrandingColors.primaryColor,
            ),
            headline2: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: BrandingColors.black),
            subtitle1: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: BrandingColors.grey,
            ),
          ).apply(
            bodyColor: BrandingColors.black,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: BrandingColors.secondaryColor,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              primary: BrandingColors.grey,
              minimumSize: const Size.fromHeight(40),
            ),
          ),
          chipTheme: const ChipThemeData(
            backgroundColor: BrandingColors.grey,
          ),
        ),
        home: const NavigationProvider(title: 'Smarket'),
      ),
    );
  }
}
