import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lost_tracking/models/user.dart';
import 'package:lost_tracking/models/user_contact.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/widget/cache_image.dart';
import 'package:provider/provider.dart';

import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import '../utils/routes.dart';

class MainDrawerWidget extends StatefulWidget {
  @override
  _MainDrawerWidgetState createState() => _MainDrawerWidgetState();
}

class _MainDrawerWidgetState extends State<MainDrawerWidget> {
  var navigationService = locator<NavigationService>();
  AppUser? user;
  List<AddContact> data = [];
  bool isLoadingProgress = false;
  @override
  void initState() {
    user = Provider.of<AuthProvider>(context, listen: false).user!;
    data = Provider.of<AuthProvider>(context, listen: false).getAllContacts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heights = MediaQuery.of(context).size.height;
    print(heights);
    return AbsorbPointer(
        absorbing: isLoadingProgress,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Drawer(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 2.8,
                      // height: 270.0,
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            user!.profileImageUrl == ""
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.green[300],
                                    backgroundImage: AssetImage(
                                        'assets/images/place_holder.png'),
                                  )
                                : CacheImage(
                                    imageUrl: user!.profileImageUrl!,
                                    radius: 80,
                                    height: 100,
                                    width: 100,
                                    // height: ScreenUtil().setSp(140),
                                    // width: ScreenUtil().setSp(140),
                                    // radius: 50,
                                  ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                                user!.displayName == null
                                    ? ""
                                    : user!.displayName!,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            SizedBox(
                              height: 5,
                            ),
                            if (this.user!.country != "")
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_location,
                                    color: Color.fromRGBO(162, 159, 202, 1),
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(this.user!.country!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(162, 159, 202, 1),
                                      )),
                                ],
                              ),
                          ],
                        ),
                        // decoration: BoxDecoration(
                        //   color: Colors.blue,
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      // trailing: Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: HexColor('#112fc3'),
                      //   size: 15,
                      // ),
                      title: Text('My Profile',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      onTap: () {
                        navigationService.navigateTo(ProfileScreenRoute);
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    ListTile(
                      // trailing: Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: HexColor('#112fc3'),
                      //   size: 20,
                      // ),
                      title: Text('My Contacts',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      onTap: () {
                        (data.length <= 0)
                            ? navigationService
                                .navigateTo(MyContactsScreenRoute)
                            : navigationService
                                .navigateTo(SendMessageScreenRoute);
                      },
                    ),
                    Divider(),
                    ListTile(
                      // trailing: Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: HexColor('#112fc3'),
                      //   size: 20,
                      // ),
                      title: Text('Packages',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      onTap: () async {
                        navigationService.navigateTo(PackagesScreenRoute);
                      },
                    ),
                    Divider(),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      child: Column(
                        mainAxisAlignment: heights <= 600
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: HexColor('#112fc3'),
                            //   size: 20,
                            // ),
                            title: Text('Settings',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black)),
                            onTap: () {
                              navigationService.navigateTo(SettingScreenRoute);
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (heights <= 600) SizedBox(height: 50),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                width: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                  // color: Colors.green,
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.black12,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    isLoadingProgress = true;
                                  });
                                  await Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .logoutFirebaseUser();
                                  setState(() {
                                    isLoadingProgress = false;
                                  });
                                  navigationService
                                      .navigateTo(LoginScreenRoute);
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.logout,
                                      color: HexColor('#E40F0F'),
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Logout',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
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
        ));
  }
}
