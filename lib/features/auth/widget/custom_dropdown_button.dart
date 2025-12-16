import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownbutton extends StatefulWidget {
  final Function(String?) onChanged;
  final String? initialValue;

  const CustomDropdownbutton({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<CustomDropdownbutton> createState() => _MydropdownbuttonState();
}

class _MydropdownbuttonState extends State<CustomDropdownbutton> {
  final List<String> items = ['CSE', 'EEE', 'BBA', 'ENG'];

  String? selectedValu;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Department:",
          style: Fontstyle.defult(18, FontWeight.normal, ColorStyle.Textblue),
        ),
        const SizedBox(width: 12),

        // Constrain the dropdown to the remaining width
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,

              value: selectedValu,
              hint: Text(
                'Select department',
                style: Fontstyle.defult(
                  18,
                  FontWeight.normal,
                  ColorStyle.lightBlue,
                ),
              ),

              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis, // avoids text overflow
                    style: Fontstyle.defult(
                      18,
                      FontWeight.w500,
                      ColorStyle.Textblue,
                    ),
                  ),
                );
              }).toList(),

              onChanged: (value) {
                setState(() => selectedValu = value);

                widget.onChanged(value);
              },

              // Button (closed state) styling
              buttonStyleData: ButtonStyleData(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: ColorStyle.light,
                  borderRadius: BorderRadius.circular(14),

                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        12,
                        0,
                        0,
                        0,
                      ), // Soft dark shadow
                      blurRadius: 6,
                      offset: Offset(6, 6), // Softness
                      spreadRadius: 3,
                    ),
                  ],
                ),
              ),

              // Popup menu styling
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: ColorStyle.light,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              iconStyleData: IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: ColorStyle.Textblue,
                  size: 30,
                ),
              ),
              // Each item’s padding/height
              menuItemStyleData: const MenuItemStyleData(
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
