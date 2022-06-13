import 'package:flutter/material.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:lost_tracking/widget/notification_widget.dart';
// import 'package:lost_tracking/widgets/notification_widget.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              navigationService.navigateTo(HomeScreenRoute);
            },
          ),
          centerTitle: true,
          title: Text('Notifications'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Center(
              child: Image.asset(
                "assets/images/notification.png",
                scale: 4,
              ),
            )
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     children: [
            //       Expanded(
            //           child: ListView.builder(
            //         itemCount: 13,
            //         itemBuilder: (ctx, i) {
            //           return NotificationItemWidget();
            //         },
            //       ))
            //     ],
            //   ),
            // ),
            ),
      ),
    );
  }
}
