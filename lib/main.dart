import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/grid/grid.dart';
import 'package:schrodle/keyboard/keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GridBloc>(
            create: (context) => GridBloc()..add(LoadGrid()),
          ),
          BlocProvider<KeyboardBloc>(
            create: (context) => KeyboardBloc()..add(LoadKeyboard()),
          ),
        ],
        child: const Column(
          children: [
            Center(child: Grid()),
            Keyboard(),
          ],
        ),
      ),
    );
  }
}
