import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SingleTickerProvider<T extends StatefulWidget> implements TickerProvider {
  Ticker _ticker;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _ticker = Ticker(onTick, debugLabel: kDebugMode ? 'created by $this' : null);
    return _ticker;
  }
}
