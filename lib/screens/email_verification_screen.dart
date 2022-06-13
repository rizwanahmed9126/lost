import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/screenutil.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:lost_tracking/services/firebase_service.dart';
import 'package:supercharged/supercharged.dart';
import '../services/util_service.dart';
import '../utils/routes.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  NavigationService? navigationService = locator<NavigationService>();
  FirebaseService? firebase = locator<FirebaseService>();
  UtilService? utilService = locator<UtilService>();
  String? email;
  // AnalyticService? analyticService = locator<AnalyticService>();
  @override
  void dispose() {
    navigationService!.closeScreen();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // analyticService!.setCurrentScreen('EmailVerificationScreen');
  }

  @override
  void didChangeDependencies() {
    email = Provider.of<AuthProvider>(context, listen: false).user!.email;
    if (email == null) {
      email = '0';
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: 300,
        maxHeight: 250,
      ),
    );
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Stack(
              // fit: StackFit.expand,
              children: <Widget>[
                // Container(
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(
                //             'assets/images/white-background-for-logi.png'),
                //         fit: BoxFit.cover),
                //   ),
                // ),
                Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Theme.of(context).backgroundColor,
                          child: Icon(
                            Icons.check,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 25),
                        ),
                        Text(
                          'A Verification Link has been sent to',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        Text(
                          '$email. Kindly verify your email',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        Text(
                          'and login to continue.',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () async {
                            await firebase!.resendEmailVerification();
                          },
                          child: Text(
                            'RESEND LINK',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                      ]),
                ),
                // Positioned.fill(child: Particles(20)),
                Positioned(
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: SizedBox(
                        width: ScreenUtil().setWidth(400),
                        height: ScreenUtil().setHeight(130),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          highlightElevation: 10.0,
                          elevation: 8.0,
                          highlightColor: Theme.of(context).backgroundColor,
                          color: Theme.of(context).backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text(
                              "LOGIN NOW",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(35),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {
                            navigationService!.navigateTo(LoginScreenRoute);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setSp(60))),
                        ),
                      ),
                    ),
                  ),
                ),
                // ),
                // ),
              ]),
        ));
  }
}

class Particles extends StatefulWidget {
  final int numberOfParticles;

  Particles(this.numberOfParticles);

  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  final List<ParticleModel> particles = [];

  @override
  void initState() {
    super.initState();
    widget.numberOfParticles.times(() => particles.add(ParticleModel(random)));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LoopAnimation(
      tween: ConstantTween(1),
      builder: (context, child, dynamic _) {
        _simulateParticles();
        return CustomPaint(
          painter: ParticlePainter(particles),
        );
      },
    );
  }

  _simulateParticles() {
    particles
        .forEach((particle) => particle.checkIfParticleNeedsToBeRestarted());
  }
}

enum _OffsetProps { x, y }

class ParticleModel {
  late MultiTween<_OffsetProps> tween;
  late double size;
  late Duration duration;
  late Duration startTime;
  Random random;

  ParticleModel(this.random) {
    _restart();
    _shuffle();
  }

  // ignore: unused_element
  _restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);

    tween = MultiTween<_OffsetProps>()
      ..add(_OffsetProps.x, startPosition.dx.tweenTo(endPosition.dx))
      ..add(_OffsetProps.y, startPosition.dy.tweenTo(endPosition.dy));

    duration = 4000.milliseconds + random.nextInt(6000).milliseconds;
    startTime = DateTime.now().duration();
    size = 0.2 + random.nextDouble() * 0.4;
  }

  void _shuffle() {
    startTime -= (this.random.nextDouble() * duration.inMilliseconds)
        .round()
        .milliseconds;
  }

  checkIfParticleNeedsToBeRestarted() {
    if (progress() == 1.0) {
      _restart();
    }
  }

  double progress() {
    return ((DateTime.now().duration() - startTime) / duration)
        .clamp(0.0, 1.0)
        .toDouble();
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(50);

    particles.forEach((particle) {
      final progress = particle.progress();
      final MultiTweenValues<_OffsetProps> animation =
          particle.tween.transform(progress);
      final position = Offset(
        animation.get<double>(_OffsetProps.x) * size.width,
        animation.get<double>(_OffsetProps.y) * size.height,
      );
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
