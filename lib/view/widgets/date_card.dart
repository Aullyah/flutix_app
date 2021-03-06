part of 'widgets.dart';

class DateCard extends StatelessWidget {
  final bool isSelected;
  final double height;
  final double width;
  final DateTime date;
  final Function onTap;

  const DateCard(this.date,
      {this.isSelected = false, this.height = 90, this.width = 70, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isSelected ? accentColor2 : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.transparent : Color(0xFFE4E4E4),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEEE').format(date).toUpperCase().substring(0, 3),
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 6,
            ),
            Text(date.day.toString(),
                style: whiteNumberFont.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
