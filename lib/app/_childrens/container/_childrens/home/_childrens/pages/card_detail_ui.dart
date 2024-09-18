import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisatest/app/_childrens/container/_childrens/home/widgets/bubble_header_widget.dart';
import 'package:fisatest/app/_childrens/init/widgets/auth_button_widget.dart';
import 'package:fisatest/app/common_widgets/app_bar.dart';
import 'package:fisatest/app/common_widgets/background_widget.dart';
import 'package:fisatest/app/common_widgets/text_row.dart';
import 'package:fisatest/app/constants/assets.dart';
import 'package:fisatest/app/utils/extensions/buildcontext.dart';
import 'package:fisatest/app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fisatest/app/_childrens/container/_childrens/home/bloc/home_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:fisatest/app/constants/constants.dart';
import 'package:fisatest/app/utils/size_config.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CardDetailUI extends StatelessWidget {
  final HomeState state;

  const CardDetailUI(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.06.sh),
        child: const AppBarStarWars(
          isBack: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ScreenUtilInit(
        designSize: ConstantsValues.designSize,
        builder: (context, child) => Stack(
          children: [
            const Positioned(
              top: 0,
              left: 0,
              child: BackgroundWidget(),
            ),
            SingleChildScrollView(
              child: Container(
                width: 1.sw,
                child: const BodyCastMemberDetail(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyCastMemberDetail extends StatelessWidget {
  const BodyCastMemberDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BubbleHeaderWidget(title: translate('card_detail')),
        const BodyCastMemberDetailCard(),
      ],
    );
  }
}

class BodyCastMemberDetailCard extends StatelessWidget {
  const BodyCastMemberDetailCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        return Container(
          color: Theme.of(context).primaryColorLight,
          padding: EdgeInsets.all(SizeConfig.lg),
          width: .95.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                    child: Hero(
                  tag: homeState.currentCardInfo?.id ?? 0,
                  child: CachedNetworkImage(
                    imageUrl: homeState.currentCardInfo?.cardImages?[0].imageUrl ?? '',
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      height: .3.sh,
                      padding: const EdgeInsets.all(5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      AssetsUIValues.genericUser,
                      height: .35.sh,
                    ),
                  ),
                )),
              ),
              TextRow(title: translate('name'), value: homeState.currentCardInfo?.name ?? '--'),
              const Divider(),
              TextRow(title: translate('description'), value: homeState.currentCardInfo?.description ?? '--'),
              TextRow(title: translate('type'), value: homeState.currentCardInfo?.type ?? '--'),
              TextRow(title: translate('archetype'), value: homeState.currentCardInfo?.archetype ?? '--'),
              Text(
                'ATK/${homeState.currentCardInfo?.atk ?? "--"}  DEF/${homeState.currentCardInfo?.def ?? "--"}',
                style: AppStyles.titleStyle(context: context, color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              FisaButtonWidget(
                text: translate("show_images"),
                icon: Icons.image,
                functionToExecute: () async {
                  context.showImagesDialog(context: context, images: homeState.currentCardInfo?.cardImages ?? []);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
