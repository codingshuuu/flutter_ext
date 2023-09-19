import 'dart:ui';

///
extension BoolExt on bool {
  void yes(VoidCallback callback) {
    if (this) {
      return callback.call();
    }
  }

  void no(VoidCallback callback) {
    if (!this) {
      callback.call();
    }
  }

  void yesno(VoidCallback? yesCallback, VoidCallback? noCallback) {
    if (this) {
      yesCallback?.call();
    } else {
      noCallback?.call();
    }
  }

  ///异步
  Future<void> yesF(Function callback) async {
    if (this) {
      await callback.call();
    }
  }

  Future<void> noF(Function callback) async {
    if (this) {
      await callback.call();
    }
  }
}
