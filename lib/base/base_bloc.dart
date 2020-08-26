import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'base_event.dart';

abstract class  BaseBloc{
  StreamController<BaseEvent> _eventStreamController = StreamController<BaseEvent>();
  // Day event vao String
  Sink<BaseEvent> get event => _eventStreamController.sink;

  // Constructor Listening Events from widget
  BaseBloc(){
    _eventStreamController.stream.listen((event) {
        if(event is! BaseEvent){
          throw Exception("Event khong hop le");
        }
        // sao khi pass qua event tren
        disPatchEvent(event);
    });
  }
//bat buoc override disPatchEvent khi extend baseEvent de gia tri event day vao ham da extend
  void disPatchEvent(BaseEvent event);
  // Close Stream lai
  @mustCallSuper
  void dispose(){
      _eventStreamController.close();}
}