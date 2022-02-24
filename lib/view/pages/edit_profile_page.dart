part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final Users user;
  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController;
  String profilePath;
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Edit Your\nProfile",
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 10),
                        width: 90,
                        height: 104,
                        child: Stack(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: (profileImageFile != null)
                                      ? FileImage(profileImageFile)
                                      : (profilePath != "")
                                          ? NetworkImage(profilePath)
                                          : AssetImage("assets/user_pic.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () async {
                                  if (profilePath == "") {
                                    profileImageFile = await getImage();
                                    if (profileImageFile != null) {
                                      profilePath =
                                          basename(profileImageFile.path);
                                    }
                                  } else {
                                    profileImageFile = null;
                                    profilePath = "";
                                  }
                                },
                                child: Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage((profilePath == "")
                                              ? "assets/btn_add_photo.png"
                                              : "assets/btn_del_photo.png"))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      AbsorbPointer(
                        child: TextField(
                          controller: TextEditingController(
                            text: widget.user.id,
                          ),
                          style: whiteNumberFont.copyWith(color: accentColor3),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'User ID'),
                        ),
                      ),
                      SizedBox(height: 16),
                      AbsorbPointer(
                        child: TextField(
                          controller: TextEditingController(
                            text: widget.user.email,
                          ),
                          style: whiteNumberFont.copyWith(color: accentColor3),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Email Address'),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: nameController,
                        onChanged: (text) {
                          setState(() {
                            isDataEdited = (text.trim() != widget.user.name ||
                                    profilePath != widget.user.profilePicture)
                                ? true
                                : false;
                          });
                        },
                        style: blackTextFont,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Full Name',
                            hintText: 'Full Name'),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 45,
                        width: 250,
                        child: ElevatedButton(
                          onPressed: isUpdating
                              ? null
                              : () async {
                                  await AuthServices.resetPassword(
                                      widget.user.email);
                                  Flushbar(
                                    duration: Duration(milliseconds: 2000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: Color(0xFFFF5C83),
                                    message:
                                        "The link to change your password has been send to your mail",
                                  )..show(context);
                                },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.red[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                MdiIcons.alertCircle,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Change Password",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: isUpdating
                                        ? Color(0xFFBEBEBE)
                                        : Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      isUpdating
                          ? SizedBox(
                              width: 50,
                              height: 50,
                              child: SpinKitFadingCircle(
                                color: Color(0xFF3E9D9D),
                              ),
                            )
                          : SizedBox(
                              width: 250,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: (isDataEdited)
                                    ? () async {
                                        setState(() {
                                          isUpdating = true;
                                        });
                                        if (profileImageFile != null) {
                                          profilePath = await uploadImage(
                                              profileImageFile);
                                        }
                                        context.bloc<UserBloc>().add(UpdateData(
                                            nameController.text, profilePath));
                                        context
                                            .bloc<PageBloc>()
                                            .add(GoToProfilePage());
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Color(0xFF3E9D9D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "Update My Profile",
                                  style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: (isDataEdited)
                                        ? Colors.white
                                        : Color(0xFFBEBEBE),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ],
              ),
            ),
            SafeArea(
                child: Container(
              margin: EdgeInsets.only(top: 20, left: defaultMargin),
              child: GestureDetector(
                  onTap: () {
                    context.bloc<PageBloc>().add(GoToProfilePage());
                  },
                  child: Icon(Icons.arrow_back, color: Colors.black)),
            ))
          ],
        ),
      ),
    );
  }
}
