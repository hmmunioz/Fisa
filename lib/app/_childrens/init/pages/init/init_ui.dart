import 'package:fisatest/app/_childrens/init/pages/init/init_interactor.dart';
import 'package:fisatest/app/common_widgets/background_widget.dart';
import 'package:fisatest/app/constants/assets.dart';
import 'package:fisatest/app/utils/cubits/theme_cubit.dart';
import 'package:fisatest/app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fisatest/app/_childrens/init/widgets/auth_button_widget.dart';
import 'package:fisatest/app/constants/constants.dart';

class InitUI extends StatelessWidget {
  final InitInteractor initInteractor;

  const InitUI(this.initInteractor, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset: true,
          backgroundColor: Theme.of(context).primaryColorDark,
          body: ScreenUtilInit(
            minTextAdapt: true,
            splitScreenMode: true,
            designSize: ConstantsValues.designSize,
            builder: (context, child) => Stack(
              children: [
                const Positioned(
                  top: 0,
                  left: 0,
                  child: BackgroundWidget(),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 1.sh,
                        width: 1.sw,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: .9.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).dividerColor.withOpacity(0.8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.md),
                              child: Column(
                                children: [
                                  Text(
                                    translate('yu_gi_oh'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: .1.sw,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                  Text(
                                    translate('nameUser'),
                                    style: TextStyle(
                                      fontSize: .065.sw,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                  SizedBox(height: .03.sh),
                                  FisaButtonWidget(
                                    text: translate("enter"),
                                    icon: Icons.login,
                                    functionToExecute: () async {
                                      initInteractor.goToHome(context);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
