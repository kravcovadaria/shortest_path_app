import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitActionButton extends StatelessWidget {
  const SubmitActionButton({
    super.key,
    required this.caption,
    this.onTap,
  });

  final String caption;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.lightBlue,
      disabledColor: Colors.lightBlue,
      elevation: 0,
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(caption)],
        ),
      ),
    );
  }
}
