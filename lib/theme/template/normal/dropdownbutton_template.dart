import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DropdownbuttonTemplate extends StatefulWidget {
  final Function(String?) onChanged;
  final List<dynamic> items;
  final String hint;
  final String? initialValue;

  const DropdownbuttonTemplate({
    super.key,
    required this.onChanged,
    this.initialValue,
    required this.items,
    required this.hint,
  });

  @override
  State<DropdownbuttonTemplate> createState() => _DropdownbuttonTemplateState();
}

class _DropdownbuttonTemplateState extends State<DropdownbuttonTemplate> {
  RxString? selectedValu;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: false,
        isDense: true,
        value: selectedValu?.value,
        customButton: ThreeDContainel(
          padding: EdgeInsets.all(4),
          redious: 10,

          child: Image.asset(
            ImageStyle.sort(),
            scale: 18,
            color: ColorStyle.red,
          ),
        ),

        items: widget.items.isEmpty
            ? [
                const DropdownMenuItem<String>(
                  enabled: false,
                  value: null,
                  child: Center(
                    child: Text(
                      'No item found',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ]
            : widget.items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: Fontstyle.defult(
                      16,
                      FontWeight.w600,
                      ColorStyle.Textblue,
                    ),
                  ),
                );
              }).toList(),

        onChanged: widget.items.isEmpty
            ? null
            : (value) {
                selectedValu = value?.obs;
                widget.onChanged(value);
              },

        dropdownStyleData: DropdownStyleData(
          offset: const Offset(-80, 0),
          width: 120,
          decoration: BoxDecoration(
            color: ColorStyle.light,
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Remove default dropdown arrow
        iconStyleData: const IconStyleData(icon: SizedBox.shrink()),

        menuItemStyleData: const MenuItemStyleData(height: 30),
      ),
    );
  }
}
