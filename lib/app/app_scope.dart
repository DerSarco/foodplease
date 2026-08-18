import 'package:flutter/material.dart';

import 'app_state.dart';

class Scope extends InheritedNotifier<AppState> {
  const Scope({super.key, required AppState state, required super.child})
    : super(notifier: state);
  static AppState of(BuildContext c) =>
      c.dependOnInheritedWidgetOfExactType<Scope>()!.notifier!;
}
