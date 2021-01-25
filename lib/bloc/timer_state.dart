//this is class to enable sent any event which inherited from it 
 class TimerState 
{
final int duration;
const TimerState(this.duration);
}
class Ready extends TimerState
{
 const Ready(int duration) : super(duration);
  
}
class Running extends TimerState
{
 const Running(int duration) : super(duration);
  
}
class Paused extends TimerState
{
 const Paused(int duration) : super(duration);
  
}
class Finished extends TimerState
{
 const Finished(int duration) : super(0);
  
}
