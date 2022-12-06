import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/main.dart';
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
    await Future.delayed(const Duration(seconds: 3), (() {
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const MyHomePage(title: '',),
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
          padding:  EdgeInsets.only(top: 13.75.h),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const MyHomePage(title: '',),
                      ),
                    );
                  },
                  child: Image.asset("assets/avatar.png")),
              SizedBox(height: 2.625.h),
              Container(
                width: 38.5.h,
                child: Text(
                  "Watch movies in Virtual Reality",
                  style: GoogleFonts.openSans(
                      fontSize: 4.25.h,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFFFFFF)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 3.75.h),
              Container(
                width: 34.5.h,
                child: Text("Download and watch offline wherever you are",
                    style: GoogleFonts.openSans(
                        fontSize: 2.h,
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
