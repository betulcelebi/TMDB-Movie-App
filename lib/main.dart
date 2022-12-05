import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/detail_page.dart';
import 'package:movie_app/screens/home_page.dart';
import 'package:movie_app/screens/search_page.dart';
import 'package:movie_app/screens/splash_page.dart';

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<MovieProvider>(
              create: (context) => MovieProvider(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TMDB Movie App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(title: ""),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  onTap(index) {
    setState(() {
      selectedIndex = index;
      print(index);
    });
  }

  final List<Widget> screens = [const HomePage()];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: selectedIndex,
          onTap: onTap,
          animationDuration: const Duration(milliseconds: 250),
          height: 60,
          letIndexChange: (value) => true,
          color: Colors.black87.withOpacity(0.2),
          buttonBackgroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          items: <Widget>[
            Container(
                width: 50,
                height: 50,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                        image: AssetImage("assets/home.png"))),
                child: selectedIndex == 0
                    ? Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xffFF35B8).withOpacity(0.2),
                              const Color(0xff09FACA).withOpacity(0.2)
                            ]),
                            shape: BoxShape.circle,
                            border: const GradientBoxBorder(
                                gradient: LinearGradient(colors: [
                                  Color(0xffFF35B8),
                                  Color(0xff09FACA)
                                ]),
                                width: 3)),
                      )
                    : Container()),
            Container(
                width: 50,
                height: 50,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage("assets/youtube.png"))),
                child: selectedIndex == 1
                    ? Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xffFF35B8).withOpacity(0.2),
                              const Color(0xff09FACA).withOpacity(0.2)
                            ]),
                            shape: BoxShape.circle,
                            border: const GradientBoxBorder(
                                gradient: LinearGradient(colors: [
                                  Color(0xffFF35B8),
                                  Color(0xff09FACA)
                                ]),
                                width: 3)),
                      )
                    : Container()),
            Image.asset("assets/plus.png"),
            Image.asset("assets/stacked-rectangles.png"),
            Image.asset("assets/arrow-down.png"),
          ]),
    );
  }
}
