import 'dart:async';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;

  // For events, exposing only a sink which is an input
  final _counterEventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  // For state, exposing only a stream which outputs data
  final _counterStateController = StreamController<int>();

  Stream<int> get counter => _counterStateController.stream;

  CounterBloc() {
    // whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }

    _counterStateController.sink.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }

}
