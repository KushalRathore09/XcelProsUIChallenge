import 'package:flutter/cupertino.dart';

class LightModel {
  String name;
  String iconPath;

  LightModel({
    @required this.name,
    @required this.iconPath,
  });

  static List<LightModel> sampleLights() => [
        LightModel(
            name: 'Main Light',
            iconPath: 'assets/images/lightening_bulb_icon.svg'),
        LightModel(
            name: 'Desk Lights', iconPath: 'assets/images/desk_light_icon.svg'),
        LightModel(
            name: 'Bed Light', iconPath: 'assets/images/bed_light_icon.svg'),
      ];
}
