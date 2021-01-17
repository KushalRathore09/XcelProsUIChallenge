import 'dart:ui';

import 'package:fl_xcel/screens/signup.dart';
import 'package:fl_xcel/utils/app_images.dart';
import 'package:fl_xcel/utils/fade_page.dart';
import 'package:fl_xcel/widgets/common_widgets.dart';
import 'package:fl_xcel/widgets/constants.dart';
import 'package:fl_xcel/widgets/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute>
    with SingleTickerProviderStateMixin {
  String _username = '';
  String _password = '';

  bool _validUsername = true;
  bool _validPassword = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
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
                        )),
                      ),
                    ),
                    Hero(
                      tag: 'main_image',
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          signInBackgroundImages,
                          fit: BoxFit.fill,
                          alignment: Alignment.topRight,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Hero(
                            tag: 'hyphen_tag',
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16),
                              height: 5,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Hero(
                            flightShuttleBuilder: flightShuttleBuilder,
                            tag: 'welcome_tag',
                            child: Text(
                              'Welcome',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Hero(
                            flightShuttleBuilder: flightShuttleBuilder,
                            tag: 'desc_tag',
                            child: Text(
                              'to Daily UI Challenge',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Hero(
                tag: 'bottom_layout',
                child: Material(
                  type: MaterialType.transparency,
                  child: SingleChildScrollView(
                    child: Container(
                      height: height / 2,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InputField(
                            hint: 'Username',
                            iconPath: userIcon,
                            onChanged: (txt) {
                              _username = txt;
                            },
                            secureText: false,
                            errorMessage:
                                _validUsername ? null : 'Enter valid username',
                          ),
                          InputField(
                            hint: 'Password',
                            iconPath: lockIcon,
                            onChanged: (txt) {
                              _password = txt;
                            },
                            secureText: true,
                            errorMessage:
                                _validPassword ? null : 'Enter valid password',
                          ),
                          SimpleButton(
                              text: 'SIGN IN',
                              onPressed: () {
                                setState(() {
                                  _validUsername = _username.length >= 3 && !_username.contains(' ');
                                  _validPassword = _password.length >= 6 && !_password.contains(' ');
                                });

                                if (_validUsername && _validPassword) {
                                  Navigator.pushReplacement(context,
                                      FadePage(widget: LoadingRoute()));
                                }
                              }),
                          RichText(
                            text: new TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(color: Colors.grey, fontSize: 18),
                              children: [
                                new TextSpan(
                                  text: 'SIGN UP',
                                  style: TextStyle(
                                      color: AppColors.greenAccent,
                                      fontWeight: FontWeight.bold),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.push(context,
                                          FadePage(widget: SignUpRoute()));
                                    },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
