import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:youapp_technical_test/presentation/bloc/auth/auth_bloc.dart';
import 'package:youapp_technical_test/presentation/bloc/profile/profile_bloc.dart';
import 'package:youapp_technical_test/core/constants/app_colors.dart';
import 'package:youapp_technical_test/data/models/profile_model.dart';
import 'package:youapp_technical_test/data/repositories/token_repository.dart';
import 'package:youapp_technical_test/presentation/widgets/about_card.dart';
import 'package:youapp_technical_test/presentation/widgets/interest_card.dart';
import 'package:youapp_technical_test/presentation/widgets/profile_card.dart';
import 'package:youapp_technical_test/presentation/widgets/update_profile_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TokenRepository tokenRepo = TokenRepository();
  bool isEditMode = false;
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<ProfileBloc>().add(GetProfileEvent());
  // }

  void _onSaveProfile(ProfileModel updatedProfile) {
    context.read<ProfileBloc>().add(UpdateProfileEvent(updatedProfile));
    setState(() {
      isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Container(
            color: AppColors.mainBackground,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is ProfileLoaded) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                color: AppColors.mainBackground,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 81,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 18, right: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('           '),
                            Text(
                              '@${state.profile.username}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            PopupMenuButton<int>(
                              icon: Image.asset('assets/icons/hambaga.png'),
                              onSelected: (value) {
                                if (value == 0) {
                                  _logout(context);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 0,
                                  child: Row(
                                    children: [
                                      Icon(Icons.logout, color: Colors.black),
                                      SizedBox(width: 8),
                                      Text("Logout"),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                    const SizedBox(height: 28.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: [
                          ProfileCard(profile: state.profile),
                          const SizedBox(height: 24),
                          !isEditMode
                              ? AboutCard(
                                  profile: state.profile,
                                  onpressed: () {
                                    setState(() {
                                      isEditMode = !isEditMode;
                                    });
                                  },
                                )
                              : UpdateProfileCard(
                                  profile: state.profile,
                                  onSave: _onSaveProfile,
                                ),
                          const SizedBox(height: 18),
                          InterestCard(
                            profile: state.profile,
                          ),
                          const SizedBox(height: 95),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is ProfileError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(fontSize: 16),
            ),
          );
        }
        return Container(
          color: AppColors.mainBackground,
        );
      },
    );
  }

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutEvent());
    HydratedBloc.storage.clear();
    context.go('/login');
  }
}
