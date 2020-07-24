import 'package:flutter/material.dart';
import 'package:flutter_intl_app/localization/AppLanguage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'localization/AppLocalizations.dart';
import 'localization/Languages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  AppLanguage appLanguage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) {
        appLanguage = AppLanguage();
        return appLanguage;
      },
      child: Consumer<AppLanguage>(
        builder: (context, AppLanguage value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            locale: value.appLocal,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: SUPPORTED_LOCALES.map((locale) => locale),
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLanguage appLanguage = Provider.of<AppLanguage>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter i18n"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(translate(
                context, "you_have_pushed_the_button_this_many_times")),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              child: Text("Para EN"),
              onPressed: () {
                appLanguage.changeLanguage(Locale("en"));
              },
            ),
            RaisedButton(
              child: Text("Para PT"),
              onPressed: () {
                appLanguage.changeLanguage(Locale("pt", "BR"));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: translate(context, "increment"),
        child: Icon(Icons.add),
      ),
    );
  }

  String translate(context, key) {
    return AppLocalizations.of(context).translate(key);
  }
}
