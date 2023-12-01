import 'package:flutter/foundation.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Social Login Example'),
        ),
        body: const FacebookLoginPageView(),
      ),
    );
  }
}

// * 페이스북 관련 위젯
class FacebookLoginPageView extends ConsumerWidget {
  const FacebookLoginPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool loginStatus = ref.watch(facebookLoginStateProvider);

    return Center(
      child: Column(children: [
        ElevatedButton(
          onPressed: () async {
            final (bool, String?) result = await ref.read(facebookLoginStateProvider.notifier).login();
            if (kDebugMode) {
              if (result.$2 != null) {
                print('error Message: ${result.$2 ?? ''}');
              }
            }
          },
          child: Text(loginStatus ? "LogOut" : "LogIn"),
        )
      ]),
    );
  }
}
