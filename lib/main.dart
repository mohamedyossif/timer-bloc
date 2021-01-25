import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc1/bloc/timer_bloc.dart';
import 'package:timer_bloc1/bloc/timer_event.dart';
import 'package:timer_bloc1/bloc/timer_state.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TimerBloc(),
        child: Home(),
      ),
    );
  }
}

//create home
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer App"),
      ),
      //last in last out with widgets
      body: Stack(
        children: [
          BackGround(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state) {
                    final String minutesSection = ((state.duration / 60) % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    final String secandsSection = (state.duration % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    return Text("$minutesSection : $secandsSection",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),);
                  },
                ),
              ),
              BlocBuilder<TimerBloc, TimerState>(
                  //buildWhen is instead of condition
                  buildWhen: (perviousState, currentState) =>
                      perviousState.runtimeType != currentState.runtimeType,
                      // actionsButton based on events
                  builder: (context, state) => Action()),
            ],
          ),
        ],
      ),
    );
  }
}

//create waves
class BackGround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
          gradients: [
            //first wave
            [
              Color.fromRGBO(72, 74, 126, 1),
              Color.fromRGBO(125, 170, 206, 1),
              Color.fromRGBO(184, 189, 245, 0.7)
            ],
            [
              Color.fromRGBO(72, 74, 126, 1),
              Color.fromRGBO(125, 170, 206, 1),
              Color.fromRGBO(172, 182, 219, 0.7)
            ],
            [
              Color.fromRGBO(72, 73, 126, 1),
              Color.fromRGBO(125, 170, 206, 1),
              Color.fromRGBO(190, 238, 246, 0.7),
            ],
          ],
          //speed wave
          durations: [
            19400,
            10800,
            6000
          ],
          //height wave
          heightPercentages: [
            0.03,
            0.01,
            0.02
          ],
          //start wave
          gradientBegin: Alignment.bottomCenter,
          //end wave
          gradientEnd: Alignment.topCenter),
      size: Size(double.infinity, double.infinity),
    );
  }
}

//create actions Button
class Action extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _mapStateToActionButton(
        //instance of TimerBloc 
          timerBolc: BlocProvider.of<TimerBloc>(context)),
    );
  }
}

List<Widget> _mapStateToActionButton({TimerBloc timerBolc}) {
  final currentState = timerBolc.state;
  if (currentState is Ready) {
    return [
      FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            timerBolc.add(Start(duration: currentState.duration));
          })
    ];
  }
  if (currentState is Running) {
    return [
      FloatingActionButton(
        child: Icon(Icons.pause),
        onPressed: () => timerBolc.add(Pause()),
      ),
      FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: () => timerBolc.add(Reset()),
      ),
    ];
  }
  if(currentState is Paused)
  {
    return [
      FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () => timerBolc.add(Resume()),
      ),
      FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: () => timerBolc.add(Reset()),
      ),
    ];
  }
  if(currentState is Finished)
  {
    return [
      FloatingActionButton(child: Icon(Icons.play_arrow),onPressed:()=>timerBolc.add(Reset())),
    ];
  }
  return [];
}
