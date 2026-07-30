import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class ThemeNotifier {
  final Ref ref;
  ThemeNotifier(this.ref);

  void toggleTheme() {
    final current = ref.read(themeModeProvider);
    ref.read(themeModeProvider.notifier).state =
        current == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setSystem() {
    ref.read(themeModeProvider.notifier).state = ThemeMode.system;
  }
}

final themeNotifierProvider = Provider<ThemeNotifier>((ref) {
  return ThemeNotifier(ref);
});