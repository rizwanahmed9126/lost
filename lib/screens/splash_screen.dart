import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lost_tracking/constant/enum.dart';
import 'package:lost_tracking/models/user.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';
import '../services/storage_service.dart';
import '../utils/routes.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
// import '../widgets/exit_alert_dialog.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var navigationService = locator<NavigationService>();
  var storageService = locator<StorageService>();

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () async {
      try {
        var token =
            await this.storageService.getData(StorageKeys.token.toString());
        if (token != null) {
          Provider.of<AuthProvider>(context, listen: false).refreshToken();
          var user = await this.storageService.getData('user');
          Provider.of<AuthProvider>(context, listen: false)
              .setuser(AppUser.fromJson(user));
          await Provider.of<AuthProvider>(context, listen: false)
              .getAllUserContacts();
          Future.delayed(Duration(seconds: 2));
          navigationService.navigateTo(HomeScreenRoute);
        } else {
          navigationService.navigateTo(LoginScreenRoute);
        }
      } catch (err) {
        navigationService.navigateTo(LoginScreenRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future<bool> _onBackPressed() {
    //   return showDialog(
    //         context: context,
    //         builder: (context) => ExitAlertDialog(),
    //       ) ??
    //       false;
    // }

    return WillPopScope(
      onWillPop: null,
      child: Stack(
          // fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/splash.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
              child: Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                    child:
                        // Container(child: Image.asset('assets/images/logo.png')),
                        ShowUpAnimation(
                      delayStart: Duration(milliseconds: 200),
                      animationDuration: Duration(seconds: 1),
                      curve: Curves.bounceIn,
                      direction: Direction.vertical,
                      offset: 0.7,
                      child: Image.asset(
                        'assets/images/Splash-Logo.png',
                        scale: 3.5,
                      ),
                    ),
                  )),
            ),
          ]),
    );
  }
}
