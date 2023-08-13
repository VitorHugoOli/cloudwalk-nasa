import 'package:cloudwalknasa/envs/base.dart';
import 'package:cloudwalknasa/services/api.dart';
import 'package:cloudwalknasa/services/audio.dart';
import 'package:cloudwalknasa/src/full/full.dart';
import 'package:cloudwalknasa/src/list/list.dart';
import 'package:cloudwalknasa/src/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool PREVENT_SPLASH = false;

void app(Environments env) {
  WidgetsFlutterBinding.ensureInitialized();
  NasaApi.instance.init(env.NASAAPIKEY);
  AudioManager().clearAndReset(); // Start playing music
  runApp(const NasaGallery());
}

class NasaGallery extends StatelessWidget {
  const NasaGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA Gallery',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        scaffoldBackgroundColor: const Color(0xFF1A237E),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF1A237E),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1A237E),
          selectedItemColor: Colors.white70,
          unselectedItemColor: Colors.white38,
        ),
        // Other theme customization
      ),
      home: !PREVENT_SPLASH ? SplashScreen() : const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   int _selectedIndex = 0;
//   static List<Widget> _widgetOptions = <Widget>[
//     FullViewPage(),
//     ListViewPage(),
//   ];
//
//   late final AnimationController _controller;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   get hideNavigationBar => Future.delayed(const Duration(seconds: 1), () {
//         if (mounted) {
//           _controller.reverse();
//         }
//       });
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _controller.forward(); // Initially, show the navigation bar
//
//     // Hide the navigation bar after 5 seconds
//     hideNavigationBar;
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Show the navigation bar when the body is tapped
//         _controller.forward();
//         hideNavigationBar;
//       },
//       child: Scaffold(
//         key: _scaffoldKey,
//         // appBar: AppBar(),
//         body: _widgetOptions.elementAt(_selectedIndex),
//         bottomNavigationBar: SizeTransition(
//           sizeFactor: _controller,
//           child: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.photo),
//                 label: 'Full View',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.view_list),
//                 label: 'List View',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             selectedItemColor: Colors.white70,
//             onTap: _onItemTapped,
//           ),
//         ),
//       ),
//     );
//   }
// }

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const FullViewPage(),
    const ListViewPage(),
  ];

  late final AnimationController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  get hideNavigationBar => Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          _controller.reverse();
        }
      });

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      value: 1.0, // Initially, show the navigation bar (opacity = 1)
    );

    hideNavigationBar;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        // if drag up

        if (details.localPosition.dx > 100) {
          // Show the navigation bar when the body is tapped
          _controller.forward();
          hideNavigationBar;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            _widgetOptions.elementAt(_selectedIndex),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _controller.value,
                    child: child,
                  );
                },
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.photo),
                      label: 'Full View',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.view_list),
                      label: 'List View',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.white70,
                  onTap: _onItemTapped,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
