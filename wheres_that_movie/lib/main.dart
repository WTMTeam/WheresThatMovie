import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service_lister/screens/landing_page/landing.dart';
//import 'package:streaming_service_lister/utils/my_app_theme.dart';
import 'package:streaming_service_lister/utils/my_theme.dart';
import 'package:streaming_service_lister/utils/my_theme_data.dart';
import 'package:streaming_service_lister/utils/provider/dark_theme_provider.dart';
import 'package:streaming_service_lister/utils/services/dark_theme_prefs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

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
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) {
        return themeChangeProvider;
      })
      ],
      child: Consumer<DarkThemeProvider>(
        builder: ((context, themeProvider, child) {
        
        // Change the statusbar color depending on the theme
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarBrightness: themeProvider.getDarkTheme ? Brightness.dark: Brightness.light, // iPhone only
          )
        );

        return MaterialApp(      
          debugShowCheckedModeBanner: false, // removes the little banner in the top
          title: "Hello",
          // theme: MyAppTheme.lightTheme,       
          // darkTheme: MyAppTheme.darkTheme,
          // themeMode: ThemeMode.system,
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: const MyLanding(),      
          //home: const MyLogin(),
        );
      }))
    );

    // Change statusbar color to white
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.dark, // iPhone only
    //   )
    // );

    // return MaterialApp(      
    //   debugShowCheckedModeBanner: false, // removes the little banner in the top
    //   title: "Hello",
    //   theme: MyTheme().buildTheme(), // get the theme from utils/my_theme.dart
      
    //   home: const MyLanding(),
    //   //home: const MyLogin(),
    // );
  } 
}
