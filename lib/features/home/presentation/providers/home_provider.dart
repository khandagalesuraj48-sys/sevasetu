import 'package:flutter_riverpod/flutter_riverpod.dart';

// ---- Home State ----
class HomeState {
  final int selectedIndex;
  final bool isLoading;

  const HomeState({
    this.selectedIndex = 0,
    this.isLoading = false,
  });

  HomeState copyWith({
    int? selectedIndex,
    bool? isLoading,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// ---- Home Notifier ----
class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  void changeTab(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }
}

// ---- Home Provider ----
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});