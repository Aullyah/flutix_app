part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;
  SelectSchedulePage(this.movieDetail);
  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  int selectTime;
  Theater selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToMovieDetailPage(widget.movieDetail.movie));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: accentColor1,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
              ),
            ),
            ListView(
              children: [
                // note: BACK BUTTON
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: defaultMargin, top: 20),
                      padding: EdgeInsets.all(1),
                      child: InkWell(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToMainPage());
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                // note: CHOOSE DATE
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
                  child: Text("Choose Date",
                      style: blackTextFont.copyWith(fontSize: 20)),
                ),
                Container(
                  height: 90,
                  margin: EdgeInsets.only(bottom: 24),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (_, index) => Container(
                            margin: EdgeInsets.only(
                                left: (index == 0) ? defaultMargin : 0,
                                right: (index == dates.length - 1)
                                    ? defaultMargin
                                    : 16),
                            child: DateCard(
                              dates[index],
                              isSelected: selectedDate == dates[index],
                              onTap: () {
                                setState(() {
                                  selectedDate = dates[index];
                                });
                              },
                            ),
                          )),
                ),

                // note: CHOOSE TIME
                generateTimeTable(),

                // note: NEXT BUTTON
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) => FloatingActionButton(
                      onPressed: () {
                        if (isValid) {
                          context.bloc<PageBloc>().add(
                                GoToSelectSeatPage(Ticket(
                                    widget.movieDetail,
                                    selectedTheater,
                                    DateTime(
                                        selectedDate.year,
                                        selectedDate.month,
                                        selectedDate.day,
                                        selectTime),
                                    randomAlphaNumeric(12).toUpperCase(),
                                    null,
                                    name,
                                    null)),
                              );
                        }
                      },
                      backgroundColor:
                          (isValid) ? mainColor : Color(0xFFE4E4E4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: (isValid) ? Colors.white : Color(0xFFBEBEBE),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheater) {
      widgets.add(
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child: Text(
            theater.name,
            style: blackTextFont.copyWith(fontSize: 20),
          ),
        ),
      );
      widgets.add(
        Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 20),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: schedule.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right:
                            (index == dates.length - 1) ? defaultMargin : 16),
                    child: SelectableBox(
                      "${schedule[index]}:00",
                      height: 50,
                      isSelected: selectedTheater == theater &&
                          selectTime == schedule[index],
                      isEnabled: schedule[index] > DateTime.now().hour ||
                          selectedDate.day != DateTime.now().day,
                      onTap: () {
                        setState(() {
                          selectedTheater = theater;
                          selectTime = schedule[index];
                          isValid = true;
                        });
                      },
                    ),
                  );
                })),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
