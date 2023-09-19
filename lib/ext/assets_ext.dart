import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

///本地资源扩展
extension AssetsExt on String {
  ///获取图片位置 通用 assets/images/common
  String asset({String module = 'common', format = 'png'}) {
    return _getCommonPath(path: module);
  }

  ///参数[module] 为图片路径，
  ///return widget
  Widget assetSvg({String module = 'common', double? width, double? height, ColorFilter? colorFilter}) {
    return _assetSvg(module, width: width, height: height, colorFilter: colorFilter);
  }

  ImageProvider assetProvider({String path = 'common'}) {
    return AssetImage(_getCommonPath(format: 'png', path: path));
  }

  //svg 积累
  Widget _assetSvg(String path, {double? width, double? height, ColorFilter? colorFilter}) {
    height ??= width;
    return SvgPicture.asset(
      _getCommonPath(format: 'svg', path: path),
      width: width,
      height: height,
      colorFilter: colorFilter,
      // colorFilter: color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  String _getCommonPath({String format = 'png', String path = 'common'}) {
    return 'assets/images/$path/$this.$format';
  }
}
