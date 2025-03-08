import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const AppBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      color: AppColors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(
          AppPadding.padding5,
        ),
        child: GNav(
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          tabBackgroundColor: themeData.focusColor,
          mainAxisAlignment: MainAxisAlignment.center,
          tabBorderRadius: AppBorderRadius.borderRadius30,
          tabs: BottomNavigationTabs.values
              .map(
                (BottomNavigationTabs tab) => GButton(
                  icon: tab.icon,
                  text: tab.tabName,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
