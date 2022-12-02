// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> newMovies = [
    "assets/spiderman.png",
    "assets/rednotice.png",
    "assets/ttw.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff171719),
        body: Container(
          width: double.infinity,
          height: 100.h,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 102,
                ),
                child: Container(
                    alignment: Alignment.center,
                    //color: Colors.amber,
                    width: 30.h,
                    height: 9.5.h,
                    child: Text(
                      "What would you like to watch?",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: Colors.white.withOpacity(0.85)),
                      textAlign: TextAlign.center,
                    )),
              ),
              SizedBox(height: 3.h),
              Padding(
                padding: const EdgeInsets.only(left: 27),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 42.8.h,
                      height: 4.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff1fffffff)),
                      child: TextField(
                        cursorColor: Colors.grey,
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: Image.asset("assets/search.png"),
                            suffixIcon: Image.asset("assets/microphone.png"),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelStyle: GoogleFonts.openSans(
                                color: const Color(0xfffffffff).withOpacity(0.5),
                                fontSize: 17),
                            labelText: "Search"),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text("New movies",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xfffffffff).withOpacity(0.75),
                            fontSize: 17)),
                            SizedBox(height: 18,),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            
                            width: 147,
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: AssetImage(newMovies[index]),fit: BoxFit.cover)),
                          );
                        },
                      ),
                    ),
                          SizedBox(height: 3.h),
                    Text("Upcoming movies",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xfffffffff).withOpacity(0.75),
                            fontSize: 17)),
                            SizedBox(height: 18,),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            
                            width: 147,
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: AssetImage(newMovies[index]),fit: BoxFit.cover)),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
