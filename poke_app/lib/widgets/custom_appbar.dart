import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = "",
    this.titleWidget,
    this.leading,
    this.actions,
    this.bottom,
    this.backgroundColor,
    this.toolbarHeight,
    this.leadingFunc,
    this.centerTitle = false,
    this.disableLeading = false,
    this.automaticallyImplyLeading = true,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  final String title;
  final Widget? titleWidget;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final bool disableLeading;
  final double? toolbarHeight;
  final Widget? leading;
  final VoidCallback? leadingFunc;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: Platform.isIOS
          ? SystemUiOverlayStyle.light
          : const SystemUiOverlayStyle(
              systemNavigationBarColor: kPrimaryColor,
              statusBarColor: kPrimaryColor,
              systemNavigationBarIconBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: disableLeading
          ? null
          : leading ??
              InkWell(
                onTap: leadingFunc ?? () => Navigator.pop(context),
                child: const Icon(
                  CupertinoIcons.chevron_back,
                  color: Colors.white,
                ),
              ),
      title: titleWidget ??
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
      elevation: 0.0,
      backgroundColor: backgroundColor ?? kPrimaryColor,
      centerTitle: centerTitle,
      actions: actions,
      bottom: bottom,
    );
  }
}
