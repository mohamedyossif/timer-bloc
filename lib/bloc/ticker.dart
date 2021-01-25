class Ticker 
{
  //flow timer data  
  Stream<int>tick({int ticks})=> Stream.periodic(Duration(seconds: 1),(index)=>ticks - index-1).take(ticks);
  
}