import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_ui/Screens/nav_screen.dart';
import 'package:flutter_youtube_ui/Screens/video_details.dart';
import './Screens/nav_screen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'Screens/library_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter YouTube UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
      ),
      home: EasySplashScreen(
        logo: Image.asset('assets/yt_logo_dark.png'),
        logoSize: 75,
        navigator: NavScreen(),
        backgroundColor: Colors.black12,
        durationInSeconds: 3,
        showLoader: false,
      ),
      routes: {
        VideoDetails.id: (context) => VideoDetails(),
      },
    );
  }
}
