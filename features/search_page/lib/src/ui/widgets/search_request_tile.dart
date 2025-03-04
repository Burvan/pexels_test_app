import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SearchRequestTile extends StatelessWidget {
  final String query;
  final VoidCallback onTap;

  const SearchRequestTile({
    required this.query,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.padding20,
        vertical: AppPadding.padding5,
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(
            AppBorderRadius.borderRadius30,
          ),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppBorderRadius.borderRadius30,
              ),
              color: AppColors.turquoiseWithOpacity,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.padding20,
              vertical: AppPadding.padding10,
            ),
            child: Text(
              query,
              style: AppTextTheme.font16,
            ),
          ),
        ),
      ),
    );
  }
}
