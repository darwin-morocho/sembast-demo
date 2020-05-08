import 'package:flutter/material.dart';
import 'package:sembast_demo/db/app_theme.dart';
import 'package:sembast_demo/db/db.dart';
import 'package:sembast_demo/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  await MyAppTheme.instance.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    DB.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MyAppTheme.instance,
      child: Consumer<MyAppTheme>(
        builder: (_, myAppTheme, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: MyAppTheme.instance.darkEnabled
                ? ThemeData.dark()
                : ThemeData.light(),
            home: HomePage(),
          );
        },
      ),
    );
  }
}
