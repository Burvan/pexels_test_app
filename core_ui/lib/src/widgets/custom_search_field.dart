import 'package:core/constants/app_constants.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final FocusNode focusNode;
  final void Function() onPressed;

  const CustomSearchField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.focusNode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.padding20),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: AppPadding.padding20),
          label: Text(AppConstants.search),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.lightGrey,
              width: AppSize.size2,
            ),
            borderRadius: BorderRadius.circular(
              AppBorderRadius.borderRadius30,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.lightGrey,
              width: AppSize.size2,
            ),
            borderRadius: BorderRadius.circular(
              AppBorderRadius.borderRadius30,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.turquoise,
              width: AppSize.size2,
            ),
            borderRadius: BorderRadius.circular(
              AppBorderRadius.borderRadius30,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.red,
              width: AppSize.size2,
            ),
            borderRadius: BorderRadius.circular(
              AppBorderRadius.borderRadius30,
            ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: AppPadding.padding5),
            child: IconButton(
              onPressed: () {
                onPressed();
                focusNode.unfocus();
              },
              icon: Icon(
                Icons.search,
              ),
            ),
          ),
        ),
        inputFormatters: [
          SearchPhotosFormatter(),
        ],
        onSubmitted: onSubmitted,
      ),
    );
  }
}
