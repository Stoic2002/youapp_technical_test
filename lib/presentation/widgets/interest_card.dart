import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youapp_technical_test/core/constants/app_colors.dart';
import 'package:youapp_technical_test/data/models/profile_model.dart';

class InterestCard extends StatelessWidget {
  final ProfileModel profile;
  const InterestCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        constraints: const BoxConstraints(minHeight: 109),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: AppColors.card),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 27),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Interest',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         InterestPage(profile: profile)));
                        context.push('/interest', extra: profile);
                      },
                      icon: Image.asset(
                        'assets/icons/edit.png',
                        color: Colors.white,
                        width: 17,
                        height: 17,
                      ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 27, right: 57),
              width: MediaQuery.of(context).size.width,
              child: profile.interests.isNotEmpty
                  ? Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: profile.interests
                          .map((interest) => InterestChip(label: interest))
                          .toList(),
                    )
                  : Text(
                      'Add in your interest to find a better match',
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(0.5)),
                    ),
            ),
            const SizedBox(height: 26)
          ],
        ));
  }
}

class InterestChip extends StatelessWidget {
  final String label;

  const InterestChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        label,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
