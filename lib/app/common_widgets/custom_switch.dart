import 'package:fisatest/app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CustomTabWidget extends StatelessWidget {
  final bool isBanList;
  final ValueChanged<bool> onToggle;

  const CustomTabWidget({
    super.key,
    required this.isBanList,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.sm),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(SizeConfig.lg),
          border: Border.all(color: Colors.green)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab(
            context,
            text: translate('card_list'),
            isSelected: !isBanList,
            onTap: () => onToggle(false),
          ),
          _buildTab(
            context,
            text: translate('ban_list'),
            isSelected: isBanList,
            onTap: () => onToggle(true),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context,
      {required String text, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.sm, horizontal: SizeConfig.md),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(SizeConfig.md),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
