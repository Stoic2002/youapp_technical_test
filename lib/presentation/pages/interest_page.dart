import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:youapp_technical_test/presentation/bloc/profile/profile_bloc.dart';
import 'package:youapp_technical_test/core/constants/app_colors.dart';
import 'package:youapp_technical_test/data/models/profile_model.dart';
import 'package:youapp_technical_test/presentation/widgets/custom_back_button.dart';
import 'package:youapp_technical_test/presentation/widgets/gardient_text.dart';
import 'package:youapp_technical_test/presentation/widgets/interest_custom_textfield.dart';

class InterestPage extends StatefulWidget {
  final ProfileModel profile;
  const InterestPage({super.key, required this.profile});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  List<String> displayedInterests = [];

  void _saveInterests() {
    context.read<ProfileBloc>().add(UpdateProfileEvent(
          ProfileModel(
              interests: displayedInterests,
              email: widget.profile.email,
              username: widget.profile.username,
              name: widget.profile.name,
              birthday: widget.profile.birthday,
              height: widget.profile.height,
              weight: widget.profile.weight),
        ));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          displayedInterests = state.profile
              .copyWith(interests: widget.profile.interests)
              .interests;
          return Scaffold(
            body: Container(
              decoration:
                  const BoxDecoration(gradient: AppColors.backgroundGradient),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 81),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomBackButton(),
                        InkWell(
                          onTap: _saveInterests,
                          child: const GradientText(
                            text: 'Save',
                            gradient: AppColors.goldenGradient,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 73.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 35),
                    child: GradientText(
                      text: 'Tell everyone about yourself',
                      gradient: AppColors.goldenGradient,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.only(left: 35),
                    child: Text(
                      'What interest you?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 27),
                    child: InterestCustomTextfield(
                      interests: displayedInterests,
                      onInterestAdded: (interest) {
                        setState(() {
                          displayedInterests.add(interest);
                        });
                      },
                      onInterestRemoved: (interest) {
                        setState(() {
                          displayedInterests.remove(interest);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          decoration:
              const BoxDecoration(gradient: AppColors.backgroundGradient),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
