import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wheres_that_movie/screens/logged_in/logged_in.dart';
import 'package:wheres_that_movie/utils/my_theme_data.dart';
import 'package:wheres_that_movie/utils/provider/dark_theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// check this out https://www.youtube.com/watch?v=JkZnP1H0E6E
// and this https://github.com/YOUSSSOF/Movies-App?ref=flutterawesome.com
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return themeChangeProvider;
          })
        ],
        child: Consumer<DarkThemeProvider>(
            builder: ((context, themeProvider, child) {
          // Change the statusbar color depending on the theme
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarBrightness: themeProvider.getDarkTheme
                ? Brightness.dark
                : Brightness.light, // iPhone only
          ));

          return GetMaterialApp(
            debugShowCheckedModeBanner:
                false, // removes the little banner in the top
            title: "Where's That Movie",

            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const MyLoggedIn(),
            //home: const MyLogin(),
          );
        })));
  }
}
