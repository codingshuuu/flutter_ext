import 'package:flutter/cupertino.dart';

import 'my_route_observer.dart';
import 'on_route_listener.dart';

///Mixin 路由监听回调
mixin RouteMixin<T extends StatefulWidget> on State<T> implements OnRouteListener {
  @override
  void initState() {
    myRouteObserver.addOnRouteListener(this);
    super.initState();
  }

  @override
  void onRoutePush(String routeName) {}

  @override
  void onRouteRemove(String routeName) {}

  @override
  void dispose() {
    myRouteObserver.removeOnRouteListener(this);
    super.dispose();
  }
}
