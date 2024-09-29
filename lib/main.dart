import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:git_users_info/core/app_settings.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            title: 'Git Users',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            builder: (context, child) {
              return ResponsiveWrapper.builder(
                ScrollConfiguration(
                  behavior: AppScrollBehavior(),
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!,
                  ),
                ),
                maxWidth: (1.sw > 768)
                    ? (1.sw > 1024)
                    ? (1.sw > 1440)
                    ? 0.5.sw
                    : 0.6.sw
                    : 1.sw
                    : 1.sw,
                defaultScale: false,
                defaultScaleFactor: 1.0,
              );

            },
            initialRoute: AppRoutes.all_user_screen,
            getPages: AppPages.listPage,
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
