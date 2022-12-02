import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_page.dart';
import 'package:movie_app/screens/youtube_page.dart';
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TMDB Movie App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: ""),
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

  final List<Widget> screens = [const HomePage(), YoutubePlayPage()];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff09FACA).withOpacity(0.8), Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          // stops: [0.0, 0.8],
          //tileMode: TileMode.clamp,
        )),
        child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: selectedIndex,
            onTap: onTap,
            animationCurve: Curves.decelerate,
            animationDuration: Duration(milliseconds: 200),
            height: 60,
            color: Colors.transparent,
            buttonBackgroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            items: <Widget>[
              Container(
                padding: EdgeInsets.all(0),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/home.png"))),
                  child: selectedIndex == 0
                      ? Container(width: 150,height: 150,
                        child: Image.asset("assets/ellipse.png",fit: BoxFit.cover))
                      : Container()),
              Image.asset("assets/youtube.png"),
              Image.asset("assets/plus.png"),
              Image.asset("assets/stacked-rectangles.png"),
              Image.asset("assets/arrow-down.png"),
            ]),
      ),
    );
  }
}
