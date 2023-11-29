import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/facebook_login_state_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Social Plugin for Korea'),
        ),
        body: const FacebookLoginPageView(),
      ),
    );
  }
}

class FacebookLoginPageView extends ConsumerWidget {
  const FacebookLoginPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool loginStatus = ref.watch(facebookLoginStateProvider);

    return Column(children: [
      ElevatedButton(
        onPressed: () async {
          await ref.read(facebookLoginStateProvider.notifier).login();
        },
        child: Text(loginStatus ? "LogOut" : "LogIn"),
      )
    ]);
  }
}
