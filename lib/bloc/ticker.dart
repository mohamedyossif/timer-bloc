class Ticker 
{
  Stream<int>tick({int ticks})=> Stream.periodic(Duration(seconds: 1),(index)=>ticks - index-1).take(ticks);
  
}