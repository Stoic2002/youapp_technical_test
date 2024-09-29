import 'package:flutter/material.dart';
import 'package:youapp_technical_test/core/constants/app_colors.dart';
import 'package:youapp_technical_test/core/extensions/age_extension.dart';
import 'package:youapp_technical_test/core/extensions/horoscope_extension.dart';
import 'package:youapp_technical_test/core/extensions/zodiac_extension.dart';
import 'package:youapp_technical_test/data/models/profile_model.dart';

class AboutCard extends StatelessWidget {
  final ProfileModel profile;
  final void Function()? onpressed;

  const AboutCard({super.key, required this.profile, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: profile.name != null ? 219 : 120,
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
                    'About',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: onpressed,
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
              child: profile.birthday != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Birthday : ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            Text(
                              '${profile.birthday} (Age ${profile.birthday?.getAge()})',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'Horoscope : ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            Text(
                              '${profile.birthday?.getHoroscope()}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'Zodiac : ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            Text(
                              '${profile.birthday?.getChineseZodiac()}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'Height : ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            Text(
                              '${profile.height}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'Weight : ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            Text(
                              '${profile.weight}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    )
                  : Text(
                      'Add in your your to help others know you better',
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(0.5)),
                    ),
            )
          ],
        ));
  }
}
