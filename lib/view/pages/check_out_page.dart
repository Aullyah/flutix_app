part of 'pages.dart';

class CheckOutPage extends StatefulWidget {
  final Ticket ticket;
  CheckOutPage(this.ticket);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    var total = 26500 * widget.ticket.seats.length;
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: accentColor1),
            SafeArea(
                child: Container(
              color: Colors.white,
            )),
            ListView(
              children: [
                Stack(
                  children: [
                    // note: BACK BUTTON
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: defaultMargin, top: 20),
                          padding: EdgeInsets.all(1),
                          child: InkWell(
                            onTap: () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToSelectSeatPage(widget.ticket));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                      Users users = (userState as UserLoaded).user;

                      return Column(
                        children: [
                          // note: PAGE TITLE
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "Checkout\nMovie",
                              style: blackTextFont.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // note: MOVIE DESCRIPTION
                          Row(
                            children: [
                              Container(
                                width: 70,
                                height: 90,
                                margin: EdgeInsets.only(
                                    left: defaultMargin, right: 20),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(imageBaseUrl +
                                          "w342" +
                                          widget.ticket.movieDetail.movie
                                              .posterPath),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        70 -
                                        20,
                                    child: Text(
                                      widget.ticket.movieDetail.movie.title,
                                      style:
                                          blackTextFont.copyWith(fontSize: 18),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        70 -
                                        20,
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: Text(
                                      widget
                                          .ticket.movieDetail.genresAndLanguage,
                                      style: greyTextFont.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  RatingStars(
                                    voteAverage: widget
                                        .ticket.movieDetail.movie.voteAverage,
                                    color: accentColor3,
                                  )
                                ],
                              )
                            ],
                          ),

                          // note: ORDER
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: defaultMargin),
                            child: Divider(
                              color: Color(0xFFE4E4E4),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultMargin,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("ORDER ID",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                  widget.ticket.bookingCode,
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultMargin,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Cinema",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    widget.ticket.theater.name,
                                    textAlign: TextAlign.end,
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultMargin,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date & Time",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                  // widget.ticket.time.day.toString(),
                                  DateFormat('EEEE')
                                      .format(widget.ticket.time)
                                      .toUpperCase()
                                      .substring(0, 3),
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultMargin,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Seat Number",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    widget.ticket.seatsInString,
                                    textAlign: TextAlign.end,
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultMargin,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Price",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                  "IDR 25.000 x ${widget.ticket.seats.length}",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultMargin,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Fee",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                  "IDR 1.500 x ${widget.ticket.seats.length}",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultMargin,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                  NumberFormat.currency(
                                          locale: "id_ID",
                                          decimalDigits: 0,
                                          symbol: "IDR ")
                                      .format(total),
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin, vertical: 20),
                            child: Divider(
                              color: Color(0xFFE4E4E4),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultMargin,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Your Wallet",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                  NumberFormat.currency(
                                          locale: "id_ID",
                                          decimalDigits: 0,
                                          symbol: "IDR ")
                                      .format(users.balance),
                                  style: whiteNumberFont.copyWith(
                                      color: users.balance >= total
                                          ? Color(0xFF3E9D9D)
                                          : Color(0xFFFF5C83),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 46,
                            margin: EdgeInsets.only(top: 36, bottom: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                if (users.balance >= total) {
                                  FlutixTransaction transaction =
                                      FlutixTransaction(
                                          userID: users.id,
                                          title: widget
                                              .ticket.movieDetail.movie.title,
                                          subtitle: widget.ticket.theater.name,
                                          time: DateTime.now(),
                                          amount: -total,
                                          picture: widget.ticket.movieDetail
                                              .movie.posterPath);
                                  context.bloc<PageBloc>().add(GoToSuccessPage(
                                      widget.ticket.copyWith(totalPrice: total),
                                      transaction));
                                } else {}
                              },
                              style: ElevatedButton.styleFrom(
                                primary: users.balance >= total
                                    ? Color(0xFF3E9D9D)
                                    : mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                users.balance >= total
                                    ? "Checkout Now"
                                    : "Top Up My Wallet",
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
