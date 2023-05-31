import 'package:bloc_counter/blocs/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'OtherPAge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterBloc, CounterState>(
      listener: (context, state) {
        if (state.counter == 3) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Current state is: ${state.counter}"),
                );
              });
        } else if (state.counter == -1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const OtherPage();
              },
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Counter Bloc"),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(DecrementCounterEvent());
              },
              heroTag: "minus",
              child: const Icon(Icons.remove),
            ),
            const SizedBox(
              width: 16,
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(IncrementCounterEvent());
              },
              heroTag: "addition",
              child: const Icon(Icons.add),
            ),
          ],
        ),
        body: Center(
          child: Text(
            '${context.watch<CounterBloc>().state.counter}',
            style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
