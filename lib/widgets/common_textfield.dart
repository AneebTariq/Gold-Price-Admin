import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? backgroundColor;
  final Color? hintColor;
  final bool obscureText;
  final EdgeInsetsGeometry contentPadding;
  final Widget? obscureiocn;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText = 'Enter text',
    this.backgroundColor,
    this.hintColor,
    this.obscureiocn,
    this.obscureText = false,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFC4C4C4).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: const Color(0xFF000000).withOpacity(0.5)),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: SizedBox(
              width: 55.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  obscureiocn ?? const SizedBox(),
                ],
              ),
            ),
          ),
          contentPadding: contentPadding,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
