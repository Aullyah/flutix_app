part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.bloc<TicketBloc>().add(GetTickets(firebaseUser.uid));
        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignPage()
                : (pageState is OnRegistrationPage)
                    ? SignUpPage(
                        registrationData: pageState.registrationData,
                      )
                    : (pageState is OnPreferencePage)
                        ? PreferencePage(
                            registrationData: pageState.registrationData,
                          )
                        : (pageState is OnAccountConfirmationPage)
                            ? AccountConfirmationPage(
                                registrationData: pageState.registrationData,
                              )
                            : (pageState is OnMovieDetailPage)
                                ? MovieDetailPage(pageState.movie)
                                : (pageState is OnSelectSchedulePage)
                                    ? SelectSchedulePage(pageState.movieDetail)
                                    : (pageState is OnSelectSeatPage)
                                        ? SelectSeatPage(pageState.ticket)
                                        : (pageState is OnCheckOutPage)
                                            ? CheckOutPage(pageState.ticket)
                                            : (pageState is OnSuccessPage)
                                                ? SuccessPage(pageState.ticket,
                                                    pageState.transaction)
                                                : (pageState is OnProfilePage)
                                                    ? ProfilePage()
                                                    : (pageState is OnTopUpPage)
                                                        ? TopUpPage(
                                                            pageState.pageEvent)
                                                        : (pageState
                                                                is OnWalletPage)
                                                            ? WalletPage(
                                                                pageState
                                                                    .pageEvent)
                                                            : (pageState
                                                                    is OnTicketDetailPage)
                                                                ? TicketDetailPage(
                                                                    pageState
                                                                        .ticket)
                                                                : (pageState
                                                                        is OnEditProfilePage)
                                                                    ? EditProfilePage(
                                                                        pageState
                                                                            .user)
                                                                    : MainPage());
  }
}
