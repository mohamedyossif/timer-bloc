import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc1/bloc/ticker.dart';
import 'package:timer_bloc1/bloc/timer_event.dart';
import 'package:timer_bloc1/bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent,TimerState>
{    
   final int _duration=120;
    Ticker _ticker=Ticker();
   StreamSubscription _tickerSubScription;
    //initial state
  TimerBloc():super(Ready(120));
  // to recive event from user
  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async*{
   if(event is Start)
   {
     Start start =event;
     yield Running(start.duration);
     //check if there is data,it`ll delete it
     _tickerSubScription?.cancel();
     // flow data from stream ,then call Tick event to return Runnning state 
     _tickerSubScription=_ticker.tick(ticks: start.duration).listen((duration) { 
       add(Tick(duration: duration));
     });
   }
   else if(event is Pause)
   {
    if(state is Running)
    {
      _tickerSubScription?.pause();
      yield Paused(state.duration);
    }
   }
   else if (event is Resume)
   {
     if(state is Paused)
     {
       _tickerSubScription?.resume();
       yield Running(state.duration);
     }
   }
    else if (event is Reset)
    {
      _tickerSubScription?.cancel();
      yield Ready(_duration);
    }
    else if (event is Tick)
    {
      Tick tick=event;
      yield tick.duration>0?Running(tick.duration):Finished(0);
    }
  }
  //delete streams to improve performance app
  @override
  Future<void> close() {
    _tickerSubScription?.cancel();
    return super.close();
  }
  
}