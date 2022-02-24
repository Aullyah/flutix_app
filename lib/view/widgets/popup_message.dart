part of 'widgets.dart';

class PopUpMessage extends StatelessWidget {
  final String message;
  const PopUpMessage({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flushbar(
      duration: Duration(milliseconds: 1500),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Color(0xFFFF5C83),
      message: message,
    )..show(context);
  }
}
