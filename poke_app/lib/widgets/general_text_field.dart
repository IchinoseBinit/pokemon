import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/constants/color.dart';

class GeneralTextField extends StatefulWidget {
  final String? hintText;
  final Widget? preferWidget;
  final bool removePrefixIconDivider;
  final TextInputType keywordType;
  final Function(String) onChanged;

  const GeneralTextField({
    Key? key,
    this.preferWidget,
    required this.keywordType,
    required this.onChanged,
    this.removePrefixIconDivider = false,
    this.hintText,
  }) : super(key: key);

  @override
  GeneralTextFieldState createState() => GeneralTextFieldState();
}

class GeneralTextFieldState extends State<GeneralTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.search,
      keyboardType: widget.keywordType,
      onChanged: (v) => widget.onChanged(v),
      cursorHeight: 12.sp,
      style: TextStyle(fontSize: 12.sp),
      decoration: InputDecoration(
        counter: const SizedBox.shrink(),
        contentPadding: EdgeInsets.only(
          top: 8.h,
          left: 4.w * 3,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1,
          ),
        ),
        errorMaxLines: 3,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget.preferWidget == null
            ? null
            : widget.removePrefixIconDivider
                ? widget.preferWidget
                : SizedBox(
                    width: 125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.preferWidget!,
                        Container(
                          height: 30,
                          width: 1,
                          color: kPrimaryColor,
                        )
                      ],
                    ),
                  ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(
            color: kPrimaryColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            width:  0.6.w,
            color:  Colors.grey,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
      ),
    );
  }
}
