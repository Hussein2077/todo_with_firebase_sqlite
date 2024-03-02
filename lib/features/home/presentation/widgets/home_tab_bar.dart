import 'package:flutter/material.dart';
import 'package:todo_with_firebase/core/utils/app_size.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      unselectedLabelColor: Colors.green,
      labelStyle: TextStyle(
          color: Colors.white,
          fontSize: AppSize.defaultSize! * 1.4,
          fontWeight: FontWeight.w700),
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.defaultSize! * 5),
          color: Colors.green),
      controller: tabController,
      tabs: [
        Tab(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 5),
                color: Colors.green.withOpacity(.2)),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "All",
                style: TextStyle(fontSize: AppSize.defaultSize! * 1.2),
              ),
            ),
          ),
        ),
        Tab(
          child: Container(
            width: AppSize.defaultSize! * 10 ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 5),
                color: Colors.green.withOpacity(.2)),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Not Done",
                style: TextStyle(fontSize: AppSize.defaultSize! * 1.2),
              ),
            ),
          ),
        ),
        Tab(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 5),
                color: Colors.green.withOpacity(.2)),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Done",
                style: TextStyle(fontSize: AppSize.defaultSize! * 1.2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
