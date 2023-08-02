import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/view/home/home_view.dart';

import '/constants/color.dart';

void main() async {
  await Hive.initFlutter();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'PokeApp',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: kPrimaryColor,
              ),
              useMaterial3: true,
            ),
            home: const HomeView(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
