import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utils/time_converter.dart';
import 'package:provider/provider.dart';

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
                              bottom: 0,
                              left: 310,
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
            const SizedBox(height: 5),
            Container(
              // color: Colors.grey,
              width: 290,
              height: 150,
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
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  Image.asset("assets/dot.png"),
                                  Text(
                                      "${provider.movieIdResponse?.genres?[0].name} - ${provider.movieIdResponse?.genres?[1].name}",
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  Image.asset("assets/dot.png"),
                                  Text(
                                      TimeConvert().secondToHourAndSecond(
                                          provider.movieIdResponse?.runtime),
                                      style: TextStyle(
                                          color: const Color(0xffFFFFFF)
                                              .withOpacity(0.75))),
                                ],
                              ),
                              RatingBar.builder(
                                glow: true,
                                itemSize: 12,
                                glowColor: Colors.white,
                                unratedColor: Colors.white,
                                initialRating: provider.movieIdResponse
                                    ?.voteAverage, //oylama sayısı
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 10,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Color(0xffF2A33A),
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Container(
                                height: 90,
                                child: Text(
                                  "${provider.movieIdResponse?.overview}",
                                  style: GoogleFonts.openSans(
                                      color: Colors.white.withOpacity(0.75),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        );
                },
              ),
            ),
            const SizedBox(height: 19),
            Container(
              width: 290,
              height: 2,
              color: const Color(0xffFFFFFF).withOpacity(0.15),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 290),
              child: Text("Casts",
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: double.infinity,
                height: 130,
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      childAspectRatio: 2.6,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Consumer(
                      builder: (context, MovieProvider provider, child) {
                        return provider.isLoadingCreditId
                            ? Center(child: CircularProgressIndicator())
                            : Container(
                                padding: const EdgeInsets.all(0),
                                width: 159,
                                height: 60,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "$path${provider.creditIdResponse?.cast?[index].profilePath}"),
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                    ),
                                    RotatedBox(
                                      quarterTurns: 1,
                                      child: Arc(
                                          arcType: ArcType.CONVEY,
                                          height: 6,

                                          //clipShadows: [ClipShadow(color: Colors.white)],
                                          child: Container(
                                            margin: EdgeInsets.all(0),
                                            width: 50,
                                            height: 115,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 69, 69, 69),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(21),
                                                    topRight:
                                                        Radius.circular(21))),
                                            child: RotatedBox(
                                                quarterTurns: -1,
                                                child: ListTile(
                                                  //contentPadding: EdgeInsets.all(5 ),
                                                  title: Text(
                                                      "${provider.creditIdResponse?.cast?[index].name}",
                                                      style:
                                                          GoogleFonts.openSans(
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13)),
                                                )),
                                          )),
                                    )
                                  ],
                                ),
                              );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
