part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;
  TopUpPage(this.pageEvent);
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: 'IDR 0');
  int selectAmount = 0;

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    // print(DateFormat("dd MMMM yyyy").format(DateTime.now()));
    // print(DateFormat('EEEE').format(DateTime.now()));
    context.bloc<ThemeBloc>().add(
        ChangeTheme(ThemeData().copyWith(primaryColor: Color(0xFFE4E4E4))));
    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                // note: BACK ARROW
                SafeArea(
                    child: Container(
                  margin: EdgeInsets.only(top: 20, left: defaultMargin),
                  child: GestureDetector(
                    onTap: () {
                      context.bloc<PageBloc>().add(widget.pageEvent);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                )),
                // note: Content
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("Top Up",
                          style: blackTextFont.copyWith(fontSize: 20)),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (text) {
                          String temp = '';

                          setState(() {
                            selectAmount = int.tryParse(temp) ?? 0;
                          });

                          amountController.text = NumberFormat.currency(
                                  locale: 'id_ID',
                                  symbol: 'IDR ',
                                  decimalDigits: 0)
                              .format(selectAmount);
                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: amountController.text.length));
                        },
                        controller: amountController,
                        decoration: InputDecoration(
                          fillColor: Color(0xFFE4E4E4),
                          filled: true,
                          labelStyle: greyTextFont,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Amount",
                        ),
                        readOnly: true,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(top: 30, bottom: 14),
                            child: Text("Choose By Template",
                                style: blackTextFont)),
                      ),
                      Wrap(runSpacing: 14, spacing: 20, children: [
                        makeMoneyCard(amount: 50000, width: cardWidth),
                        makeMoneyCard(amount: 75000, width: cardWidth),
                        makeMoneyCard(amount: 100000, width: cardWidth),
                        makeMoneyCard(amount: 150000, width: cardWidth),
                        makeMoneyCard(amount: 200000, width: cardWidth),
                        makeMoneyCard(amount: 250000, width: cardWidth),
                        makeMoneyCard(amount: 500000, width: cardWidth),
                        makeMoneyCard(amount: 1000000, width: cardWidth),
                        makeMoneyCard(amount: 2000000, width: cardWidth),
                      ]),
                      SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        width: 250,
                        height: 46,
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) => ElevatedButton(
                            onPressed: selectAmount > 0
                                ? () {
                                    context.bloc<PageBloc>().add(GoToSuccessPage(
                                        null,
                                        FlutixTransaction(
                                            userID: (userState as UserLoaded)
                                                .user
                                                .id,
                                            title: "Top Up My Wallet",
                                            amount: selectAmount,
                                            subtitle:
                                                "${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat("dd MMMM yyyy").format(DateTime.now())}",
                                            time: DateTime.now())));
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              primary: Color(0xFF3E9D9D),
                            ),
                            child: Text("Top Up My Wallet"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  MoneyCard makeMoneyCard({int amount, double width}) {
    return MoneyCard(
      amount: amount,
      width: width,
      isSelected: amount == selectAmount,
      onTap: () {
        setState(() {
          if (selectAmount != amount) {
            selectAmount = amount;
          } else {
            selectAmount = 0;
          }

          amountController.text = NumberFormat.currency(
                  locale: 'id_ID', decimalDigits: 0, symbol: 'IDR ')
              .format(selectAmount);
          amountController.selection = TextSelection.fromPosition(
              TextPosition(offset: amountController.text.length));
        });
      },
    );
  }
}
