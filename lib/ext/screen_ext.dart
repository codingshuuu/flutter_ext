
import 'package:flustars_flutter3/flustars_flutter3.dart';
class ScreenExt {
  static double getWidth(double sizePx) => sizePx.w;

  static double getHeight(double sizePx) => sizePx.w;

  static double getSp(double sizePx) => sizePx.sp;

  static double getScreenWidth() => ScreenUtil.getInstance().screenWidth;

  static double getScreenHeight() => ScreenUtil.getInstance().screenHeight;
}

extension DensityIntExt on num {
  double get w =>ScreenUtil.getInstance().getWidth(toDouble());

  double get h =>  ScreenUtil.getInstance().getWidth(toDouble()) ;

  double get sp => ScreenUtil.getInstance().getSp(toDouble());
}
