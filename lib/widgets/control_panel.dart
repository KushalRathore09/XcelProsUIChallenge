import 'package:fl_xcel/models/room_model.dart';
import 'package:fl_xcel/screens/room.dart';
import 'package:fl_xcel/utils/fade_page.dart';
import 'package:fl_xcel/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'common_widgets.dart';


class ControlPanelRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavMenu(),
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _topBackground(),
              _topCircles(),
            ],
          ),
          Container(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Control\nPanel',
                          style: AppTextStyles.mainTitleStyle,
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/user.png',
                          width: 80,
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Hero(
                      flightShuttleBuilder: flightShuttleBuilder,
                      tag: 'room_data_tag',
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightWhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              child: Text(
                                'All Rooms',
                                style: AppTextStyles.subtitleStyle,
                              ),
                              padding: EdgeInsets.only(
                                top: 25,
                                left: 20,
                                right: 20,
                                bottom: 10,
                              ),
                            ),
                            Expanded(
                              child: GridView.count(
                                padding: EdgeInsets.all(20),
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                children: RoomModel.getSampleData()
                                    .map<Widget>(
                                        (room) => roomTile(room, context))
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  roomTile(RoomModel room, BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.push(context, FadePage(widget: RoomScreen(room: room)));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(color: AppColors.blue.withOpacity(0.1), blurRadius: 10)
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(
                room.iconPath,
                height: 55,
                width: 55,
              ),
              Spacer(flex: 1),
              Text(
                room.roomName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '${room.lightCount} Light${room.lightCount > 1 ? 's' : ''}',
                style: TextStyle(
                    color: AppColors.orange,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );

  _topBackground() => Container(
        height: 250,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.darkBlue, AppColors.mediumBlue],
        )),
      );

  _topCircles() => Container(
        height: 200,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 70,
              left: -50,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.04)),
              ),
            ),
            Positioned(
              bottom: -170,
              left: 0,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.04)),
              ),
            ),
            Positioned(
              bottom: -90,
              right: -100,
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
      );
}
