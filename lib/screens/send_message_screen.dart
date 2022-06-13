import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:lost_tracking/models/user_contact.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/services/util_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:lost_tracking/widget/send_message_widget.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:dotted_border/dotted_border.dart';

class SendMessageScreen extends StatefulWidget {
  SendMessageScreen({Key? key}) : super(key: key);

  @override
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  List<AddContact> data = [];

  String selectedNumber = '';

  // List paymentMethod = [
  //   {
  //     "id": "1",
  //     "title": "Benjamin Frank",
  //     "sub-title": "Bartlett Avenue,Southfield Michigan",
  //     "relation": "Family",
  //   },
  //   {
  //     "id": "2",
  //     "title": "Benjamin Frank",
  //     "sub-title": "Bartlett Avenue,Southfield Michigan",
  //     "relation": "Friend",
  //   },
  // ];
  late TextEditingController _controllerPeople, _controllerMessage;
  String tagId = ' ';
  String? _message, body;
  List<String> people = [];

  void active(AddContact val) {
    setState(() {
      if (tagId == val.id) {
        tagId = "";
      } else {
        tagId = val.id!;
        selectedNumber = val.phoneNumber!;
      }
    });
  }

  @override
  void initState() {
    data = Provider.of<AuthProvider>(context, listen: false).getAllContacts;
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _controllerPeople = TextEditingController();
    _controllerMessage = TextEditingController(text: "Help Me! I am Lost.");
  }

  Future<void> _sendSMS(List<String> recipients, var data) async {
    try {
      String _result = await sendSMS(
          message: _controllerMessage.text +
              '\nMy Current Location: ' +
              'https://www.google.com/maps/dir/?api=1&destination=${data['latitude']},${data['longitude']}',
          recipients: recipients);
      setState(() => _message = _result);
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  var isLoadingProgress = false;

  NavigationService? navigationService = locator<NavigationService>();
  UtilService? utilService = locator<UtilService>();

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
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () =>
                      navigationService!.navigateTo(HomeScreenRoute)),
              title: (Text(
                "Send To",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sy(14),
                  // fontWeight: FontWeight.w700,
                ),
              )),
              titleSpacing: 0,
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
            ),
            body: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(sy(10)),
                    topLeft: Radius.circular(sy(10)),
                  )),
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(sx(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (ctx, i) => Column(
                              children: [
                                SendMessageWidget(
                                  data: data[i],
                                  action: active,
                                  tag: data[i].id.toString(),
                                  active: tagId == data[i].id.toString()
                                      ? true
                                      : false,
                                ),
                                if (i == data.length - 1)
                                  Container(
                                    margin: EdgeInsets.only(left: 3.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          navigationService!.navigateTo(
                                              AddContactScreenRoute);
                                        },
                                        child: roundedRectBorderWidget),
                                  ),
                              ],
                            )),
                  ),
                  RaisedButton(
                    highlightElevation: 3.0,
                    elevation: 3.0,
                    onPressed: () async {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sx(80.0))),
                    padding: EdgeInsets.all(0.0),
                    child: InkWell(
                      onTap: () async {
                        await Provider.of<AuthProvider>(context, listen: false)
                            .getCurrentLocation();
                        var loc = Provider.of<AuthProvider>(context, listen: false)
                            .getLatLng;
                        _send(selectedNumber, loc);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(sx(30.0)),
                        ),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width,
                            minHeight: sy(30)),
                        alignment: Alignment.center,
                        child: Text(
                          "Send",
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget get roundedRectBorderWidget {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return DottedBorder(
        dashPattern: [4, 4],
        color: Colors.grey.shade400,
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Container(
            height: sy(50),
            width: sy(232),
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                height: sy(60),
                padding: EdgeInsets.all(12),
                // decoration: BoxDecoration(
                //   color: Colors.transparent,
                //   border: Border.all(color: Colors.grey[300], width: sx(1)),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    height: sy(20),
                    child: FittedBox(
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Theme.of(context).accentColor,
                        onPressed: () {
                          navigationService!.navigateTo(AddContactScreenRoute);
                        },
                        child: Icon(
                          Icons.add,
                          size: sy(25),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sx(15)),
                    child: Text(
                      "Add More User",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _send(String number, var data) {
    if (number != "") {
      people = [];
      people.add(number);
    }
    if (people.length == 0) {
      utilService!.showToast('please select at least 1 contact.');
      return;
    } else {
      _sendSMS(people, data);
    }
  }
}
