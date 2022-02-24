part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];
  final List<String> languages = ["Bahasa", "English", "Japanese", "Korean"];
  final RegistrationData registrationData;
  PreferencePage({
    Key key,
    this.registrationData,
  }) : super(key: key);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguage = "English";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = "";
        context
            .bloc<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 56,
                    margin: const EdgeInsets.only(top: 20, bottom: 4),
                    child: InkWell(
                      onTap: () {
                        widget.registrationData.password = "";
                        context
                            .bloc<PageBloc>()
                            .add(GoToRegistrationPage(widget.registrationData));
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Text(
                    "Selected Your Four\nFavorite Genres",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateGenresWidget(context),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Selected Your Four\nFavorite Genres",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLanguageWidget(context),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: FloatingActionButton(
                        onPressed: () {
                          if (selectedGenres.length != 4) {
                            Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: "Please select 4 genres",
                            )..show(context);
                          } else {
                            widget.registrationData.selectedLanguage =
                                selectedLanguage;
                            widget.registrationData.selectedGenres =
                                selectedGenres;
                            context.bloc<PageBloc>().add(
                                GoToAccountConfirmationPage(
                                    widget.registrationData));
                          }
                        },
                        child: Icon(Icons.arrow_forward),
                        elevation: 0,
                        backgroundColor: mainColor),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenresWidget(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;
    return widget.genres
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedGenres.contains(e),
              onTap: () {
                setState(() {
                  onSelectedGenre(e);
                });
              },
            ))
        .toList();
  }

  List<Widget> generateLanguageWidget(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;
    return widget.languages
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedLanguage == e,
              onTap: () {
                selectedLanguage = e;
              },
            ))
        .toList();
  }

  void onSelectedGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
