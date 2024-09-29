part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class CreateProfileEvent extends ProfileEvent {
  final ProfileModel profile;

  const CreateProfileEvent(this.profile);

  @override
  List<Object> get props => [profile];
}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final ProfileModel profile;

  const UpdateProfileEvent(this.profile);

  @override
  List<Object> get props => [profile];
}

class UpdateInterest extends ProfileEvent {
  final List<String> interests;

  const UpdateInterest(this.interests);

  @override
  List<Object> get props => [interests];
}
