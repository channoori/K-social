import 'package:flutter/material.dart';

import 'views/login_detail_page_view.dart';

class LoginDetailPage extends StatelessWidget {
  const LoginDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Detail'),
      ),
      body: const LoginDetailPageView(),
    );
  }
}
