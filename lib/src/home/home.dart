import 'package:cloudwalknasa/src/home/components/list/list.dart';
import 'package:cloudwalknasa/src/home/components/today/today.dart';
import 'package:flutter/material.dart';

import 'components/settings/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const TodayViewPage(),
    const ListViewPage(),
    const SettingsPage(),
  ];

  late final AnimationController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  get hideNavigationBar => Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          _controller.reverse();
        }
      });

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
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
              child: GestureDetector(
                onTap: () {
                  _controller.forward();
                  hideNavigationBar;
                },
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _controller.value,
                      child: child,
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: BottomNavigationBar(
                      elevation: 0,
                      selectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(Icons.photo),
                          label: 'Today',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.photo_library),
                          label: 'List',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.settings),
                          label: 'Settings',
                        ),
                      ],
                      currentIndex: _selectedIndex,
                      selectedItemColor: Colors.white70,
                      onTap: _onItemTapped,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
