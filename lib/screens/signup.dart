import 'package:fl_xcel/utils/app_images.dart';
import 'package:fl_xcel/utils/fade_page.dart';
import 'package:fl_xcel/widgets/common_widgets.dart';
import 'package:fl_xcel/widgets/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


import '../widgets/loading.dart';

class SignUpRoute extends StatefulWidget {
  @override
  _SignUpRouteState createState() => _SignUpRouteState();
}

class _SignUpRouteState extends State<SignUpRoute> {
  String _username = '';
  String _password = '';
  String _email = '';

  bool _validUsername = true;
  bool _validPassword = true;
  bool _validEmail = true;
  bool _termsCheck = false;

  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex;

  @override
  void initState() {
    super.initState();
    regex = new RegExp(pattern);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 180,
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Row(
                            children: <Widget>[
                              Hero(
                                tag: 'hyphen_tag',
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                ),
                              ),
                              Hero(
                                tag: 'welcome_tag',
                                flightShuttleBuilder: flightShuttleBuilder,
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Hero(
                          tag: 'desc_tag',
                          flightShuttleBuilder: flightShuttleBuilder,
                          child: Text(
                            'Create New Account',
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Hero(
                tag: 'bottom_layout',
                child: Material(
                  type: MaterialType.transparency,
                  child: SingleChildScrollView(
                    child: Container(
                      height: height - 180,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Spacer(),
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
                          SizedBox(height: 30),
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
                          SizedBox(height: 30),
                          InputField(
                            hint: 'Email',
                            iconPath: emailIcon,
                            onChanged: (txt) {
                              _email = txt;
                            },
                            secureText: true,
                            errorMessage:
                                _validEmail ? null : 'Enter valid email',
                          ),
                          Spacer(),
                          TermsCheckBox(onChange: (bool val) {
                            _termsCheck = val;
                          }),
                          SizedBox(height: 40),
                          SimpleButton(
                              text: 'SIGN UP',
                              onPressed: () {
                                setState(() {
                                  _validUsername = _username.length >= 3 &&
                                      !_username.contains(' ');
                                  _validPassword = _password.length >= 6 &&
                                      !_password.contains(' ');
                                  _validEmail = regex.hasMatch(_email);
                                });

                                if (!_termsCheck) {
                                  Toast.show('Please check the terms', context);
                                }

                                if (_validUsername &&
                                    _validPassword &&
                                    _validEmail &&
                                    _termsCheck)
                                  Navigator.pushReplacement(context,
                                      FadePage(widget: LoadingRoute()));
                              }),
                          Spacer(),
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

class TermsCheckBox extends StatefulWidget {
  final Function(bool val) onChange;

  TermsCheckBox({@required this.onChange});

  @override
  _TermsCheckBoxState createState() => _TermsCheckBoxState();
}

class _TermsCheckBoxState extends State<TermsCheckBox> {
  var _termsCheck = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _termsCheck = !_termsCheck;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
                value: _termsCheck,
                onChanged: (bool value) {
                  setState(() {
                    _termsCheck = value;
                  });
                  widget.onChange(value);
                }),
          ),
          SizedBox(width: 10),
          RichText(
            text: new TextSpan(
              text: 'I have accepted the ',
              style: TextStyle(color: Colors.grey, fontSize: 18),
              children: [
                new TextSpan(
                  text: 'Terms & Condition',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.greenAccent,
                      fontWeight: FontWeight.bold),
                  recognizer: new TapGestureRecognizer()..onTap = () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
