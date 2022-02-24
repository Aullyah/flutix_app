part of 'pages.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key key}) : super(key: key);

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isEmailValid = false;
  var isPasswordValid = false;
  var isSignIn = false;
  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 70,
                  child: Image.asset("assets/logo.png"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 70, bottom: 40),
                  child: Text(
                    "Welcome Back,\nExplorer!",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      isEmailValid = EmailValidator.validate(text);
                    });
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Email Address",
                    hintText: "Email Address",
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  obscureText: true,
                  onChanged: (text) {
                    setState(() {
                      isPasswordValid = text.length >= 6;
                    });
                  },
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Password",
                    hintText: "Password",
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text(
                      "Forgot Password? ",
                      style: greyTextFont.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Get Now ",
                      style: purpleTextFont.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(top: 40, bottom: 30),
                    child: isSignIn
                        ? SpinKitFadingCircle(
                            color: mainColor,
                          )
                        : FloatingActionButton(
                            elevation: 0,
                            child: Icon(
                              Icons.arrow_forward,
                              color: isEmailValid && isPasswordValid
                                  ? Colors.white
                                  : Color(0xFFBEBEBE),
                            ),
                            backgroundColor: isEmailValid && isPasswordValid
                                ? mainColor
                                : Color(0xFFE4E4E4),
                            onPressed: isEmailValid && isPasswordValid
                                ? () async {
                                    setState(() {
                                      isSignIn = true;
                                    });
                                    SignInSignUpResult result =
                                        await AuthServices.signIn(
                                            emailController.text,
                                            passwordController.text);
                                    if (result.user == null) {
                                      setState(() {
                                        isSignIn = false;
                                      });
                                      Flushbar(
                                        duration: Duration(seconds: 4),
                                        flushbarPosition: FlushbarPosition.TOP,
                                        backgroundColor: Color(0xFFFF5C83),
                                        message: result.message,
                                      )..show(context);
                                    }
                                  }
                                : () {
                                    setState(() {
                                      isSignIn = false;
                                    });
                                  },
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Start Fresh Now? ",
                      style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Sign Up",
                      style:
                          purpleTextFont.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
