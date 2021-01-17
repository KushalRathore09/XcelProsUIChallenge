import 'package:fl_xcel/models/light_model.dart';
import 'package:fl_xcel/models/room_model.dart';
import 'package:fl_xcel/models/scene_model.dart';
import 'package:fl_xcel/utils/app_images.dart';
import 'package:fl_xcel/widgets/common_widgets.dart';
import 'package:fl_xcel/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';


class RoomScreen extends StatefulWidget {
  final RoomModel room;

  RoomScreen({this.room});

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final List<LightModel> _lights = LightModel.sampleLights();
  final List<SceneModel> _scenes = SceneModel.getSampleData();
  final List<Color> _colors = [
    AppColors.lightColorRed,
    AppColors.lightColorGreen,
    AppColors.lightColorBlue,
    AppColors.lightColorPurple,
    AppColors.lightColorViolet,
    AppColors.lightColorYellow,
    AppColors.white,
  ];
  int selectedLight = 1;
  double _intensity = 0;

  var _selectedColor;

  @override
  void initState() {
    _selectedColor = _colors[0];

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    Future.delayed(Duration(milliseconds: 700), () {
      _controller.forward();
    });


    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        _intensity =
            opacityTween(controller: _controller, begin: 0, end: 25).value;
        return WillPopScope(
          onWillPop: () async {
            _controller.reverse();
            await Future.delayed(Duration(milliseconds: 600));
            return true;
          },
          child: Scaffold(
            bottomNavigationBar: BottomNavMenu(),
            body: Stack(
              children: <Widget>[
                _topBackground(),
                _topCircles(),
                Positioned(
                  top: 0,
                  right: 50,
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: SlideTransition(
                      position: offsetTween(
                        controller: _controller,
                        begin: Offset(0, -0.3),
                        end: Offset(0, 0),
                      ),
                      child: BulbWidget(
                        selectedColor: _selectedColor,
                        intensity: _intensity,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: _headerWidgets(),
                        flex:1,
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        flex:2,
                        child: Hero(
                          flightShuttleBuilder: flightShuttleBuilder,
                          tag: 'room_data_tag',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.lightWhite,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(35),
                                  topLeft: Radius.circular(35),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 25),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Intensity',
                                        style: AppTextStyles.subtitleStyle,
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                              bulbIntensityLow),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: CupertinoSlider(
                                                      activeColor:
                                                          AppColors.yellow,
                                                      max: 25,
                                                      min: 0,
                                                      onChanged:
                                                          (double value) {
                                                        setState(() {
                                                          _intensity = value;
                                                        });
                                                      },
                                                      value: _intensity),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: Iterable
                                                              .generate(6)
                                                          .map((i) => Container(
                                                                height: 5,
                                                                width: 1,
                                                                color:
                                                                    Colors.grey,
                                                              ))
                                                          .toList()),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          SvgPicture.asset(
                                              bulbIntensityHigh)
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Colors',
                                        style: AppTextStyles.subtitleStyle,
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _colors.length,
                                          itemBuilder: (context, i) =>
                                              GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedColor = _colors[i];
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: Tween<
                                                              double>(
                                                          begin: 0, end: 10)
                                                      .animate(CurvedAnimation(
                                                          curve: Curves
                                                              .fastLinearToSlowEaseIn,
                                                          parent: _controller))
                                                      .value),
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _colors[i],
                                              ),
                                              child: i == _colors.length - 1
                                                  ? Icon(
                                                      Icons.add,
                                                      color: AppColors.blue,
                                                    )
                                                  : SizedBox.shrink(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Scenes',
                                        style: AppTextStyles.subtitleStyle,
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        height: 180,
                                        child: GridView.count(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 20,
                                          scrollDirection: Axis.vertical,
                                          childAspectRatio: 2.5,
                                          primary: false,
                                          children: _scenes
                                              .map((scene) => SizedBox(
                                                    height: 20,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                scene.color1,
                                                                scene.color2,
                                                              ])),
                                                      child: Row(
                                                        children: <Widget>[
                                                          SizedBox(width: 30),
                                                          SvgPicture.asset(
                                                            lighteningBulbIcon,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(width: 30),
                                                          Text(
                                                            scene.sceneName,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
//    return AnimatedBuilder(
//        animation: _controller,
//        builder: (context, child) {
//        });
  }

  _topBackground() => Container(
        height: 500,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.darkBlue, AppColors.mediumBlue],
        )),
      );

  _topCircles() => FractionallySizedBox(
        heightFactor: 0.4,
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 50,
                left: -100,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.04)),
                ),
              ),
              Positioned(
                bottom: -100,
                left: (MediaQuery.of(context).size.width / 2) - 100,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.04)),
                ),
              ),
              Positioned(
                top: -30,
                right: -70,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.04)),
                ),
              ),
            ],
          ),
        ),
      );

  _headerWidgets() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 30),
                  Stack(
                    children: <Widget>[
                      Text(
                          '    ${widget.room.roomName.replaceAll(' ', '\n')}',
                          style: AppTextStyles.mainTitleStyle),
                      Positioned(
                        top: 9,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            backIconSvg,
                            height: 18,
                            width: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  FadeTransition(
                    opacity: opacityTween(
                        controller: _controller, begin: 0.0, end: 1),
                    child: SlideTransition(
                      position:
                          Tween<Offset>(begin: Offset(0, -2), end: Offset.zero)
                              .animate(CurvedAnimation(
                                  parent: _controller,
                                  curve: Curves.fastLinearToSlowEaseIn)),
                      child: Text(
                        '${widget.room.lightCount} Light${widget.room.lightCount > 1 ? 's' : ''}',
                        style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          FadeTransition(
            opacity:
                opacityTween(controller: _controller, begin: 0.8, end: 1.0),
            child: SlideTransition(
              position: offsetTween(
                controller: _controller,
                begin: Offset(1, 0.0),
                end: Offset.zero,
              ),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _lights.length,
                    padding: EdgeInsets.only(left: 20),
                    itemBuilder: (context, i) => _lightTile(
                        light: _lights[i],
                        isSelected: selectedLight == i,
                        onSelected: () {
                          setState(() {
                            selectedLight = i;
                          });
                        })),
              ),
            ),
          ),
          Spacer(),
        ],
      );

  _lightTile({LightModel light, bool isSelected, Function onSelected}) =>
      GestureDetector(
        onTap: () => onSelected(),
        child: Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.greenAccent : AppColors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: 16),
              SvgPicture.asset(
                light.iconPath,
                color: isSelected ? AppColors.white : AppColors.greenAccent,
              ),
              SizedBox(width: 10),
              Text(
                light.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        isSelected ? AppColors.white : AppColors.greenAccent),
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
      );
}

class BulbWidget extends StatelessWidget {
  final Color selectedColor;
  final double intensity;

  BulbWidget({this.selectedColor, this.intensity});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 55),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: intensity != 0
                    ? selectedColor
                    : selectedColor.withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: intensity != 0
                          ? selectedColor
                          : selectedColor.withOpacity(0.1),
                      blurRadius: intensity)
                ]),
          ),
        ),
        SizedBox(
          height: 130,
          child: SvgPicture.asset(lampHolder),
        ),
      ],
    );
  }
}
