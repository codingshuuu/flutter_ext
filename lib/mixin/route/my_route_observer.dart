

import 'package:flutter/material.dart';

import 'on_route_listener.dart';


@protected
MyRouteObserver<PageRoute> myRouteObserver = MyRouteObserver<PageRoute>();

class MyRouteObserver<R extends Route<dynamic>> extends RouteObserver<R> {

  final List<String> _routeList = [];
  final List<OnRouteListener> _onRouteList = [];

  void addOnRouteListener(OnRouteListener listener){
    _onRouteList.add(listener);
  }

  void removeOnRouteListener(OnRouteListener listener){
    _onRouteList.remove(listener);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _addRoute(route);
    debugPrint('didPush route: ${route.settings.name},previousRoute:${previousRoute?.settings.name}');
  }

  String get topRouteName => _routeList.isNotEmpty?_routeList.last:'';
  
  bool hasRouteName(String routeName){
    return _routeList.contains(routeName);
  }
  
  void _addRoute(Route<dynamic> route){
    if(route.settings.name?.isNotEmpty??false){
      _routeList.add(route.settings.name!);
      for (var element in _onRouteList) {
        element.onRoutePush(route.settings.name!);
      }
    }
  }

  void _removeRoute(Route<dynamic> route){
    if(route.settings.name?.isNotEmpty??false){
      _routeList.remove(route.settings.name!);
      for (var element in _onRouteList) {
        element.onRouteRemove(route.settings.name!);
      }
    }
  }
  
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _removeRoute(route);
    debugPrint('didPop route: $route,previousRoute:$previousRoute');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _addRoute(newRoute!);
    debugPrint('didReplace newRoute: $newRoute,oldRoute:$oldRoute');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _removeRoute(route);
    debugPrint('didRemove route: $route,previousRoute:$previousRoute');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    debugPrint('didStartUserGesture route: $route,previousRoute:$previousRoute');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    debugPrint('didStopUserGesture');
  }
}