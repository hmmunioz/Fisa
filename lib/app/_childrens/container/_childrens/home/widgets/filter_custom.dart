import 'dart:ui';
import 'package:fisatest/app/utils/size_config.dart';
import 'package:fisatest/app/utils/styles.dart';
import 'package:flutter/material.dart';

class FilterChipsCustom extends StatelessWidget {
  final String text;
  final VoidCallback onSelected;
  final bool isSelected;
  const FilterChipsCustom({required this.text, required this.onSelected, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.xs),
      child: FilterChip(
        selectedColor: isSelected ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
        checkmarkColor: isSelected ? Colors.grey : Theme.of(context).primaryColorLight,
        side: BorderSide(
          color: Colors.green,
        ),
        selected: isSelected,
        labelStyle: AppStyles.bubbleSubTitleStyle(
          context: context,
        ),
        label: Text(
          text,
          style: AppStyles.bubbleSubTitleStyle(context: context, fontSize: SizeConfig.md, color: Colors.grey),
        ),
        onSelected: (bool seleted) {
          onSelected();
        },
      ),
    );
  }
}
