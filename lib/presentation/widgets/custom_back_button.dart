import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => context.pop(),
      child: const Row(
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ), // Back arrow icon
          SizedBox(width: 2.0),
          Text(
            'Back',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
