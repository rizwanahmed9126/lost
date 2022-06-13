import 'package:flutter/material.dart';
import 'package:lost_tracking/models/user.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/http_service.dart';
import 'package:lost_tracking/services/storage_service.dart';
import 'package:lost_tracking/services/util_service.dart';
import 'package:lost_tracking/widget/cache_image.dart';
import 'package:lost_tracking/widget/column_scroll_view.dart';
import 'package:provider/provider.dart';

import 'package:relative_scale/relative_scale.dart';

import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   _name.text = "Christian Ellison";
  //   _email.text = "christian.ellison@gmail.com";
  //   _phone.text = "(555) 555-1234";
  //   _address.text = "1850 Rardin Drive,San Francisco,California,94124";
  // }

  nameToFirstLetterCapital(String name) {
    var displayName = "";
    if (name != "")
      displayName = name[0].toUpperCase() + name.substring(1).toLowerCase();
    return displayName;
  }

  UtilService? utilService = locator<UtilService>();
  NavigationService? navigationService = locator<NavigationService>();
  var imageUrl = '';
  AppUser? user;
  StorageService? storageService = locator<StorageService>();
  HttpService? http = locator<HttpService>();

  loadData() {
    user = Provider.of<AuthProvider>(context, listen: false).user;
    if (user != null) {
      _name.text = user!.displayName != null ? user!.displayName! : '';
      _email.text = user!.email != null ? user!.email! : '';
      _phone.text = user!.phoneNumber != null ? user!.phoneNumber! : '';
      _address.text = user!.address != null ? user!.address! : '';
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return WillPopScope(
        onWillPop: () => navigationService!
            .navigateTo(HomeScreenRoute)
            .then((value) => value as bool),
        child: Scaffold(
          // backgroundColor: Colors.red,
          body: Stack(children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //     colors: [
                      //       Color.fromRGBO(2, 16, 55, 1),
                      //       Color.fromRGBO(6, 28, 85, 1)
                      //     ]),
                      image: DecorationImage(
                        image: AssetImage("assets/images/blue_rounded.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: sy(30), right: sy(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: sy(16),
                                    ),
                                    onPressed: () {
                                      navigationService!
                                          .navigateTo(HomeScreenRoute);
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      navigationService!
                                          .navigateTo(EditProfileScreenRoute);
                                    },
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: Colors.white,
                                              offset: Offset(0, -3))
                                        ],
                                        color: Colors.transparent,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                        decorationThickness: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: sy(10),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: user != null &&
                                      user!.profileImageUrl != null &&
                                      user!.profileImageUrl != ''
                                  ? CircleAvatar(
                                      radius: sy(33),
                                      backgroundColor: Colors.transparent,
                                      child: CacheImage(
                                        imageUrl: user!.profileImageUrl!,
                                        radius: 200,
                                        height: 120,
                                        width: 120,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: sy(33),
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: AssetImage(
                                          "assets/images/profile.png"),
                                    ),
                            ),
                            // SizedBox(height: sy(5)),
                            Text(
                              user!.displayName!,
                              style: TextStyle(
                                  color: Colors.white, fontSize: sy(12)),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (user!.country != "")
                                  Icon(Icons.location_pin,
                                      color: Colors.grey, size: sy(10)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(user!.country!,
                                    style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: sy(8))),
                              ],
                            ),
                            SizedBox(
                              height: sy(20),
                            )
                          ],
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: sx(20),
                                            right: sx(20),
                                            top: sy(0)),
                                        child: ColumnScrollView(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: _name,
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        fontSize: sy(9),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    autocorrect: true,
                                                    decoration: InputDecoration(
                                                      labelText: "Name",
                                                      labelStyle: TextStyle(
                                                          height: 0.7,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          fontSize: sy(10)),
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 4.0,
                                                              horizontal: 10),
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor)),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey.shade300),
                                                      ),
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontSize: sy(9),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  SizedBox(height: sy(20)),
                                                  TextFormField(
                                                    controller: _email,
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        fontSize: sy(9),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    autocorrect: true,
                                                    decoration: InputDecoration(
                                                      labelText: "Email",
                                                      labelStyle: TextStyle(
                                                          height: 0.7,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          fontSize: sy(10)),
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 4.0,
                                                              horizontal: 10),
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor)),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey.shade300),
                                                      ),
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontSize: sy(9),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  SizedBox(height: sy(20)),
                                                  TextFormField(
                                                    controller: _phone,
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        fontSize: sy(9),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    autocorrect: true,
                                                    decoration: InputDecoration(
                                                      labelText: "Phone",
                                                      labelStyle: TextStyle(
                                                          height: 0.7,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          fontSize: sy(10)),
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 4.0,
                                                              horizontal: 10),
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor)),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey.shade300),
                                                      ),
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontSize: sy(9),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  SizedBox(height: sy(20)),
                                                  TextFormField(
                                                    controller: _address,
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        fontSize: sy(9),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    autocorrect: true,
                                                    decoration: InputDecoration(
                                                      labelText: "Address",
                                                      labelStyle: TextStyle(
                                                          height: 0.7,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          fontSize: sy(10)),
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 4.0,
                                                              horizontal: 10),
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor)),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey.shade300),
                                                      ),
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontSize: sy(9),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                      ),
                                    )
                                  ],
                                ))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      );
    });
  }
}
