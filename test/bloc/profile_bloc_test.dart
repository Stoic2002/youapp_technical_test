import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youapp_technical_test/data/models/profile_model.dart';
import 'package:youapp_technical_test/data/repositories/profile_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:youapp_technical_test/presentation/bloc/profile/profile_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'profile_bloc_test.mocks.dart';

class MockStorage extends Mock implements Storage {}

@GenerateMocks([ProfileRepository])
void main() {
  late ProfileBloc profileBloc;
  late MockProfileRepository mockProfileRepository;
  late Storage storage;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    storage = MockStorage();
    HydratedBloc.storage = storage;

    mockProfileRepository = MockProfileRepository();
    profileBloc = ProfileBloc(profileRepository: mockProfileRepository);
  });

  tearDown(() {
    profileBloc.close();
  });

  group('ProfileBloc', () {
    final testProfileModel = ProfileModel(
      email: 'test@test.com',
      username: 'testUser',
      name: 'Test Name',
      birthday: '15 May 2002',
      zodiac: 'Taurus',
      horoscope: 'Taurus',
      height: 170,
      weight: 60,
      interests: ['music', 'reading'],
    );

    test('initial state is ProfileInitial', () {
      expect(profileBloc.state, isA<ProfileInitial>());
    });

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileLoaded] when CreateProfileEvent is added successfully',
      build: () {
        when(mockProfileRepository.createProfile(any))
            .thenAnswer((_) async => testProfileModel);
        return profileBloc;
      },
      act: (bloc) => bloc.add(CreateProfileEvent(testProfileModel)),
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileLoaded>(),
      ],
      verify: (bloc) {
        verify(mockProfileRepository.createProfile(testProfileModel)).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileLoaded] when fetching profile successfully',
      build: () {
        when(mockProfileRepository.getProfile())
            .thenAnswer((_) async => testProfileModel);
        return profileBloc;
      },
      act: (bloc) => bloc.add(GetProfileEvent()),
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileLoaded>(),
      ],
      verify: (bloc) {
        verify(mockProfileRepository.getProfile()).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileLoaded] when updating profile successfully',
      build: () {
        when(mockProfileRepository.updateProfile(any))
            .thenAnswer((_) async => testProfileModel);
        return profileBloc;
      },
      act: (bloc) => bloc.add(UpdateProfileEvent(testProfileModel)),
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileLoaded>(),
      ],
      verify: (bloc) {
        verify(mockProfileRepository.updateProfile(testProfileModel)).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileError] when fetching profile fails',
      build: () {
        when(mockProfileRepository.getProfile())
            .thenThrow(Exception('Failed to fetch profile'));
        return profileBloc;
      },
      act: (bloc) => bloc.add(GetProfileEvent()),
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileError>(),
      ],
      verify: (bloc) {
        verify(mockProfileRepository.getProfile()).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileError] when updating profile fails',
      build: () {
        when(mockProfileRepository.updateProfile(any))
            .thenThrow(Exception('Failed to update profile'));
        return profileBloc;
      },
      act: (bloc) => bloc.add(UpdateProfileEvent(testProfileModel)),
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileError>(),
      ],
      verify: (bloc) {
        verify(mockProfileRepository.updateProfile(testProfileModel)).called(1);
      },
    );
  });
}
