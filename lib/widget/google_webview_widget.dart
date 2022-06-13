import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
<meta id="viewport" name="viewport" content="width=device-width, initial-scale=0.9, minimum-scale=0.1, maximum-scale=3.0, user-scalable=yes">
</body>
</html>
''';

class GoogleWebViewWidget extends StatefulWidget {
  @override
  _GoogleWebViewWidgetState createState() => _GoogleWebViewWidgetState();
}

class _GoogleWebViewWidgetState extends State<GoogleWebViewWidget> {
  var navigationService = locator<NavigationService>();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int position = 1;
  var data;
  String selectedUrl = '';
  var contactData;

  @override
  initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    data = Provider.of<AuthProvider>(context, listen: false).getLatLng;
    contactData =
        Provider.of<AuthProvider>(context, listen: false).getAllContacts;
    selectedUrl =
        'https://www.google.com/maps/?q=${data['latitude']},${data['longitude']}';
  }

  final Set<Factory> gestureRecognizers =
      [Factory(() => EagerGestureRecognizer())].toSet();
  UniqueKey _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                'Lost Tracking',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Stack(
              children: [
                WebView(
                  key: _key,
                  // gestureRecognizers: gestureRecognizers,
                  initialUrl: selectedUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onPageStarted: (value) {
                    setState(() {
                      position = 1;
                    });
                  },
                  onPageFinished: (value) {
                    setState(() {
                      position = 0;
                    });
                  },
                  allowsInlineMediaPlayback: true,
                  initialMediaPlaybackPolicy:
                      AutoMediaPlaybackPolicy.always_allow,
                  gestureNavigationEnabled: true,
                ),
                if (!_controller.isCompleted)
                  Container(
                    child: Center(
                      child: Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: Colors.black),
                          child: CircularProgressIndicator()),
                    ),
                  ),
                if (_controller.isCompleted)
                  Positioned.fill(
                    // left: sx(20),
                    // top: sy(60),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: sy(25),

                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          highlightElevation: 3.0,
                          elevation: 3.0,
                          onPressed: () {
                            navigationService.navigateTo(MyContactsScreenRoute);
                            Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(sx(80.0))),
                          padding: EdgeInsets.all(0.0),
                          child: InkWell(
                            onTap: () {
                              // var url = 'https://www.google.com/maps/dir/?api=1&destination=${data['latitude']},${data['longitude']}';
                              // Provider.of<AuthProvider>(context, listen: false).setCurrentLocationUrl()
                              Navigator.of(context).pop();

                              (contactData.length <= 0)
                                  ? navigationService
                                      .navigateTo(MyContactsScreenRoute)
                                  : navigationService
                                      .navigateTo(SendMessageScreenRoute);

                              // Share.share(
                              //     'https://www.google.com/maps/dir/?api=1&destination=${data['latitude']},${data['longitude']}',
                              //     subject: 'Sharing location of a user');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(sx(5.0)),
                              ),
                              constraints: BoxConstraints(
                                  maxWidth: sx(230), minHeight: sy(55)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Share Location",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: sy(11),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(Icons.share_location_sharp,
                                      color: Colors.white, size: sy(11)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            )),
      );
    });
  }

  // ignore: unused_element
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
