part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // note: HEADER
        Container(
          padding:
              const EdgeInsets.fromLTRB(defaultMargin, 44, defaultMargin, 30),
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                if (imageToUpload != null) {
                  uploadImage(imageToUpload).then((downloadUrl) {
                    imageToUpload = null;
                  });
                }
                name = userState.user.name;
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.bloc<PageBloc>().add(GoToProfilePage());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Color(0xFF5F558B), width: 1)),
                        child: Stack(
                          children: [
                            SpinKitFadingCircle(color: accentColor2, size: 50),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: (userState.user.profilePicture == "")
                                      ? AssetImage("assets/user_pic.png")
                                      : NetworkImage(
                                          userState.user.profilePicture),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              78,
                          child: Text(
                            userState.user.name,
                            style: whiteTextFont.copyWith(fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToWalletPage(GoToMainPage()));
                          },
                          child: Text(
                            NumberFormat.currency(
                                    locale: "id_ID",
                                    decimalDigits: 0,
                                    symbol: "IDR ")
                                .format(userState.user.balance),
                            style: yellowNumberFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return SpinKitFadingCircle(
                  color: accentColor2,
                  size: 50,
                );
              }
            },
          ),
        ),

        // note: NOW PLAYING
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Now Playing",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies.sublist(0, 10);
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (_, index) => Container(
                          margin: EdgeInsets.only(
                              left: (index == 0) ? defaultMargin : 0,
                              right: (index == movies.length - 1)
                                  ? defaultMargin
                                  : 16),
                          child: MovieCard(
                            movie: movies[index],
                            onTap: () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToMovieDetailPage(movies[index]));
                            },
                          ),
                        ));
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            },
          ),
        ),

        // note: BROWSE MOVIE
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Browse Movie",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
        //   if (userState is UserLoaded) {
        //     return Container(
        //       margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        //       child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: List.generate(
        //               userState.user.selectedGenres.length,
        //               (index) =>
        //                   BrowseButton(userState.user.selectedGenres[index]))),
        //     );
        //   } else {
        //     return SpinKitFadingCircle(color: mainColor, size: 50);
        //   }
        // }),

        // note: COMING SOON
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Coming Soon",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies.sublist(10);
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (_, index) => Container(
                          margin: EdgeInsets.only(
                              left: (index == 0) ? defaultMargin : 0,
                              right: (index == movies.length - 1)
                                  ? defaultMargin
                                  : 16),
                          child: ComingSoonCard(
                            movie: movies[index],
                          ),
                        ));
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            },
          ),
        ),

        // note: GET LUCKY DAY
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Get Lucky Day",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        Column(
          children: dummyPromos
              .map(
                (e) => Padding(
                    padding: EdgeInsets.fromLTRB(
                        defaultMargin, 0, defaultMargin, 16),
                    child: PromoCard(e)),
              )
              .toList(),
        ),

        SizedBox(height: 100),
      ],
    );
  }
}
