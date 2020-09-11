import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/cubits.dart';
import 'package:flutter_netflix_responsive_ui/screens/screens.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(
      key: PageStorageKey('homeScreen'),
    ),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final Map<String, IconData> _icons = {
    "Inicio": Icons.home,
    "Buscar": Icons.search,
    "Em breve": Icons.queue_play_next,
    "Downloads": Icons.file_download,
    "Mais": Icons.menu,
  };

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBarCubit>(
      create: (_) => AppBarCubit(),
      child: Scaffold(
        body: this._screens[this._currentIndex],
        bottomNavigationBar: !ResponsiveWidget.isDesktop(context)
            ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black54,
                currentIndex: this._currentIndex,
                selectedItemColor: Colors.white,
                selectedFontSize: 11,
                unselectedItemColor: Colors.grey,
                unselectedFontSize: 11,
                onTap: (index) {
                  setState(() {
                    this._currentIndex = index;
                  });
                },
                items: this
                    ._icons
                    .map((title, icon) {
                      return MapEntry(
                        title,
                        BottomNavigationBarItem(
                          icon: Icon(icon, size: 30),
                          title: Text(title),
                        ),
                      );
                    })
                    .values
                    .toList(),
              )
            : null,
      ),
    );
  }
}
