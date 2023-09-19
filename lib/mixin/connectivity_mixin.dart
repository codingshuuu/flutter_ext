import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

///网络状态监听
mixin ConnectivityMixin<T extends StatefulWidget> on State<T> {
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult c) =>
        onConnectivityChanged(c == ConnectivityResult.mobile || c == ConnectivityResult.wifi));
  }

  void onConnectivityChanged(bool connected) {
    // LogUtil.v('onConnectivityChanged:$connected');
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
