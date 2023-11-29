import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/login_info.dart';

class LoginStateNotifier extends StateNotifier<LoginInfo> {
  LoginStateNotifier(super.state);

  @override
  set state(LoginInfo value) {
    super.state = value;
  }

  @override
  get state => super.state;

  bool isEmpty() {
    return state.email.isEmpty && state.profile.isEmpty && state.name.isEmpty && state.token.isEmpty;
  }
}

final loginStateNotifier = StateNotifierProvider<LoginStateNotifier, LoginInfo>(
  (ref) => LoginStateNotifier(LoginInfo.empty()),
);
