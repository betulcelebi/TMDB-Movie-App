import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utils/time_converter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../provider/movie_provider.dart';

class DetailPage extends StatefulWidget {
  DetailPage({super.key, this.id});
  final String? id;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

MovieProvider? movieProvider;

class _DetailPageState extends State<DetailPage> {
  String path = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/";
  @override
  void initState() {
    super.initState();
    movieProvider = Provider.of<MovieProvider>(context, listen: false);
    apisFunction();
  }

  apisFunction() async {
    await movieProvider!.getMovieIdData(widget.id);
    await movieProvider!.getCreditIdData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
        actions: [Image.asset("assets/Menu button.png")],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer(
              builder: (context, MovieProvider provider, child) {
                return provider.isLoadingMovieId
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        children: [
                          Image.network(
                            "$path${provider.movieIdResponse?.posterPath}",
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              bottom: 0.h,
                              left: 38.75.h,
                              child: Image.asset("assets/play-button.png")),
                          // Positioned(
                          //   bottom: 16,
                          //   left: 165,
                          //   child: Text(
                          //     "Eternals",
                          //     style: GoogleFonts.openSans(
                          //         color: Color(0xffFFFFFF).withOpacity(0.85),
                          //         fontSize: 17,
                          //         fontWeight: FontWeight.w700),
                          //   ),
                          // ),
                        ],
                      );
              },
            ),
            SizedBox(height: 0.625.h),
            Container(
              // color: Colors.grey,
              width: 36.h,
              height: 18.75.h,
              child: Consumer(
                builder: (context, MovieProvider provider, child) {
                  return provider.isLoadingMovieId
                      ? const Center(child: CircularProgressIndicator())
                      : ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      "${provider.movieIdResponse?.releaseDate?.split(" ").last.substring(0, 4)}",
                                      style: GoogleFonts.openSans(
                                          color: const Color(0xffFFFFFF)
                                              .withOpacity(0.75),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13)),
                                  Image.asset("assets/dot.png"),
                                  Text(
                                      "${provider.movieIdResponse?.genres?[0].name}",
                                      style: GoogleFonts.openSans(
                                          color: const Color(0xffFFFFFF)
                                              .withOpacity(0.75),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13)),
                                  Image.asset("assets/dot.png"),
                                  Text(
                                      TimeConvert().secondToHourAndSecond(
                                          provider.movieIdResponse?.runtime),
                                      style: GoogleFonts.openSans(
                                          color: const Color(0xffFFFFFF)
                                              .withOpacity(0.75),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13)),
                                ],
                              ),
                              RatingBar.builder(
                                glow: true,
                                itemSize: 1.5.h,
                                glowColor: Colors.white,
                                unratedColor: Colors.white,
                                initialRating: provider.movieIdResponse
                                    ?.voteAverage, //oylama sayısı
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 10,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0.375.h),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Color(0xffF2A33A),
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Container(
                                height: 11.25.h,
                                child: Text(
                                    "${provider.movieIdResponse?.overview}",
                                    style: GoogleFonts.openSans(
                                        color: Colors.white.withOpacity(0.75),
                                        fontSize: 2.125.h,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center),
                              )
                            ],
                          ),
                        );
                },
              ),
            ),
            SizedBox(height: 2.375.h),
            Container(
              width: 36.25.h,
              height: 0.25.h,
              color: const Color(0xffFFFFFF).withOpacity(0.15),
            ),
            SizedBox(height: 1.5.h),
            Padding(
              padding: EdgeInsets.only(right: 36.25.h),
              child: Text("Casts",
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 2.5.h,
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: EdgeInsets.all(1.875.h),
              child:
                  Consumer(builder: (context, MovieProvider provider, child) {
                return provider.isLoadingCreditId
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        width: double.infinity,
                        height: 16.25.h,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: provider.creditIdResponse?.cast?.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 0.625.h,
                                  childAspectRatio: 0.325.h,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(0),
                              width: 20.h,
                              height: 7.5.h,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "$path${provider.creditIdResponse?.cast?[index].profilePath}"),
                                    radius: 3.75.h,
                                    backgroundColor: Colors.white,
                                  ),
                                  RotatedBox(
                                    quarterTurns: 1,
                                    child: Arc(
                                        arcType: ArcType.CONVEY,
                                        height: 0.75.h,
                                        child: Container(
                                          width: 6.25.h,
                                          height: 14.4.h,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 69, 69, 69),
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(2.625.h),
                                                  topRight: Radius.circular(
                                                      2.625.h))),
                                          child: RotatedBox(
                                              quarterTurns: -1,
                                              child: ListTile(
                                                //contentPadding: EdgeInsets.all(5 ),
                                                title: Text(
                                                    "${provider.creditIdResponse?.cast?[index].name}",
                                                    style: GoogleFonts.openSans(
                                                        color:
                                                            Color(0xffFFFFFF),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 1.625.h)),
                                              )),
                                        )),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
              }),
            )
          ],
        ),
      ),
    );
  }
}
