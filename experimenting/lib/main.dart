import 'package:experimenting/model/custom_icons.dart';
import 'package:experimenting/model/data.dart';
import 'package:flutter/material.dart';
import 'package:experimenting/pages/home.dart';
import 'package:experimenting/model/state_manager.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Eina03',
      ),
      home: ChangeNotifierProvider<StateManager>(
        builder: (_) => StateManager(Strings.countries.first, CustomIcons.globe),
        child: HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
