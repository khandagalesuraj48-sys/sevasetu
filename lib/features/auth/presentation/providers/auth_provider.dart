import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/auth_remote_ds.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/use_cases/login_usecase.dart';
import '../domain/use_cases/register_usecase.dart';
import '../domain/use_cases/logout_usecase.dart';
import '../data/models/auth_request.dart';
import '../data/models/auth_response.dart';

// ---- Dependencies Providers ----
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl();
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final remoteDS = ref.read(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDS);
});

// ---- Use Cases Providers ----
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return LoginUseCase(repo);
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return RegisterUseCase(repo);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return LogoutUseCase(repo);
});

// ---- Auth State ----
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final UserModel? user;
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserModel? user,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ---- Auth Notifier ----
class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthNotifier(
    this._loginUseCase,
    this._registerUseCase,
    this._logoutUseCase,
  ) : super(const AuthState());

  Future<void> login(String phoneOrEmail, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final request = LoginRequest(phoneOrEmail: phoneOrEmail, password: password);
    final response = await _loginUseCase(request);

    if (response.success && response.user != null) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: response.user,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: response.message ?? 'Login failed',
      );
    }
  }

  Future<void> register(String name, String phone, String password, {String? email}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final request = RegisterRequest(
      name: name,
      phone: phone,
      email: email,
      password: password,
    );
    final response = await _registerUseCase(request);

    if (response.success && response.user != null) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: response.user,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: response.message ?? 'Registration failed',
      );
    }
  }

  Future<void> logout(String token) async {
    state = state.copyWith(isLoading: true);
    await _logoutUseCase(token);
    state = const AuthState();
  }

  void resetError() {
    state = state.copyWith(errorMessage: null);
  }
}

// ---- Auth Provider ----
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUC = ref.read(loginUseCaseProvider);
  final registerUC = ref.read(registerUseCaseProvider);
  final logoutUC = ref.read(logoutUseCaseProvider);
  return AuthNotifier(loginUC, registerUC, logoutUC);
});