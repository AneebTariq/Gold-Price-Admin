import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';
// ignore: must_be_immutable
class CustomDropDown extends StatefulWidget {
  String? dropDownValue;
  List<String>? dropdownList;

  CustomDropDown({
    required this.dropDownValue,
    required this.dropdownList,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: false,
      underline: const SizedBox(),
      value: widget.dropDownValue,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        size: 10,
      ),
      items: (widget.dropdownList ?? [])
          .map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item.length <= 10 ? item : '${item.substring(0, 20)}...',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppTextStyles.font12_400TextStyle,
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          widget.dropDownValue = newValue!;
        });
      },
    );
  }
}
