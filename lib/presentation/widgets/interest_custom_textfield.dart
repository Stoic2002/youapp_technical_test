import 'package:flutter/material.dart';
import 'package:youapp_technical_test/presentation/widgets/interest_chip.dart';

class InterestCustomTextfield extends StatefulWidget {
  final List<String> interests;
  final Function(String) onInterestAdded;
  final Function(String) onInterestRemoved;

  const InterestCustomTextfield({
    super.key,
    required this.interests,
    required this.onInterestAdded,
    required this.onInterestRemoved,
  });

  @override
  State<InterestCustomTextfield> createState() =>
      _InterestCustomTextfieldState();
}

class _InterestCustomTextfieldState extends State<InterestCustomTextfield> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _focusNode.requestFocus(),
      child: InputDecorator(
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.06),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white24),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.06)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...widget.interests.map((interest) => InterestChip(
                  label: interest,
                  onDeleted: () => widget.onInterestRemoved(interest),
                )),
            IntrinsicWidth(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: widget.interests.isEmpty ? 'Type an interest' : '',
                  hintStyle: const TextStyle(color: Colors.white54),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty && !widget.interests.contains(value)) {
                    widget.onInterestAdded(value);
                    _controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
