import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/home_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    movieTo();
    super.initState();
  }

  movieTo() async {
    await Future.delayed(const Duration(seconds: 15), (() {
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage(),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171719),
      body: Container(
        width: double.infinity,
        height: 100.h,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splash-back.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(top: 110),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const HomePage(),
                      ),
                    );
                  },
                  child: Image.asset("assets/avatar.png")),
              SizedBox(height: 21),
              Container(
                width: 308,
                child: Text(
                  "Watch movies in Virtual Reality",
                  style: GoogleFonts.openSans(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFFFFFF)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 276,
                child: Text("Download and watch offline wherever you are",
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF).withOpacity(0.75)),
                    textAlign: TextAlign.center),
              )
            ],
          ),
        ),
      ),
    );
  }
}
