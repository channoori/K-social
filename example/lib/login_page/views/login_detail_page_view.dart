import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_social/facebook/data/models/social_user.dart';

import '../../core/facebook_login_state_provider.dart';
import '../../core/user_state_provider.dart';

class LoginDetailPageView extends ConsumerStatefulWidget {
  const LoginDetailPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginDetailPageViewState();
}

class _LoginDetailPageViewState extends ConsumerState<LoginDetailPageView> {
  @override
  Widget build(BuildContext context) {
    final SocialUser user = ref.watch(userStateProvider);
    return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        InfoRow(
          title: '이름',
          content: user.facebookUser?.name ?? 'unknown name',
        ),
        InfoRow(
          title: 'ID',
          content: user.facebookUser?.id ?? 'unknown id',
        ),
        InfoRow(
          title: '이메일',
          content: user.facebookUser?.email ?? 'unknown email',
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () async {
            final result = await ref.read(facebookLoginStateProvider.notifier).logout();
            if (result) {
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          child: const Text('logout'),
        )
      ]),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 70,
          child: Text(title),
        ),
        Text(content),
      ],
    );
  }
}
