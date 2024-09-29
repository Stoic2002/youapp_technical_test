import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youapp_technical_test/core/constants/app_colors.dart';
import 'package:youapp_technical_test/core/extensions/horoscope_extension.dart';
import 'package:youapp_technical_test/core/extensions/zodiac_extension.dart';
import 'package:youapp_technical_test/data/models/profile_model.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel profile;
  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(18),
        width: MediaQuery.of(context).size.width,
        height: 190,
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    'https://images.unsplash.com/photo-1727463995295-3505cb692ebb?q=80&w=2874&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')),
            borderRadius: BorderRadius.circular(16),
            color: AppColors.photoCard),
        child: profile.name != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    '@${profile.name}, 22',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Male',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(16)),
                        height: 36,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(width: 16),
                            if (profile.birthday != null)
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: Image.asset(
                                  color: Colors.white,
                                  profile.birthday!.getHoroscopeIcon(),
                                ),
                              ),
                            const SizedBox(width: 1.5),
                            if (profile.birthday != null)
                              Text(
                                profile.birthday!.getHoroscope(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(16)),
                        height: 36,
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            if (profile.birthday != null)
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: Image.asset(
                                  profile.birthday!.getChineseZodiacIcon(),
                                ),
                              ),
                            const SizedBox(width: 5),
                            if (profile.birthday != null)
                              Text(
                                profile.birthday!.getChineseZodiac(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    '@${profile.username}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ],
              ));
  }
}
