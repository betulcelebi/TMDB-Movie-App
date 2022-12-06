import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../provider/movie_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

MovieProvider? movieProvider;

class _SearchPageState extends State<SearchPage> {
  String path = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/";

  @override
  void initState() {
    super.initState();
    movieProvider = Provider.of<MovieProvider>(context, listen: false);
    apisFunction();
  }

  apisFunction() async {
    await movieProvider!.getSearchMovieData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff171719),
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Image.asset(
              "assets/Back button.png",
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: 100.h,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Consumer(
              builder: (context, MovieProvider provider, child) {
                return Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(
                        top: 12.75.h,
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
                                fontSize: 3.5.h,
                                color: Colors.white.withOpacity(0.85)),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    SizedBox(height: 3.h),
                    Padding(
                      padding:  EdgeInsets.only(left: 3.375.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 42.8.h,
                            height: 4.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.25.h),
                                color: const Color(0xff1fffffff)),
                            child: TextField(
                              style: GoogleFonts.openSans(
                                  color:const Color(0xfffffffff)
                                          .withOpacity(0.5),
                                  fontSize: 1.75.h),
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  provider.getQueryData("g");
                                } else {
                                  provider.getQueryData(value);
                                }
                              },
                              cursorColor: Colors.grey,
                              obscureText: false,
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset("assets/search.png"),
                                  suffixIcon:
                                      Image.asset("assets/microphone.png"),
                                  border:  OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.25.h ))),
                                  labelStyle: GoogleFonts.openSans(
                                      color: const Color(0xfffffffff)
                                          .withOpacity(0.5),
                                      fontSize: 2.125.h),
                                  labelText: "Search"),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text("Results movies",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xfffffffff)
                                      .withOpacity(0.75),
                                  fontSize: 2.125.h)),
                           SizedBox(
                            height: 2.25.h,
                          ),
                          SizedBox(
                            height: 20.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  provider.searchMovieResponse?.results?.length,
                              itemBuilder: (context, index) {
                                return provider.isLoadingSearch
                                    ? Center(
                                        child:  CircularProgressIndicator(
                                        strokeWidth: 0.25.h,
                                      ))
                                    : InkWell(
                                        onTap: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  DetailPage(
                                                      id: "${provider.searchMovieResponse?.results?[index].id}"),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin:
                                               EdgeInsets.only(right: 1.25.h),
                                          width: 18.375.h,
                                          height: 22.5.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "$path${provider.searchMovieResponse?.results?[index].posterPath}"),
                                                  fit: BoxFit.fill)),
                                        ),
                                      );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
