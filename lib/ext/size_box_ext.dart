
import 'package:flutter/cupertino.dart';

import 'screen_ext.dart';

extension SizeboxExt on num {
  Widget get sizedBoxH {
    return SizedBox(
      height: h,
    );
  }

  Widget get sizedBoxW {
    return SizedBox(
      width: w,
    );
  }

  SizedBox get widthSpace {
    return SizedBox(
      width: w,
    );
  }

  SizedBox get heightSpace {
    return SizedBox(
      height: h,
    );
  }
}

extension SizeBoxDoubleExt on double {
  SizedBox get widthSpace {
    return SizedBox(
      width: w,
    );
  }

  SizedBox get heightSpace {
    return SizedBox(
      height: h,
    );
  }
}
