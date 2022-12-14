import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/detail_page.dart';
import 'package:movie_app/screens/search_page.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

MovieProvider? movieProvider;

class _HomePageState extends State<HomePage> {
  List<String> newMovies = [
    "assets/spiderman.png",
    "assets/rednotice.png",
    "assets/ttw.png"
  ];
  String path = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/";

  @override
  void initState() {
    super.initState();
    movieProvider = Provider.of<MovieProvider>(context, listen: false);
    apisFunction();
  }

  apisFunction() async {
    await movieProvider!.getPopularMovieData();
    await movieProvider!.getTopRatedMovieData();
    await movieProvider!.getUpComingMovieData();
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
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
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
                  padding: EdgeInsets.only(left: 3.4.h),
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
                        child: Consumer(
                          builder: (context, MovieProvider provider, child) {
                            return TextField(
                              onTap: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => provider
                                            .isLoadingSearch
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : SearchPage(),
                                  ),
                                );
                              },
                              cursorColor: Colors.grey,
                              obscureText: false,
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset("assets/search.png"),
                                  suffixIcon:
                                      Image.asset("assets/microphone.png"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.25.h))),
                                  labelStyle: GoogleFonts.openSans(
                                      color: const Color(0xfffffffff)
                                          .withOpacity(0.5),
                                      fontSize: 2.125.h),
                                  labelText: "Search"),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text("Popular movies",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xfffffffff).withOpacity(0.75),
                              fontSize: 2.125.h)),
                      SizedBox(
                        height: 2.25.h,
                      ),
                      SizedBox(
                        height: 20.h,
                        child: Consumer(
                          builder: (context, MovieProvider provider, child) {
                            return provider.isLoadingPopularMovie
                                ? Center(
                                    child: CircularProgressIndicator(
                                    strokeWidth: 0.375.h,
                                  ))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: provider
                                        .popularMovieResponse?.results?.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  provider.isLoadingPopularMovie
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      0.375))
                                                      : DetailPage(
                                                          id: "${provider.popularMovieResponse?.results?[index].id}"),
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
                                                  BorderRadius.circular(2.5.h),
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://image.tmdb.org/t/p/w600_and_h900_bestv2/$path${provider.popularMovieResponse?.results?[index].posterPath}"),
                                                  fit: BoxFit.fill)),
                                        ),
                                      );
                                    },
                                  );
                          },
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text("Upcoming movies",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xfffffffff).withOpacity(0.75),
                              fontSize: 2.125.h)),
                      SizedBox(
                        height: 2.25.h,
                      ),
                      SizedBox(
                        height: 20.h,
                        child: Consumer(
                          builder: (context, MovieProvider provider, child) {
                            return provider.isLoadingUpComingMovie
                                ? Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 0.375.h))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: provider
                                        .upComingMovieResponse?.results?.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  provider
                                                          .isLoadingUpComingMovie
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      0.375))
                                                      : DetailPage(
                                                          id: '${provider.upComingMovieResponse?.results?[index].id}',
                                                        ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(right: 1.25.h),
                                          width: 18.375.h,
                                          height: 20.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.5.h),
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "$path${provider.upComingMovieResponse?.results?[index].posterPath}"),
                                                  fit: BoxFit.fill)),
                                        ),
                                      );
                                    },
                                  );
                          },
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text("Top rated movies",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xfffffffff).withOpacity(0.75),
                              fontSize: 2.125.h)),
                      SizedBox(
                        height: 2.25.h,
                      ),
                      SizedBox(
                        height: 20.h,
                        child: Consumer(
                          builder: (context, MovieProvider provider, child) {
                            return provider.isLoadingTopRatedMovie
                                ? Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 0.375.h))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: provider
                                        .topRatedMovieResponse?.results?.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>provider.isLoadingTopRatedMovie?Center(child: CircularProgressIndicator(strokeWidth: 0.375)):
                                                  DetailPage(
                                                id: '${provider.topRatedMovieResponse?.results?[index].id}',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(right: 1.25.h),
                                          width: 18.375.h,
                                          height: 20.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.5.h),
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://image.tmdb.org/t/p/w600_and_h900_bestv2/${provider.topRatedMovieResponse?.results?[index].posterPath}"),
                                                  fit: BoxFit.fill)),
                                        ),
                                      );
                                    },
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
