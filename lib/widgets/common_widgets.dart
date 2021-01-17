import 'package:fl_xcel/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import 'constants.dart';

class InputField extends StatelessWidget {
  InputField({
    @required this.hint,
    @required this.secureText,
    @required this.onChanged,
    @required this.iconPath,
    this.errorMessage,
  });

  final String hint;
  final bool secureText;
  final Function(String text) onChanged;
  final String iconPath;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 26,
              height: 26,
              child: SvgPicture.asset(
                iconPath,
                width: 26,
                height: 26,
              ),
            ),
            SizedBox(width: 35),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                    errorText: errorMessage,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    hintText: hint,
                    focusColor: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  SimpleButton({
    @required this.text,
    @required this.onPressed,
  });

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: MaterialButton(
          minWidth: double.infinity,
          color: AppColors.greenAccent,
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Text(
            text,
            style:
                TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class BottomNavMenu extends StatefulWidget {
  @override
  _BottomNavMenuState createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
  var _index = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      onTap: (i) {
        setState(() {
          _index = i;
        });
      },
      currentIndex: _index,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(bulbIcon),
          title: Text('bulb'),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(homeIcon),
          title: Text('home'),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(settingsIcon),
          title: Text('settings'),
        ),
      ],
    ));
  }
}

Widget flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}

/////////////////////// Tween Animations ///////////////////

offsetTween({
  @required AnimationController controller,
  @required Offset begin,
  @required Offset end,
}) =>
    Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(curve: Curves.fastLinearToSlowEaseIn, parent: controller),
    );

opacityTween({
  @required AnimationController controller,
  @required double begin,
  @required double end,
}) =>
    Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: Curves.fastLinearToSlowEaseIn),
    );
