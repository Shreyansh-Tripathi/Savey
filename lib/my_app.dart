import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:savey/constants/color_constants.dart';
import 'package:savey/ui/provider/provider.dart';
import 'package:savey/ui/screen/goal_detail_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          ColorConstants.primaryColor, // Change this to the desired color
      statusBarIconBrightness:
          Brightness.light, // Use Brightness.dark for dark icons
    ));
    return  MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        textTheme: ColorConstants.appTextTheme,
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => GoalProvider(),
        lazy: true,
        child: const GoalDetailScreen(),
      ),
    );
  }
}