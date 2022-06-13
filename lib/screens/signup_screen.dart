import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/util_service.dart';
import 'package:lost_tracking/widget/column_scroll_view.dart';

import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _showPassword = false;
  bool _confirmShowPassword = false;
  var isLoadingProgress = false;
  var navigationService = locator<NavigationService>();
  UtilService? utilService = locator<UtilService>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // String validateemail(String? value) {
  //   RegExp? regex = new RegExp(
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  //   if (!regex.hasMatch(value!))
  //     return 'Enter valid email';
  //   else
  //     return '';
  // }

  String validatePassword(String? value) {
    if (value!.length < 8) {
      return 'Password must be of 8 characters';
    } else
      return '';
  }

  String validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Password do not match';
    } else
      return '';
  }

  // String validateMobile(String? value) {
  //   String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  //   RegExp regExp = new RegExp(pattern);
  //   if (value!.length == 0) {
  //     return 'Please enter mobile number';
  //   } else if (!regExp.hasMatch(value)) {
  //     return 'Please enter valid mobile number';
  //   }
  //   return '';
  // }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return WillPopScope(
        onWillPop: () => navigationService
            .navigateTo(LoginScreenRoute)
            .then((value) => value as bool),
        child: AbsorbPointer(
          absorbing: isLoadingProgress,
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ColumnScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      navigationService
                                          .navigateTo(LoginScreenRoute);
                                    }),
                              ],
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: sy(10)),
                                child: Image.asset(
                                  "assets/images/logo.png",
                                  fit: BoxFit.cover,
                                  height: sy(50),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: sy(20),
                            ),
                            Container(
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                    fontSize: sy(15),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: sy(4),
                            ),
                            Container(
                              height: 1.5,
                              width: 30,
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
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextFormField(
                                        controller: firstnameController,
                                        autocorrect: true,
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .accentColor)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          helperStyle:
                                              TextStyle(color: Colors.grey),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            size: 20,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                  horizontal: 30),
                                          hintText: 'First Name',
                                          hintStyle: TextStyle(
                                              fontSize: sy(9),
                                              color: Color.fromRGBO(
                                                  124, 133, 159, 1)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: sy(10),
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: lastnameController,
                                        autocorrect: true,
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .accentColor)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            size: 20,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                  horizontal: 20),
                                          hintText: 'Last Name',
                                          hintStyle: TextStyle(
                                              fontSize: sy(9),
                                              color: Color.fromRGBO(
                                                  124, 133, 159, 1)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: sy(10),
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        // validator: validateemail,
                                        autovalidateMode: AutovalidateMode
                                            .onUserInteraction, //when user click the field
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
                                                  vertical: 12.0,
                                                  horizontal: 20),
                                          hintText: 'Email',
                                          prefixIcon: Icon(
                                            Icons.email,
                                            size: 20,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          hintStyle: TextStyle(
                                              fontSize: sy(9),
                                              color: Color.fromRGBO(
                                                  124, 133, 159, 1)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: sy(10),
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: phoneController,
                                        autocorrect: true,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        // validator: validateMobile,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .accentColor)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          prefixIcon: Icon(
                                            Icons.phone,
                                            size: 20,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                  horizontal: 20),
                                          hintText: 'Phone',
                                          hintStyle: TextStyle(
                                              fontSize: sy(9),
                                              color: Color.fromRGBO(
                                                  124, 133, 159, 1)),
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
                                        // validator: validatePassword,
                                        // autovalidateMode:
                                        //     AutovalidateMode.onUserInteraction,
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
                                                  vertical: 12.0,
                                                  horizontal: 20),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            size: 20,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          hintText: 'Password',
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
                                        // validator: validateConfirmPassword,
                                        // autovalidateMode:
                                        //     AutovalidateMode.onUserInteraction,
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
                                                  color: Colors.grey)),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            size: 20,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                  horizontal: 20),
                                          hintText: 'Confirm Password',
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
                                                      _confirmShowPassword =
                                                          true;
                                                    });
                                                  },
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: sy(20),
                                    ),
                                    // Container(
                                    //   width: 400,
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.red[900],
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
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                        color: Theme.of(context).accentColor,
                                        splashColor: Colors.transparent,
                                        elevation: 5.0,
                                        onPressed: () async {
                                          if (firstnameController.text == "" ||
                                              lastnameController.text == "" ||
                                              emailController.text == "" ||
                                              phoneController.text == "" ||
                                              passwordController.text == "" ||
                                              confirmPasswordController.text ==
                                                  "") {
                                            utilService!.showToast(
                                                "Please fill all fields");
                                          } else if (!emailController.text
                                              .contains('@')) {
                                            utilService!.showToast(
                                                "Please Enter a valid Email");
                                          } else if (!emailController.text
                                              .contains('.com')) {
                                            utilService!.showToast(
                                                "Please Enter a valid Email");
                                          } else if (passwordController.text !=
                                              confirmPasswordController.text) {
                                            utilService!.showToast(
                                                "Password not match");
                                          } else if (phoneController
                                                      .text.length <
                                                  7 ||
                                              phoneController.text.length >
                                                  15) {
                                            utilService!.showToast(
                                                "Please enter a valid number!");
                                          } else {
                                            setState(() {
                                              isLoadingProgress = true;
                                            });
                                            try {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              await Provider.of<AuthProvider>(
                                                      context,
                                                      listen: false)
                                                  .createUserWithEmailPassword(
                                                      emailController.text,
                                                      passwordController.text,
                                                      firstnameController.text,
                                                      lastnameController.text,
                                                      phoneController.text);
                                              setState(() {
                                                isLoadingProgress = false;
                                              });
                                            } catch (e) {
                                              utilService!
                                                  .showToast(e.toString());
                                              setState(() {
                                                isLoadingProgress = false;
                                              });
                                            }
                                          }
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                              "SIGNUP",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: sy(11),
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
                        Column(
                          children: [
                            SizedBox(
                              height: sy(20),
                            ),
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[500]),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigationService.navigateTo(LoginScreenRoute);
                              },
                              child: Text(
                                "LOGIN HERE",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (isLoadingProgress)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
