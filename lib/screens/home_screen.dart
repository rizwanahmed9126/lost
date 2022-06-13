import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:relative_scale/relative_scale.dart';
import '../widget/main_drawer_widget.dart';
import 'package:avatar_glow/avatar_glow.dart';
import '../widget/google_webview_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var navigationService = locator<NavigationService>();
  var isLoadingProgress = false;
  @override
  void initState() {
    super.initState();
  }

  _callNumber() async {
    const number = '911'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return AbsorbPointer(
        absorbing: isLoadingProgress,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          // extendBodyBehindAppBar: true,
          drawer: MainDrawerWidget(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
              elevation: 0,
              // shadowColor: Theme.of(context).backgroundColor,
              // backgroundColor: Theme.of(context).backgroundColor,
              // foregroundColor: Theme.of(context).backgroundColor,
              // bottomOpacity: 10,
              // shape: RoundedRectangleBorder(
              //   side: BorderSide.none,
              //   // borderRadius: BorderRadius.vertical(
              //   //   bottom: Radius.circular(0),
              //   // ),
              // ),
              leading: Builder(
                builder: (context) => IconButton(
                    icon: Image.asset(
                      'assets/images/drawer_icon.png',
                      scale: 3.5,
                      color: Colors.white,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer()),
              ), // leading: Text('abc'),
              centerTitle: true,
              title: Container(
                child: Image.asset(
                  'assets/images/logo-white.png',
                  width: 70,
                ),
              ),
              actions: [
                IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    navigationService.navigateTo(NotificationScreenRoute);
                  },
                )
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                // color: Theme.of(context).backgroundColor,
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    // color: Color.fromRGBO(7, 29, 89, 1),
                  ),
                  color: Color.fromRGBO(7, 29, 89, 1),
                ),
                child: Stack(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                    ),
                    Column(
                      children: [
                        SizedBox(height: sy(30)),
                        Center(
                            child: Text(
                          "Are You Lost ?",
                          style: TextStyle(
                              fontSize: sy(20), fontWeight: FontWeight.bold),
                        )),
                        InkWell(
                          onTap: () {},
                          child: Center(
                              child: Text(
                            "Tap the button",
                            style: TextStyle(
                              fontSize: sy(12),
                            ),
                          )),
                        ),
                      ],
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.infinity,
                          // color: Colors.purple,
                          child: AvatarGlow(
                            startDelay: Duration(milliseconds: 500),
                            glowColor: Colors.red,
                            endRadius: 150.0,
                            duration: Duration(milliseconds: 2000),
                            repeat: true,
                            showTwoGlows: true,
                            repeatPauseDuration: Duration(milliseconds: 300),
                            child: MaterialButton(
                              onPressed: () async {
                                setState(() {
                                  isLoadingProgress = true;
                                });
                                await Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .getCurrentLocation();

                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return GoogleWebViewWidget();
                                }));
                                setState(() {
                                  isLoadingProgress = false;
                                });
                              },
                              elevation: 20.0,
                              shape: CircleBorder(),
                              child: Container(
                                width: sy(140),
                                height: sy(140),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(160.0)),
                                child: Text(
                                  "Help!",
                                  style: TextStyle(
                                      fontSize: sy(15),
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Wrap(
                          children: [
                            SizedBox(height: sy(30)),
                            Center(
                                child: Text(
                              "Disclaimer",
                              style: TextStyle(
                                  fontSize: sy(15),
                                  fontWeight: FontWeight.w500),
                            )),
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used ",
                                style: TextStyle(
                                  color: HexColor("#6F7882"),
                                  fontSize: sy(8),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            InkWell(
                              onTap: _callNumber,
                              child: Container(
                                padding: EdgeInsets.only(top: sy(3)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Call 911",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: sy(8),
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(height: sy(40)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoadingProgress == true)
                Positioned.fill(
                  top: sy(100),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
