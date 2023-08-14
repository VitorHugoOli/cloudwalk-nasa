import 'dart:io';

import 'package:cloudwalknasa/components/full.dart';
import 'package:cloudwalknasa/envs/base.dart';
import 'package:cloudwalknasa/services/api.dart';
import 'package:cloudwalknasa/providers/audio.dart';
import 'package:cloudwalknasa/src/home/components/tutorial.dart';
import 'package:cloudwalknasa/src/home/home.dart';
import 'package:cloudwalknasa/src/splash/splash.dart';
import 'package:cloudwalknasa/components/starry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void app(Environments env) {
  WidgetsFlutterBinding.ensureInitialized();

  // Solve the error: "Handshake error in client"
  HttpOverrides.global = MyHttpOverrides();

  NasaApi.instance.init(env.NASAAPIKEY);
  AudioManager().init();
  runApp(const NasaGallery());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NasaGallery extends StatefulWidget {
  const NasaGallery({super.key});

  @override
  State<NasaGallery> createState() => _NasaGalleryState();
}

class _NasaGalleryState extends State<NasaGallery> with WidgetsBindingObserver {
  bool? isShowingSplash;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SharedPreferences.getInstance().then((prefs) async {
      isShowingSplash = prefs.getBool('isShowingSplash');
      setState(() => isShowingSplash ??= true);

      if (isShowingSplash!) {
        prefs.setBool('isShowingSplash', false);
        await Future.delayed(const Duration(seconds: 8)).then((_) {
          setState(() => isShowingSplash = false);
        });
      }
      bool? isShowingTutorial = prefs.getBool('isShowingTutorial');
      isShowingTutorial ??= true;
      if (isShowingTutorial) {
        prefs.setBool('isShowingTutorial', false);
        Tutorial.show();
      }
    });
  }

  get home {
    switch (isShowingSplash) {
      // we could use a enum instead of bool
      case true:
        return const SplashScreen();
      case false:
        return const HomePage();
      default:
        return const Scaffold();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA Gallery',
      navigatorKey: navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      routes: {
        '/fullView': (context) => FullView(
              apod: (ModalRoute.of(context)!.settings.arguments as FullViewArgs)
                  .apod,
              hasBackButton:
                  (ModalRoute.of(context)!.settings.arguments as FullViewArgs)
                      .hasBackButton,
            ),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0b3d91),
        ),
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          color: Color(0xFF0b3d91),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF0b3d91),
          selectedItemColor: Colors.white70,
          unselectedItemColor: Colors.white38,
        ),
        expansionTileTheme: const ExpansionTileThemeData(
          iconColor: Colors.white70,
          textColor: Colors.white,
          collapsedTextColor: Colors.white,
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          iconColor: Colors.white70,
        ),
        searchBarTheme: SearchBarThemeData(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF3E63A4)),
          textStyle:
              MaterialStateProperty.all(const TextStyle(color: Colors.white)),
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(const Color(0xFF3E63A4)),
          trackColor: MaterialStateProperty.all(const Color(0xFF0b3d91)),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      home: StarryBackground(child: home),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        AudioManager().resume();
        break;
      case AppLifecycleState.detached:
        AudioManager().stop();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      default:
        AudioManager().pause();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
