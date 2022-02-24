part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;

  const MovieCard({Key key, this.movie, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        height: 140,
        width: 210,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(imageBaseUrl + "w780" + movie.backdropPath),
                fit: BoxFit.cover)),
        child: Container(
          height: 140,
          width: 210,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Colors.black.withOpacity(.61),
              Colors.black.withOpacity(0)
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: whiteTextFont,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              RatingStars(
                voteAverage: movie.voteAverage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
