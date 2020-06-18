import 'package:flutter_screenutil/screenutil.dart';

class ScreenHelper {
  // SPACE
  static dynamicHeight(double height) => ScreenUtil().setHeight(height);
  static dynamicWidth(double width) => ScreenUtil().setWidth(width);
  static dynamicSp(double fontsize) => ScreenUtil().setSp(fontsize);
}
