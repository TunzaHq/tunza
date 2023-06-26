import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunza/ui/auth/splash.dart';
import 'package:tunza/ui/home/home_page.dart';
import 'package:tunza/util/globals.dart';
import 'package:tunza/util/constant.dart';
import 'package:tunza/util/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Resources().init();
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with Glob {
  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<bool> checkLogin() async =>
      (await SharedPreferences.getInstance()).getString('token') != null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tunza - Britam',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: FutureBuilder<bool>(
          builder: (context, snapshot) => snapshot.hasData && snapshot.data!
              ? const HomePage()
              : const Splash(),
          future: checkLogin(),
        ));
  }
}
