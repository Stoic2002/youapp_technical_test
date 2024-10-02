import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_technical_test/data/models/auth_model.dart';
import 'package:youapp_technical_test/data/repositories/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:youapp_technical_test/presentation/bloc/auth/auth_bloc.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late AuthBloc authBloc;
  late AuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    final testAuthModel = AuthModel(
      email: 'test@test.com',
      userName: 'testUser',
      password: 'password',
    );

    test('initial state is AuthInitial', () {
      expect(authBloc.state, isA<AuthInitial>());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthUnauthenticated] when registering successfully',
      build: () {
        when(mockAuthRepository.register(testAuthModel))
            .thenAnswer((_) async => 'register successful');
        return authBloc;
      },
      act: (bloc) => bloc.add(RegisterEvent(authModel: testAuthModel)),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthUnauthenticated>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when logging in successfully',
      build: () {
        when(mockAuthRepository.login(testAuthModel))
            .thenAnswer((_) async => "login successful");
        when(mockAuthRepository.isLoggedIn()).thenAnswer((_) async => true);
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginEvent(authModel: testAuthModel)),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthAuthenticated>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthUnauthenticated] when logging out successfully',
      build: () {
        when(mockAuthRepository.logout()).thenAnswer((_) async => {});
        return authBloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: () => [isA<AuthUnauthenticated>()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when registration fails',
      build: () {
        when(mockAuthRepository.register(testAuthModel))
            .thenThrow(Exception('Registration failed'));
        return authBloc;
      },
      act: (bloc) => bloc.add(RegisterEvent(authModel: testAuthModel)),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when login fails',
      build: () {
        when(mockAuthRepository.login(testAuthModel))
            .thenThrow(Exception('Login failed'));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginEvent(authModel: testAuthModel)),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
    );
  });
}
