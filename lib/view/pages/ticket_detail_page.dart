part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage(
            bottomNavBarIndex: 1,
            isExpired: ticket.time.isBefore(DateTime.now())));

        return;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF6F7F9),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToMainPage(
                              bottomNavBarIndex: 1,
                              isExpired: ticket.time.isBefore(DateTime.now())));
                        },
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                    Center(
                      child: Text("Ticket Details",
                          style: blackTextFont.copyWith(fontSize: 20)),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imageBaseUrl +
                              "w500" +
                              ticket.movieDetail.movie.backdropPath),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      )),
                ),
                ClipPath(
                  clipper: TicketTopClipper(),
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket.movieDetail.movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: blackTextFont.copyWith(fontSize: 18),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(ticket.movieDetail.genresAndLanguage,
                            style: greyTextFont.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 6,
                        ),
                        RatingStars(
                          voteAverage: ticket.movieDetail.movie.voteAverage,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Cinema",
                                style: greyTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: Text(
                                ticket.theater.name,
                                style: whiteNumberFont.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date & Time",
                                style: greyTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: Text(
                                "${DateFormat('EEEE').format(ticket.time).toUpperCase().substring(0, 3)} ${DateFormat("dd").format(ticket.time)}, ${DateFormat("HH:mm").format(ticket.time)}",
                                style: whiteNumberFont.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Seat Numbers",
                                style: greyTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: Text(
                                ticket.seatsInString,
                                style: whiteNumberFont.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                                textAlign: ticket.seatsInString.contains(',')
                                    ? TextAlign.end
                                    : TextAlign.start,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order ID",
                                style: greyTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: Text(
                                ticket.bookingCode,
                                style: whiteNumberFont.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        generateDashedDivider(
                            MediaQuery.of(context).size.width -
                                2 * defaultMargin -
                                40),
                      ],
                    ),
                  ),
                ),
                ClipPath(
                  clipper: TicketBottomClipper(),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    color: Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  ticket.name,
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 8),
                                Text("Paid",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id_ID',
                                          symbol: 'IDR ',
                                          decimalDigits: 0)
                                      .format(ticket.totalPrice),
                                  style: whiteNumberFont.copyWith(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                )
                              ]),
                          QrImage(
                            data: ticket.bookingCode,
                            version: 6,
                            foregroundColor: Colors.black,
                            size: 100,
                            padding: EdgeInsets.all(0),
                            errorCorrectionLevel: QrErrorCorrectLevel.M,
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}

class TicketTopClipper extends CustomClipper<Path> {
  double radius = 15;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(radius, size.height - radius, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width - radius, size.height - radius,
        size.width, size.height - radius);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class TicketBottomClipper extends CustomClipper<Path> {
  double radius = 15;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width - radius, radius, size.width - radius, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(radius, radius, 0, radius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
