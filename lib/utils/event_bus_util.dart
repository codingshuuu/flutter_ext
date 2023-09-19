import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/widgets.dart';

class EventBusUtil {
  static final EventBus eventBus = _eventBus;

  // static fire(event) {
  //   EventBusUtil.eventBus.fire(event);
  // }
  //////////////////////////
  static final EventBus _eventBus = EventBus();

  @Deprecated('Use `SubscriptionMixin` instead')
  static final Map<BuildContext, List<StreamSubscription>> _streamMaps = {};

  @Deprecated('Use `SubscriptionMixin` instead')
  static StreamSubscription<T> listen<T>(BuildContext context, ValueChanged<T> listen) {
    final stream = EventBusUtil._eventBus.on<T>().listen(listen);
    final streams = _streamMaps[context] ?? [];
    streams.add(stream);
    _streamMaps[context] = streams;
    return stream;
  }

  static void fire<T>(T event) => _eventBus.fire(event);

  @Deprecated('Use `SubscriptionMixin` instead')
  static void dispose(BuildContext? context) {
    if (context != null && _streamMaps.isNotEmpty) {
      var streams = _streamMaps[context];
      if (streams != null) {
        for (final stream in streams) {
          stream.cancel();
        }
        streams.clear();
        streams = null;
      }
    }
  }
}
