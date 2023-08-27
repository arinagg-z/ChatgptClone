import 'package:chatgptclone/provider/chatprovider.dart';
import 'package:chatgptclone/provider/model_proivder.dart';
import 'package:chatgptclone/screens/chatscreen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => modelprovider()),
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: MaterialApp(
        title: 'ChatGpt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: chatscreen(),
      ),
    );
  }
}
