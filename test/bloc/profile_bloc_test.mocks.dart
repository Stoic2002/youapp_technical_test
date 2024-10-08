// Mocks generated by Mockito 5.4.4 from annotations
// in youapp_technical_test/test/bloc/profile_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:youapp_technical_test/data/models/profile_model.dart' as _i3;
import 'package:youapp_technical_test/data/repositories/profile_repository.dart'
    as _i4;
import 'package:youapp_technical_test/data/repositories/token_repository.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTokenRepository_0 extends _i1.SmartFake
    implements _i2.TokenRepository {
  _FakeTokenRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeProfileModel_1 extends _i1.SmartFake implements _i3.ProfileModel {
  _FakeProfileModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProfileRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockProfileRepository extends _i1.Mock implements _i4.ProfileRepository {
  MockProfileRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TokenRepository get tokenRepo => (super.noSuchMethod(
        Invocation.getter(#tokenRepo),
        returnValue: _FakeTokenRepository_0(
          this,
          Invocation.getter(#tokenRepo),
        ),
      ) as _i2.TokenRepository);

  @override
  _i5.Future<_i3.ProfileModel> createProfile(_i3.ProfileModel? profile) =>
      (super.noSuchMethod(
        Invocation.method(
          #createProfile,
          [profile],
        ),
        returnValue: _i5.Future<_i3.ProfileModel>.value(_FakeProfileModel_1(
          this,
          Invocation.method(
            #createProfile,
            [profile],
          ),
        )),
      ) as _i5.Future<_i3.ProfileModel>);

  @override
  _i5.Future<_i3.ProfileModel> getProfile() => (super.noSuchMethod(
        Invocation.method(
          #getProfile,
          [],
        ),
        returnValue: _i5.Future<_i3.ProfileModel>.value(_FakeProfileModel_1(
          this,
          Invocation.method(
            #getProfile,
            [],
          ),
        )),
      ) as _i5.Future<_i3.ProfileModel>);

  @override
  _i5.Future<_i3.ProfileModel> updateProfile(_i3.ProfileModel? profile) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProfile,
          [profile],
        ),
        returnValue: _i5.Future<_i3.ProfileModel>.value(_FakeProfileModel_1(
          this,
          Invocation.method(
            #updateProfile,
            [profile],
          ),
        )),
      ) as _i5.Future<_i3.ProfileModel>);
}
