library awesome_ext;

import 'package:flustars_flutter3/flustars_flutter3.dart';

export 'package:flustars_flutter3/flustars_flutter3.dart';
import 'utils/log/log_file_util.dart';
export 'ext/index.dart';
export 'mixin/index.dart';
export 'utils/index.dart';
export 'model/index.dart';
export 'widget/index.dart';

class AwesomeExt {
  static Future<void> init() async {
    //如果用到适配、要设置一下设计稿的宽高
    // setDesignWHD();
    await SpUtil.getInstance();
    LogFileUtil.initLogger();
  }
}
