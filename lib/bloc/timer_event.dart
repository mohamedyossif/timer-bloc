import 'package:flutter/cupertino.dart';
 class TimerEvent 
{
  //to made const constructor subclass
  const TimerEvent();
}
class Start extends TimerEvent
{
  final int duration;
  const Start({@required this.duration});
}
class Pause extends TimerEvent{}
class Resume extends TimerEvent{}
class Reset extends TimerEvent{}
class Tick extends TimerEvent
{
  final int duration;
  const Tick({@required this.duration});
 
 
}
