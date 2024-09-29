import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youapp_technical_test/presentation/bloc/profile/profile_bloc.dart';
import 'package:youapp_technical_test/core/constants/app_colors.dart';
import 'package:youapp_technical_test/core/extensions/horoscope_extension.dart';
import 'package:youapp_technical_test/core/extensions/zodiac_extension.dart';
import 'package:youapp_technical_test/data/models/profile_model.dart';
import 'package:youapp_technical_test/presentation/widgets/custom_inputfield.dart';
import 'package:youapp_technical_test/presentation/widgets/gardient_text.dart';

class UpdateProfileCard extends StatefulWidget {
  final ProfileModel profile;
  final void Function(ProfileModel) onSave;
  const UpdateProfileCard(
      {super.key, required this.profile, required this.onSave});

  @override
  State<UpdateProfileCard> createState() => _UpdateProfileCardState();
}

class _UpdateProfileCardState extends State<UpdateProfileCard> {
  final TextEditingController _displayNameController = TextEditingController();
  // final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _horoscopeController = TextEditingController();
  final TextEditingController _zodiacController = TextEditingController();
  File? selectedImage;
  @override
  void dispose() {
    _displayNameController.dispose();
    // _genderController.dispose();
    _birthdayController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    // _birthdayController.removeListener(_updateHoroscopeAndZodiac);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _displayNameController.text = widget.profile.name ?? '';
    _birthdayController.text = widget.profile.birthday ?? '';
    if (widget.profile.height != null) {
      _heightController.text = widget.profile.height!.toString();
    }

    if (widget.profile.weight != null) {
      _weightController.text = widget.profile.weight!.toString();
    }

    _birthdayController.addListener(_updateHoroscopeAndZodiac);
  }

  void _onSavePressed() {
    final updatedProfile = ProfileModel(
      name: _displayNameController.text,
      birthday: _birthdayController.text,
      height: int.parse(_heightController.text),
      weight: int.parse(_weightController.text),
      email: widget.profile.email,
      username: widget.profile.username,
      interests: widget.profile.interests,
    );

    widget.onSave(updatedProfile);
  }

  void _updateHoroscopeAndZodiac() {
    if (_birthdayController.text.isNotEmpty) {
      _horoscopeController.text = _birthdayController.text.getHoroscope();
      _zodiacController.text = _birthdayController.text.getChineseZodiac();
    } else {
      _horoscopeController.text = '--';
      _zodiacController.text = '--';
    }
  }

  Future _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if (state is ProfileLoaded) {
          widget.onSave(state.profile);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 27),
        width: MediaQuery.of(context).size.width,
        height: 511,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.card,
        ),
        child: Column(
          children: [
            const SizedBox(height: 13),
            Container(
              padding: const EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: _onSavePressed,
                    child: const GradientText(
                      text: 'Save & Update',
                      gradient: AppColors.goldenGradient,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 31),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    width: 57,
                    height: 57,
                    child: selectedImage == null
                        ? Image.asset('assets/icons/add.png')
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'Add image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const SizedBox(height: 29),
            CustomInputField(
              label: 'Display name',
              hintText: 'Enter name',
              controller: _displayNameController,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            CustomInputField(
              hintText: 'Select Gender',
              label: 'Gender:',
              // controller: _genderController,
              isDropdown: true,
              dropdownItems: const ['Male', 'Female'],
              onChanged: (p0) {},
            ),
            const SizedBox(height: 12),
            CustomInputField(
              hintText: 'DD MM YYYY',
              label: 'Birthday:',
              controller: _birthdayController,
              isDatePicker: true,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            CustomInputField(
              hintText: widget.profile.birthday!.isNotEmpty
                  ? widget.profile.birthday!.getHoroscope()
                  : '--',
              label: 'Horoscope:',
              readOnly: true,
              controller: _horoscopeController,
              // initialValue: widget.profile.birthday?.getHoroscope() ?? '',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            CustomInputField(
              hintText: widget.profile.birthday!.isNotEmpty
                  ? widget.profile.birthday!.getChineseZodiac()
                  : '--',
              label: 'Zodiac:',
              readOnly: true,
              // initialValue: widget.profile.birthday?.getChineseZodiac() ?? '',
              controller: _zodiacController,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            CustomInputField(
              hintText: 'Add Height',
              label: 'Height:',
              controller: _heightController,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            CustomInputField(
              hintText: 'Add weight',
              label: 'Weight:',
              controller: _weightController,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
