import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/services/storage_service.dart';
import 'package:lost_tracking/services/util_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:lost_tracking/widget/android_button_widget.dart';
import 'package:lost_tracking/widget/column_scroll_view.dart';
import 'package:lost_tracking/widget/ios_button_widget.dart';
import 'package:provider/provider.dart';

import 'package:relative_scale/relative_scale.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _sel = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  var navigationService = locator<NavigationService>();
  var storageService = locator<StorageService>();
  var dataIsremember = false;

  @override
  void dispose() {
    navigationService.closeScreen();
    super.dispose();
  }

  String validateemail(String? value) {
    RegExp regex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value!))
      return 'Enter valid email';
    else
      return '';
  }

  String validatePassword(String? value) {
    if (value!.length < 8) {
      return 'Password must be of 8 characters';
    } else
      return "";
  }

  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _showPassword = false;
  var isLoadingProgress = false;
  var utilService = locator<UtilService>();

  loadData() async {
    var data = await this.storageService.haveBoolData('isRemember');
    if (data) {
      dataIsremember = await this.storageService.getBoolData('isRemember');
      if (dataIsremember) {
        var userEmail = await this.storageService.getData("userEmail");
        var password = await this.storageService.getData("password");

        passController.text = password ?? "";
        emailController.text = userEmail ?? "";
      }
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return WillPopScope(
          onWillPop: () => navigationService
              .navigateTo(SignUpScreenRoute)
              .then((value) => value as bool),
          child: AbsorbPointer(
            absorbing: isLoadingProgress,
            child: Scaffold(
                backgroundColor: Colors.white,
                // resizeToAvoidBottomInset: true,
                // appBar: AppBar(
                //   leading: IconButton(
                //     onPressed: () {},
                //     icon: Icon(Icons.arrow_back),
                //     color: Colors.grey,
                //   ),
                //   backgroundColor: Colors.transparent,
                //   elevation: 0,
                //   toolbarHeight: sy(30),
                // ),
                body: Stack(children: [
                  ColumnScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: sy(10),
                              ),
                              Container(
                                height: sy(120),
                                width: sy(120),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                ),
                              ),
                              SizedBox(height: sy(0)),
                              Container(
                                margin: EdgeInsets.only(
                                    left: sx(35), right: sx(35), bottom: sy(5)),
                                child: Column(children: [
                                  Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: sy(15),
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
                                          width: sx(440),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller: emailController,
                                            validator: validateemail,
                                            autocorrect: true,
                                            decoration: InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Theme.of(
                                                                  context)
                                                              .accentColor)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey)),
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 20),
                                              prefixIcon: Icon(
                                                Icons.person,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                              hintText: 'Email Address',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: sy(9),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: sy(10),
                                        ),
                                        Container(
                                          width: sx(440),
                                          child: TextFormField(
                                            controller: passController,
                                            obscureText: !_showPassword,
                                            validator: validatePassword,
                                            autocorrect: true,
                                            decoration: InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Theme.of(
                                                                  context)
                                                              .accentColor)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey)),
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 20),
                                              prefixIcon: Icon(
                                                Icons.lock,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                              hintText: 'Password',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: sy(9),
                                                  fontWeight: FontWeight.w500),
                                              suffixIcon: !_showPassword
                                                  ? IconButton(
                                                      icon: Icon(
                                                        Icons.visibility_off,
                                                        size: sy(12),
                                                        color: Colors.grey,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _showPassword = true;
                                                        });
                                                      },
                                                    )
                                                  : IconButton(
                                                      icon: Icon(
                                                        Icons.visibility,
                                                        size: sy(12),
                                                        color: Colors.grey,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _showPassword = false;
                                                        });
                                                      },
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ])),
                                  Container(
                                    width: sx(440),
                                    padding: EdgeInsets.all(0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                              width: sx(30),
                                              child: Theme(
                                                data: ThemeData(
                                                  unselectedWidgetColor:
                                                      Colors.grey[400],
                                                ),
                                                child: Checkbox(
                                                  activeColor: Colors.blue,
                                                  value: _sel,
                                                  onChanged:
                                                      (bool? resp) async {
                                                    setState(() {
                                                      _sel = resp!;
                                                    });
                                                    await Provider.of<
                                                                AuthProvider>(
                                                            context,
                                                            listen: false)
                                                        .setIsRemeber(resp!);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ' Remember',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: sy(9),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              navigationService.navigateTo(
                                                  ForgetPasswordScreenRoute);
                                            },
                                            child: Text(
                                              "Forget Password",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: sy(9),
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: sy(5),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Container(
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                        highlightElevation: 3.0,
                                        elevation: 3.0,
                                        onPressed: () async {},
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                sx(80.0))),
                                        padding: EdgeInsets.all(0.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              setState(() {
                                                isLoadingProgress = true;
                                              });

                                              if (emailController.text == '' ||
                                                  passController.text == '') {
                                                utilService.showToast(
                                                    "Please fill all fields");
                                                setState(() {
                                                  isLoadingProgress = false;
                                                });
                                                return;
                                              } else if (!emailController.text
                                                      .contains("@") ||
                                                  !emailController.text
                                                      .contains(".com")) {
                                                setState(() {
                                                  isLoadingProgress = false;
                                                });
                                                return;
                                              } else {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                await Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .signinWithEmailAndPassword(
                                                        emailController.text,
                                                        passController.text);

                                                setState(() {
                                                  isLoadingProgress = false;
                                                });
                                              }
                                              return;
                                            } catch (er) {
                                              setState(() {
                                                isLoadingProgress = false;
                                              });
                                              print(er.toString());
                                              // utilService!.showToast(er.toString());
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).accentColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      sx(5.0)),
                                            ),
                                            constraints: BoxConstraints(
                                                maxWidth: sx(440),
                                                minHeight: sy(35)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "LOGIN",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: sy(11),
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: sy(7),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: sy(25),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: sy(1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: Text(
                                          'or Login with',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: sy(9),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        width: sy(20),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: sy(1),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: sy(10),
                                  ),
                                  Platform.isIOS
                                      ? IosButtonsWidget()
                                      : AndroidButtonsWidget()
                                ]),
                              ),
                            ],
                          ),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "If you don't have an account?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: sy(10),
                                    fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: () {
                                  navigationService
                                      .navigateTo(SignUpScreenRoute);
                                },
                                child: Text(
                                  'SIGNUP HERE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: sy(10),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: sy(10),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  if (isLoadingProgress)
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ])),
          ),
        );
      },
    );
  }
}
