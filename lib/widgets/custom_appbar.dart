import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final double? height;
  final Widget? bottom;// Add this line

  RoundedAppBar({super.key, @required this.title, this.titleWidget, this.actions,this.height=99.0,this.bottom}); // Update the constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.buttonClr, AppColors.primaryColor],
         // stops: [0.1, 0.6, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        child: AppBar(
          toolbarHeight: height??99.h,
          centerTitle: false,
          foregroundColor: AppColors.white,
          title:titleWidget??  Text(title??'', style: GoogleFonts.poppins(fontSize: 20.0,fontWeight: FontWeight.w500)),
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.h),
            child: bottom ??Container(),
          ),
          actions: actions, // Add this line
        ),
      ),
    );
  }

  @override
  // Size get preferredSize => Size.fromHeight(kToolbarHeight);
  Size get preferredSize => Size.fromHeight(height??99.h);
}

