import 'package:fl_xcel/utils/app_images.dart';
import 'package:fl_xcel/utils/fade_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'constants.dart';
import 'control_panel.dart';

class LoadingRoute extends StatefulWidget {
  @override
  _LoadingRouteState createState() => _LoadingRouteState();
}

class _LoadingRouteState extends State<LoadingRoute>
    with SingleTickerProviderStateMixin {
  AnimationController rotationController;
  double opacity = 0;

  @override
  void initState() {
    super.initState();

    rotationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    showAfter();
  }

  showAfter() async {
    await Future.delayed(Duration(milliseconds: 800), () {});
    setState(() {
      opacity = 1;
    });

    try {
      rotationController.repeat().orCancel;
    } on TickerCanceled {
      print('ticker cancelled');
    }

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          FadePage(widget: ControlPanelRoute()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      child: Stack(
        children: <Widget>[
          Hero(
            tag: 'gradient_tag',
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.darkBlue, AppColors.mediumBlue],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 30,
            child: Hero(
              tag: 'main_image',
              child: Image.asset(
                signInBackgroundImages,
              ),
            ),
          ),
          Opacity(
            opacity: opacity,
            child: Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  RotationTransition(
                    turns: Tween<double>(begin: 0.0, end: 1.0)
                        .animate(rotationController),
                    child: SvgPicture.asset(loadingIcon),
                  ),
                  SizedBox(height: 50),
                  Padding(
                      child: Text(
                        'Let\'s get you started',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none),
                      ),
                      padding: EdgeInsets.only(bottom: size.height / 6))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
