import 'package:fl_xcel/widgets/constants.dart';
import 'package:flutter/cupertino.dart';


class SceneModel {
  SceneModel({
    @required this.sceneName,
    @required this.color1,
    @required this.color2,
  });

  String sceneName;
  Color color1;
  Color color2;

  static List<SceneModel> getSampleData() => [
        SceneModel(
          sceneName: 'Birthday',
          color1: AppColors.lightColorRed,
          color2: AppColors.lightColorRed.withOpacity(0.6),
        ),
        SceneModel(
          sceneName: 'Party',
          color1: AppColors.lightColorPurple,
          color2: AppColors.lightColorPurple.withOpacity(0.6),
        ),
        SceneModel(
          sceneName: 'Relax',
          color1: AppColors.lightColorBlue,
          color2: AppColors.lightColorBlue.withOpacity(0.6),
        ),
        SceneModel(
          sceneName: 'Fun',
          color1: AppColors.lightColorGreen,
          color2: AppColors.lightColorGreen.withOpacity(0.6),
        ),
      ];
}
