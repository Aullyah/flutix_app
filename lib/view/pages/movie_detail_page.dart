part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits = [];
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: Stack(children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(
            child: Container(color: Colors.white),
          ),
          ListView(
            children: [
              FutureBuilder(
                  future: MovieServices.getDetails(movie),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      movieDetail = snapshot.data;
                    }
                    return Column(
                      children: [
                        Stack(
                          children: [
                            // note: BACKDROP
                            Stack(
                              children: [
                                Container(
                                    height: 270,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(imageBaseUrl +
                                                  "w1280" +
                                                  movie.backdropPath ??
                                              movie.posterPath),
                                          fit: BoxFit.cover),
                                    )),
                                Container(
                                  height: 271,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment(0, 1),
                                          end: Alignment(0, 0.06),
                                          colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0)
                                      ])),
                                ),
                              ],
                            ),
                            // note: BACK ICON
                            Container(
                              margin:
                                  EdgeInsets.only(left: defaultMargin, top: 20),
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black.withOpacity(0.04),
                              ),
                              child: InkWell(
                                onTap: () {
                                  context.bloc<PageBloc>().add(GoToMainPage());
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // note: JUDUL
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: defaultMargin, vertical: 16),
                          child: Text(
                            movie.title,
                            textAlign: TextAlign.center,
                            style: blackTextFont.copyWith(fontSize: 24),
                          ),
                        ),

                        // note: GENRES
                        (snapshot.hasData)
                            ? Text(movieDetail.genresAndLanguage,
                                style: greyTextFont.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ))
                            : SizedBox(),

                        // note: RATING
                        RatingStars(
                          voteAverage: movie.voteAverage,
                          color: accentColor3,
                          alignment: MainAxisAlignment.center,
                        ),

                        // note: CREDITS
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: defaultMargin, bottom: 12),
                            child: Text("Cast & Crew",
                                style: blackTextFont.copyWith(fontSize: 14)),
                          ),
                        ),
                        FutureBuilder(
                            future: MovieServices.getCredits(movie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                credits = snapshot.data;
                                return SizedBox(
                                  height: 115,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: credits.length,
                                      itemBuilder: (_, index) => Container(
                                            margin: EdgeInsets.only(
                                                left: (index == 0)
                                                    ? defaultMargin
                                                    : 0,
                                                right: (index ==
                                                        credits.length - 1)
                                                    ? defaultMargin
                                                    : 16),
                                            child: CreditCard(credits[index]),
                                          )),
                                );
                              } else {
                                return SpinKitFadingCircle(
                                    color: accentColor1, size: 50);
                              }
                            }),

                        // note: STORYLINE
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              defaultMargin, 24, defaultMargin, 8),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Storyline", style: blackTextFont),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              defaultMargin, 0, defaultMargin, 30),
                          child: Text(
                            movie.overview,
                            style: greyTextFont.copyWith(
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        // note: BUTTON
                        ElevatedButton(
                          onPressed: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToSelectSchedulePage(movieDetail));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: mainColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text(
                            "Contineu To Book",
                            style: whiteTextFont.copyWith(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: defaultMargin,
                        ),
                      ],
                    );
                  })
            ],
          ),
        ]),
      ),
    );
  }
}
