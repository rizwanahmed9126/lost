import 'package:flutter/material.dart';
import 'package:lost_tracking/screens/resent_password_successfully.dart';
import '../screens/add_contacts_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/my_contacts_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/packages_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/send_message_screen.dart';
import '../screens/setting_screen.dart';
import '../screens/forget_password_screen.dart';
import '../screens/reset_password_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/email_verification_screen.dart';

const SplashScreenRoute = '/splash-Screen';
const LoginScreenRoute = '/Login-Screen';
const SignUpScreenRoute = '/Signup-Screen';
const ResetScreenRoute = '/Reset-Screen';
const ForgetPasswordScreenRoute = '/ForgetPassword-Screen';
const SendMessageScreenRoute = '/send-message-screen';
const HomeScreenRoute = '/home-screen';
const SettingScreenRoute = '/setting-screen';
const ProfileScreenRoute = '/profile-screen';
const EditProfileScreenRoute = '/edit-profile-screen';
const AddContactScreenRoute = '/add-contact-screen';
const MyContactsScreenRoute = '/my-contacts-screen';
const NotificationScreenRoute = 'notification-screen';
const PackagesScreenRoute = '/packages-screen';
const SelectLocationScreenRoute = '/select-location-screen';
const EmailVerificationScreenRoute = '/email-verification-screen';
const ResetPasswordSuccessfullyScreenRoute =
    '/reset-password-successfully-screen';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen());

    case LoginScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen());

    case ForgetPasswordScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ForgetPasswordScreen());

    case SignUpScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SignUpScreen());

    case ResetScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ResetPasswordScreen());

    case SendMessageScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SendMessageScreen());

    case HomeScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());

    case PackagesScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => PackagesScreen());

    case AddContactScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => AddContactsScreen());

    case SettingScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SettingsScreen());

    case ProfileScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ProfileScreen());

    case PackagesScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => PackagesScreen());

    case MyContactsScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MyContactsScreen());

    case ProfileScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ProfileScreen());

    case NotificationScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => NotificationScreen());

    case EditProfileScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => EditProfileScreen());

    case AddContactScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => AddContactsScreen());

    case EmailVerificationScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => EmailVerificationScreen());

    case ResetPasswordSuccessfullyScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ResetPasswordSuccessfullyScreen());

    default:
      return MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen());
  }
}
