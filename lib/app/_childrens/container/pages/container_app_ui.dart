import 'package:fisatest/app/_childrens/container/_childrens/home/bloc/home_bloc.dart';
import 'package:fisatest/app/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fisatest/app/_childrens/container/pages/container_app_interactor.dart';
import 'package:fisatest/app/_childrens/container/_childrens/navigation/navigation_cubit.dart';
import 'package:fisatest/app/common_widgets/app_bar.dart';
import 'package:fisatest/app/common_widgets/bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fisatest/app/constants/colors.dart';
import 'package:fisatest/app/constants/constants.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ContainerAppUI extends StatelessWidget {
  const ContainerAppUI({super.key, required this.interactor, required this.children});
  final Widget children;
  final ContainerAppInteractor interactor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, navigationState) {
        return Container(
          color: Colors.black,
          child: SafeArea(
            top: false,
            bottom: true,
            child: ScreenUtilInit(
              designSize: ConstantsValues.designSize,
              builder: (context, child) {
                return Scaffold(
                  backgroundColor: ColorsTheme.deepSpace,
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(0.06.sh),
                      child: BlocBuilder<HomeBloc, HomeState>(builder: (_, state) {
                        return AppBarStarWars(
                          isBack: false,
                          cardInfoModelList: state.cardYuGuiList,
                        );
                      })),
                  body: children,
                  extendBody: true,
                  drawerEnableOpenDragGesture: true,
                  bottomNavigationBar: BottomBarStarWars(logout: () {
                    interactor.logOut(context);
                  }),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
