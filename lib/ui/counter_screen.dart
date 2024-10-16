import 'package:database_practice/bloc/counter/counter_bloc.dart';
import 'package:database_practice/bloc/counter/counter_event.dart';
import 'package:database_practice/bloc/counter/counter_state.dart';
import 'package:database_practice/bloc/switch/switch_bloc.dart';
import 'package:database_practice/bloc/switch/switch_event.dart';
import 'package:database_practice/bloc/switch/switch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Center(
                  child: Text(
                    state.counter.toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(IncrementCounter());
                    },
                    child: Text("Incerment")),
                ElevatedButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(DecrementCounter());
                    },
                    child: Text("Decrement"))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Notification"),
                  BlocBuilder<SwitchBloc, SwitchState>(
                    buildWhen: (previous,current)=>previous.isSwitch!=current.isSwitch,
                    builder: (context, state) {
                      
                      return Switch(
                          value: state.isSwitch,
                          onChanged: (newvalue) {
                            context
                                .read<SwitchBloc>()
                                .add(EnableOrDisableNotification());
                          });
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Container(
                  height: 200,
                  color: Colors.red.withOpacity(state.slider),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous,current)=>previous.slider!=current.slider
,
              builder: (context, state) {
                return Slider(
                    value: state.slider,
                    onChanged: (value) {
                      context.read<SwitchBloc>().add(SliderEvent(slider: value));
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
