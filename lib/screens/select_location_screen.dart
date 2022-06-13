import 'package:flutter/material.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:relative_scale/relative_scale.dart';

// ignore: must_be_immutable
class SelectLocationScreen extends StatefulWidget {
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  TextEditingController _description = TextEditingController();
  @override
  void initState() {
    super.initState();
    _description.text =
        "Lorem Ipsum is simply dummy text of the , remaining essentially unchanged";
  }

  int _radioValue = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  var isLoadingProgress = false;

  NavigationService? navigationService = locator<NavigationService>();

  final double barHeight = 50.0;
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return WillPopScope(
          onWillPop: () => navigationService!
              .navigateTo(HomeScreenRoute)
              .then((value) => value as bool),
          child: Scaffold(
            // backgroundColor: HexColor("#4d13fb"),
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () =>
                      navigationService!.navigateTo(HomeScreenRoute)),
              title: (Text(
                "Select Location",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sy(12),
                  // fontWeight: FontWeight.w700,
                ),
              )),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
              titleSpacing: 0,
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
            ),
            body: Container(
              color: Theme.of(context).backgroundColor,
              // height: 10,
              child: Container(
                margin: EdgeInsets.only(top: sy(10)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(sy(10)),
                      topLeft: Radius.circular(sy(10)),
                    )),
                height: MediaQuery.of(context).size.height,
                // padding: EdgeInsets.all(sx(30)),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: sx(30), right: sx(30), top: sy(15)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Share Live Location',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: sy(14)),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: sx(35),
                                        child: Radio(
                                          value: 0,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                      ),
                                    ]),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Share Current Location',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: sy(14)),
                                      ),
                                      Container(
                                        width: sx(35),
                                        child: Radio(
                                          value: 1,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                      ),
                                    ]),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: sx(30),
                              right: sx(30),
                              bottom: sy(35),
                              top: sy(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recent",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: sy(10)),
                              ),
                              Container(
                                  width: sx(25),
                                  height: sy(1),
                                  color: Theme.of(context).accentColor),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Bartlett Avenue,Southfield Michigon',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: sy(8)),
                                      ),
                                      Icon(
                                        Icons.restore,
                                        color: Colors.grey[300],
                                        size: sy(15),
//
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '3745,Morgon Street,Fort Walton Beach,Florida',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: sy(8)),
                                      ),
                                      Icon(
                                        Icons.restore,
                                        color: Colors.grey[300],
                                        size: sy(15),
//
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Division Street,Harison,Florida',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: sy(8)),
                                      ),
                                      Icon(
                                        Icons.restore,
                                        color: Colors.grey[300],
                                        size: sy(15),
//
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height:100),
                        Container(
                          padding: EdgeInsets.only(left: sx(25), right: sx(25)),
                          color: Colors.grey[200],
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: sy(20)),
                              Container(
                                padding: EdgeInsets.all(sx(13)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Enter Description",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: sy(10)),
                                    ),
                                    Container(
                                        width: sx(25),
                                        height: sy(1),
                                        color: Theme.of(context).accentColor),
                                    Container(
                                      height: sy(85),
                                      padding: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: TextField(
                                        maxLines: 5,
                                        maxLength: 300,
                                        controller: _description,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: sy(10)),
                                        // readOnly: true,
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,

                                            // isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0, horizontal: 0),
                                            hintText: 'Type your message..',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: sy(10)),
                                            filled: true,
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none),
                                      ),

                                      // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  highlightElevation: 3.0,
                                  elevation: 3.0,
                                  onPressed: () async {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(sx(80.0))),
                                  padding: EdgeInsets.all(0.0),
                                  child: InkWell(
                                    onTap: () {
                                      //  navigationService
                                      //      .navigateTo(HomeScreenRoute);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius:
                                            BorderRadius.circular(sx(40.0)),
                                      ),
                                      constraints: BoxConstraints(
                                          maxWidth:
                                              MediaQuery.of(context).size.width,
                                          minHeight: sy(30)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Next",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: sy(10),
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: sy(25))
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
// Text(
//                               "Enter Discription",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: sy(10)),
//                             ),
//                             Container(
//                                 width: sx(30),
//                                 height: sy(1),
//                                 color: Theme.of(context).accentColor),
// Icon(
//                           Icons.radio_button_checked_sharp,
//                           color: widget.active ?   HexColor("#4d13fb")
//                             : HexColor("#e0e2e6"),
//                           size: sy(20),
//                         ),
// import 'package:flutter/material.dart';
// import 'package:relative_scale/relative_scale.dart';

// import '../../services/navigation_service.dart';
// import '../../utils/routes.dart';
// import '../../utils/service_locator.dart';
// import '../../widgets/send_message_widget.dart';

// class SendMessageScreen extends StatefulWidget {
//   SendMessageScreen({Key key}) : super(key: key);

//   @override
//   _SendMessageScreenState createState() => _SendMessageScreenState();
// }

// class _SendMessageScreenState extends State<SendMessageScreen> {

//   String tagId = ' ';

//   void active(String val) {
//     setState(() {
//       tagId = val;
//     });
//   }

//   var isLoadingProgress = false;

//   var navigationService = locator<NavigationService>();

//   final double barHeight = 50.0;
//   @override
//   Widget build(BuildContext context) {
//     return RelativeBuilder(
//       builder: (context, height, width, sy, sx) {
//         return WillPopScope(
//           onWillPop: () => navigationService.navigateTo(HomeScreenRoute),
//           child: Scaffold(
//             // backgroundColor: HexColor("#4d13fb"),
//             appBar: AppBar(
//               leading: IconButton(
//                   icon: Icon(Icons.arrow_back),
//                   onPressed: () =>
//                       navigationService.navigateTo(HomeScreenRoute)),
//               title: (Text(
//                 "Send To",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: sy(14),
//                   // fontWeight: FontWeight.w700,
//                 ),
//               )),
//               titleSpacing: 0,
//               backgroundColor: Theme.of(context).backgroundColor,
//               elevation: 0,
//             ),
//             body: Container(
//               color: Theme.of(context).backgroundColor,
//               // height: 10,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(sy(10)),
//                       topLeft: Radius.circular(sy(10)),
//                     )),
//                 height: MediaQuery.of(context).size.height,
//                 padding: EdgeInsets.all(sx(30)),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(top: 10),
//                       child: SingleChildScrollView(
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 height: sy(160),
//                                 width: double.infinity,
//                                 // color: Colors.red,
//                                 // color: Theme.of(context).backgroundColor,
//                                 child: ListView.builder(
//                                     itemCount: paymentMethod.length,
//                                     itemBuilder: (ctx, i) => PaymentItemWidget(
//                                           data: paymentMethod[i],
//                                           action: active,
//                                           tag: paymentMethod[i]['id'],
//                                           active:
//                                               tagId == paymentMethod[i]['id']
//                                                   ? true
//                                                   : false,
//                                         )),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 2),
//                                 child: Container(
//                                   height: sy(60),
//                                   padding: EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: Colors.transparent,
//                                     border: Border.all(
//                                         color: Colors.grey[300], width: sx(1)),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           height: sy(20),
//                                           child: FittedBox(
//                                             child: FloatingActionButton(
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5)),
//                                               backgroundColor:
//                                                   Theme.of(context).accentColor,
//                                               onPressed: () {
//                                                 // showDialog(
//                                                 //     barrierDismissible: false,
//                                                 //     context: context,
//                                                 //     builder: (_) {
//                                                 //       return Dialogs();
//                                                 //     });
//                                               },
//                                               child: Icon(
//                                                 Icons.add,
//                                                 size: sy(25),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               EdgeInsets.only(left: sx(15)),
//                                           child: Text(
//                                             "Add More User",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ),
//                                       ]),
//                                 ),
//                               ),
//                             ]),
//                       ),
//                     ),
//                     RaisedButton(
//                       highlightElevation: 3.0,
//                       elevation: 3.0,
//                       onPressed: () async {},
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(sx(80.0))),
//                       padding: EdgeInsets.all(0.0),
//                       child: InkWell(
//                         onTap: () {
//                           navigationService.navigateTo(HomeScreenRoute);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).accentColor,
//                             borderRadius: BorderRadius.circular(sx(30.0)),
//                           ),
//                           constraints: BoxConstraints(
//                               maxWidth: MediaQuery.of(context).size.width,
//                               minHeight: sy(30)),
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Send",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: sy(11),
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
