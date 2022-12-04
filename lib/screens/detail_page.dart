import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/movie_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});
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
                    ? Center(child: CircularProgressIndicator())
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
            SizedBox(height: 5),
            Container(
              // color: Colors.grey,
              width: 290,
              height: 150,
              child: Consumer(
                builder: (context, MovieProvider provider, child) {
                  return provider.isLoadingMovieId
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("2021",
                                    style: TextStyle(color: Colors.white)),
                                Image.asset("assets/dot.png"),
                                Text("Action-Adventure-Fantasy",
                                    style: TextStyle(color: Colors.white)),
                                Image.asset("assets/dot.png"),
                                Text("2h36m",
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF)
                                            .withOpacity(0.75))),
                              ],
                            ),
                            RatingBar.builder(
                              glow: true,
                              itemSize: 15,
                              glowColor: Colors.white,
                              unratedColor: Colors.white,
                              initialRating: 3, //oylama sayısı
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 3.0),
                              itemBuilder: (context, _) => Icon(
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
                                overflow: TextOverflow.clip,
                                "${provider.movieIdResponse?.overview}",
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        );
                },
              ),
            ),
            SizedBox(height: 19),
            Container(
              width: 290,
              height: 2,
              color: Color(0xffFFFFFF).withOpacity(0.15),
            ),
            SizedBox(height: 12),
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
                  padding: EdgeInsets.all(0),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      childAspectRatio: 2.6,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(0),
                      width: 159,
                      height: 60,
                      child: Row(
                        children: [
                          CircleAvatar(
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
                                  width: 50,
                                  height: 115,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 69, 69, 69),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(21),
                                          topRight: Radius.circular(21))),
                                )),
                          )
                        ],
                      ),
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
