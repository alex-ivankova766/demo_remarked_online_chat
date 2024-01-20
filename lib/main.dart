import 'package:flutter/material.dart';
import 'package:remarked_online_chat/ui_components/screens/chat_screen.dart';

import 'ui_config/ui_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Room Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Main page from project"),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.message),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatRoomScreen(
                      chatUiConfigurator: uiConfig,
                    )))),
        body: const Center(child: Text('It is a project screen')));
  }
}
