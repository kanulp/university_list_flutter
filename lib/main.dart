import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:university_list/src/viewmodel/university_list_viewmodel.dart';
import 'src/ui/home_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UniversityViewModel(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(),
          primarySwatch: Colors.lightBlue,
        ),
        home: const HomePage(),
        // initialRoute: '/',
        // routes: {
        //     '/': (context) => const HomePage(),
        //   },
      ),
    );
  }
}
