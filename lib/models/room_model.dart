import 'package:flutter/cupertino.dart';

class RoomModel {
  RoomModel({
    @required this.roomName,
    @required this.iconPath,
    this.lightCount = 0,
  });

  String roomName;
  String iconPath;
  int lightCount;

  static List<RoomModel> getSampleData() => [
        RoomModel(
          roomName: 'Bed room',
          iconPath: 'assets/images/bed.svg',
          lightCount: 4,
        ),
        RoomModel(
          roomName: 'Living room',
          iconPath: 'assets/images/room.svg',
          lightCount: 2,
        ),
        RoomModel(
          roomName: 'Kitchen',
          iconPath: 'assets/images/kitchen.svg',
          lightCount: 5,
        ),
        RoomModel(
          roomName: 'Bathroom',
          iconPath: 'assets/images/bathtube.svg',
          lightCount: 1,
        ),
        RoomModel(
          roomName: 'Outdoor',
          iconPath: 'assets/images/house.svg',
          lightCount: 5,
        ),
        RoomModel(
          roomName: 'Balcony',
          iconPath: 'assets/images/balcony.svg',
          lightCount: 2,
        ),
      ];
}
