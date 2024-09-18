import 'package:fisatest/app/_childrens/container/_childrens/home/pages/home_interactor.dart';
import 'package:fisatest/app/_childrens/container/_childrens/home/widgets/card_yu_gui.dart';
import 'package:fisatest/app/_childrens/container/_childrens/home/widgets/filter_custom.dart';
import 'package:fisatest/app/blocs/blocs.dart';
import 'package:fisatest/app/common_widgets/card_skeleton.dart';
import 'package:fisatest/app/common_widgets/list_view_infinite.dart';
import 'package:fisatest/app/constants/assets.dart';
import 'package:fisatest/app/constants/constants.dart';
import 'package:fisatest/app/enums/archetype_enum.dart';
import 'package:fisatest/app/utils/cubits/theme_cubit.dart';
import 'package:fisatest/app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardsList extends StatelessWidget {
  final HomeInteractor homeInteractor;
  final HomeState homeState;
  const CardsList(
    this.homeInteractor,
    this.homeState, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Column(
          children: [
            FilterList(homeInteractor, homeState),
            Container(
              padding: EdgeInsets.all(SizeConfig.sm),
              child: SizedBox(
                height: .57.sh,
                width: 1.sw,
                child: RefreshIndicator(
                  onRefresh: () async {
                    homeInteractor.reloeadData();
                  },
                  child: ListViewInfinite(
                    onLoadingMore: () {
                      homeInteractor.getMoreData();
                    },
                    loadingWidget: Row(
                      children: [
                        Container(
                          width: .4.sw,
                        ),
                        const Expanded(
                          child: CustomShimmerContainer(),
                        )
                      ],
                    ),
                    isLastPage: homeState.metaData?.rowsRemaining == 0,
                    children: List.generate(
                      (homeState.cardYuGuiList ?? []).length,
                      (index) {
                        var cardInfoModel = (homeState.cardYuGuiList ?? [])[index];
                        return CardYuGui(
                            function: () {
                              homeInteractor.changeCurrentCard(cardInfoModel);
                            },
                            cardInfoModel: cardInfoModel);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FilterList extends StatelessWidget {
  final HomeInteractor homeInteractor;
  final HomeState homeState;
  const FilterList(
    this.homeInteractor,
    this.homeState, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitBloc, InitState>(builder: (_, state) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: SizeConfig.sm),
        height: 0.06.sh,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ConstantsValues.filterList.length,
          itemBuilder: (BuildContext context, int index) {
            final filter = ConstantsValues.filterList[index];
            return FilterChipsCustom(
              text: filter.text,
              onSelected: () {
                homeInteractor.changeCurrenFilter(filter);
              },
              isSelected: filter.name == homeState.currentFilter.name,
            );
          },
        ),
      );
    });
  }
}
