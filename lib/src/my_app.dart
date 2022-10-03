import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:slinfy_crm_admin/src/bloc_native.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialRoute: "/",
      theme: ThemeData.light(
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      home: const BlocNative(),
    );
  }
}
