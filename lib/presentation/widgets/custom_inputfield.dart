import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool isDropdown;
  final bool isDatePicker;
  final bool readOnly;
  final String? initialValue;
  final List<String>? dropdownItems;
  final Function(String?)? onChanged;
  final TextStyle? style;

  const CustomInputField(
      {super.key,
      required this.label,
      required this.hintText,
      this.readOnly = false,
      this.controller,
      this.isDropdown = false,
      this.isDatePicker = false,
      this.initialValue,
      this.dropdownItems,
      this.onChanged,
      this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.only(right: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.33),
            ),
          ),
          const SizedBox(width: 29),
          SizedBox(
            width: 202,
            child: _buildInputField(context),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    if (isDropdown) {
      return _buildDropdown();
    } else if (isDatePicker) {
      return _buildDatePicker(context);
    } else {
      return _buildTextFormField();
    }
  }

  Widget _buildTextFormField() {
    return TextFormField(
      initialValue: initialValue,
      readOnly: readOnly,
      textAlign: TextAlign.end,
      controller: controller,
      style: style,
      decoration: _getInputDecoration(),
      onChanged: onChanged,
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      alignment: Alignment.centerRight,
      icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white),
      style: const TextStyle(color: Colors.white, fontSize: 13),
      dropdownColor:
          const Color(0xFF1F222A), // Dark background color for dropdown
      decoration: _getInputDecoration(),
      items: dropdownItems?.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            // textAlign: TextAlign.end,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      hint: Padding(
        padding: const EdgeInsets.only(left: 60),
        child: Text(
          hintText,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.3),
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  surface: Color(0xFF1F222A),
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: const Color(0xFF1A1A1A),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          controller?.text = DateFormat('dd MM yyyy').format(picked);
          onChanged?.call(controller?.text);
        }
      },
      child: AbsorbPointer(
        child: _buildTextFormField(),
      ),
    );
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.3),
      ),
      contentPadding: const EdgeInsets.only(right: 20),
      filled: true,
      fillColor: Colors.white.withOpacity(0.06),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white24),
      ),
    );
  }
}
