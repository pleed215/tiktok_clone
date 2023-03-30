import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_configuration/video_config.dart';
import 'package:tiktok_clone/router.dart';

import 'constants/sizes.dart';
import "generated/l10n.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (context) => VideoConfig(),
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VideoConfig(),
        ),
      ],
      builder: (context, child) => MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
        localizationsDelegates: const [
          S.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: true,
        themeMode: context.watch<VideoConfig>().isDarkMode
            ? ThemeMode.dark
            : ThemeMode.system,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          textTheme: Typography.blackCupertino,
          brightness: Brightness.light,
          primaryColor: const Color(0xFFe9435A),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade100,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: Color(0xFFe9435A),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size20,
              color: Colors.black,
            ),
          ),
        ),
        darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.grey.shade900,
          ),
          brightness: Brightness.dark,
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: Color(0xFFe9435A),
          ),
          textTheme: Typography.whiteMountainView,
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.black,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          ),
          primaryColor: const Color(0xFFe9435A),
        ),
      ),
    );
  }
}
