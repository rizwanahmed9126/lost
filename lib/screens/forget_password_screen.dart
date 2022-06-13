import 'package:flutter/material.dart';
import 'package:lost_tracking/services/analytics_services.dart';
import 'package:lost_tracking/services/firebase_service.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/services/util_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:relative_scale/relative_scale.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  NavigationService? _navigationService = locator<NavigationService>();
  UtilService? _util = locator<UtilService>();
  FirebaseService? _firebaseService = locator<FirebaseService>();
  // AnalyticService? analyticService = locator<AnalyticService>();
  var navigationService = locator<NavigationService>();
  TextEditingController emailController = TextEditingController();
  var isLoadingProgress = false;
  @override
  void initState() {
    super.initState();
    // analyticService!.setCurrentScreen('ForgetPasswordScreen');
  }

  @override
  void dispose() {
    _navigationService!.closeScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Stack(
          children: [
            WillPopScope(
              onWillPop: () => navigationService
                  .navigateTo(LoginScreenRoute)
                  .then((value) => value as bool),
              child: AbsorbPointer(
                absorbing: isLoadingProgress,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  // resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () =>
                          navigationService.navigateTo(LoginScreenRoute),
                      icon: Icon(Icons.arrow_back),
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.transparent,
                    toolbarHeight: sy(30),
                    elevation: 0,
                  ),
                  body: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container(
                            //   height: ScreenUtil().setHeight(100),
                            // ),
                            SizedBox(
                              height: sy(50),
                            ),
                            Center(
                              child: Container(
                                height: sy(120),
                                width: sy(120),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                ),
                              ),
                            ),
                            SizedBox(height: sy(0)),
                            Container(
                              margin: EdgeInsets.all(sy(20)),
                              child: Column(children: [
                                Text(
                                  "Forget Password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: sy(13),
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: sy(3)),
                                Container(
                                    width: sx(30),
                                    height: sy(1),
                                    color: Colors.grey[400]),
                                SizedBox(height: sy(12)),
                                Form(
                                    key: _formKey,
                                    // autovalidate: _autoValidate,
                                    child: Column(children: <Widget>[
                                      Container(
                                        width: sx(500),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: emailController,
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .accentColor)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey)),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 20),
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                            hintText: 'Email Address',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: sy(11),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: sy(10),
                                      ),
                                    ])),
                                Container(
                                  height: sy(5),
                                ),
                                Text(
                                  'A message will be sent to your email address\nwith further intructions',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: sy(9),
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: sy(10)),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Container(
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                      highlightElevation: 3.0,
                                      elevation: 3.0,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(sx(80.0))),
                                      padding: EdgeInsets.all(0.0),
                                      child: InkWell(
                                        onTap: () async {
                                          if (emailController.text.isEmpty) {
                                            _util!.showToast(
                                              "Email cannot be empty",
                                              // "Email cannot be empty"
                                            );
                                          } else if (!emailController.text
                                              .contains("@")) {
                                            _util!.showToast(
                                              "Email format is incorrect.",
                                              // "Email format is incorrect."
                                            );
                                          } else {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            await _firebaseService!
                                                .forgotPassword(
                                                    emailController.text);
                                            _navigationService!
                                                .navigateTo(LoginScreenRoute);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .accentColor),
                                          constraints: BoxConstraints(
                                              maxWidth: sy(290),
                                              minHeight: sy(35)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "RECOVER PASSWORD",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: sy(11),
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ])),
                ),
              ),
            ),
            if (isLoadingProgress == true)
              Positioned(
                  child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ))
          ],
        );
      },
    );
  }
}
