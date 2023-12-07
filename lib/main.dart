import 'package:filter_app/app/colors/colors.dart';
import 'package:filter_app/app/modules/filter_home/views/filter_home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (contexcontext, orientation, screenTypet) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: bgColor),
          useMaterial3: true,
        ),
        home:  FilterHomeView(),
      );
    });
  }
}
