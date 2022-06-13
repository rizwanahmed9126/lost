import 'package:flutter/material.dart';
import 'package:lost_tracking/models/user.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/services/util_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var navigationService = locator<NavigationService>();
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AppUser? user;
  var utilService = locator<UtilService>();
  var isLoadingProgress = false;
  bool _showOldPassword = false;
  bool _showPassword = false;
  bool _confirmShowPassword = false;

  String validatePassword(String? value) {
    if (value!.length < 8) {
      return '     Password must be of 8 characters';
    } else
      return '';
  }

  String validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return '     Password do not match';
    } else
      return '';
  }

  @override
  void initState() {
    super.initState();
  }

  var fieldwidth;
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Stack(
        children: [
          AbsorbPointer(
            key: UniqueKey(),
            absorbing: isLoadingProgress,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: sy(25),
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                navigationService
                                    .navigateTo(SettingScreenRoute);
                              }),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: sy(85),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: sy(0)),
                              child: Image.asset(
                                "assets/images/logo.png",
                                fit: BoxFit.cover,
                                height: sy(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sy(35),
                          ),
                          Container(
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                  fontSize: sy(13),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: sy(4),
                          ),
                          Container(
                            height: 1.5,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(183, 187, 202, 1)),
                          ),
                          SizedBox(
                            height: sy(12),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Container(
                                    child: TextFormField(
                                      controller: oldPasswordController,
                                      obscureText: !_showOldPassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .accentColor)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade400)),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 12.0, horizontal: 20),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                        hintText: 'Old Password',
                                        hintStyle: TextStyle(
                                            fontSize: sy(9),
                                            color: Color.fromRGBO(
                                                124, 133, 159, 1)),
                                        suffixIcon: _showOldPassword
                                            ? IconButton(
                                                padding:
                                                    EdgeInsets.only(right: 0),
                                                icon: Icon(
                                                  Icons.visibility,
                                                  size: sy(12),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _showOldPassword = false;
                                                  });
                                                },
                                              )
                                            : IconButton(
                                                padding:
                                                    EdgeInsets.only(right: 0),
                                                icon: Icon(
                                                  Icons.visibility_off,
                                                  size: sy(14),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _showOldPassword = true;
                                                  });
                                                },
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: sy(10),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: !_showPassword,
                                      validator: validatePassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .accentColor)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade400)),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 12.0, horizontal: 20),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                        hintText: 'New Password',
                                        hintStyle: TextStyle(
                                            fontSize: sy(9),
                                            color: Color.fromRGBO(
                                                124, 133, 159, 1)),
                                        suffixIcon: _showPassword
                                            ? IconButton(
                                                padding:
                                                    EdgeInsets.only(right: 0),
                                                icon: Icon(
                                                  Icons.visibility,
                                                  size: sy(12),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _showPassword = false;
                                                  });
                                                },
                                              )
                                            : IconButton(
                                                padding:
                                                    EdgeInsets.only(right: 0),
                                                icon: Icon(
                                                  Icons.visibility_off,
                                                  size: sy(14),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _showPassword = true;
                                                  });
                                                },
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: sy(10),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      validator: validateConfirmPassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: confirmPasswordController,
                                      obscureText: !_confirmShowPassword,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .accentColor)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade400)),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 12.0, horizontal: 20),
                                        hintText: 'Confirm New Password',
                                        hintStyle: TextStyle(
                                            fontSize: sy(9),
                                            color: Color.fromRGBO(
                                                124, 133, 159, 1)),
                                        suffixIcon: _confirmShowPassword
                                            ? IconButton(
                                                padding:
                                                    EdgeInsets.only(right: 0),
                                                icon: Icon(
                                                  Icons.visibility,
                                                  size: sy(12),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _confirmShowPassword =
                                                        false;
                                                  });
                                                },
                                              )
                                            : IconButton(
                                                padding:
                                                    EdgeInsets.only(right: 0),
                                                icon: Icon(
                                                  Icons.visibility_off,
                                                  size: sy(14),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _confirmShowPassword = true;
                                                  });
                                                },
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: sy(25),
                                  ),
                                  // Container(
                                  //   width: 400,
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.red,
                                  //       borderRadius: BorderRadius.circular(0)),
                                  //   child: FlatButton(
                                  //       onPressed: () {},
                                  //       child: Text(
                                  //         "SignUp",
                                  //         style: TextStyle(color: Colors.white),
                                  //       )),
                                  // )
                                  Container(
                                    decoration: BoxDecoration(

                                        // color: Colors.blue,
                                        ),
                                    child: RaisedButton(
                                      color: Colors.red,
                                      splashColor: Colors.transparent,
                                      elevation: 5.0,
                                      onPressed: () async {
                                        setState(() {
                                          isLoadingProgress = true;
                                        });

                                        await Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .changePassword(
                                                oldPasswordController.text,
                                                confirmPasswordController.text);
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      },
                                      padding: EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                sy(30.0))),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7.2,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Change Password",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: sy(11),
                                              fontFamily: "Oxygen",
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoadingProgress)
            Positioned(
                child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ))
        ],
      );
    });
  }
}
