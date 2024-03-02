import 'package:flutter/material.dart';
import 'package:todo_with_firebase/core/utils/app_size.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.widget, required this.color, this.onTap});

  final Widget widget;
  final Color color;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSize.defaultSize! * 5.6,
        width: AppSize.screenWidth! - (AppSize.defaultSize! * 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSize.defaultSize! ),
          boxShadow: [
            BoxShadow(
                blurRadius: 20.0,
                color: Colors.grey.withOpacity(.2),
                offset: const Offset(5, 15)),
          ],
        ),
        child: Center(child: widget),
      ),
    );
  }
}
