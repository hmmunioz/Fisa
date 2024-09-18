import 'dart:io';

import 'package:fisatest/app/_childrens/container/_childrens/home/models/cards_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fisatest/app/constants/assets.dart';
import 'package:fisatest/app/constants/colors.dart';
import 'package:fisatest/app/utils/extensions/extensions.dart';
import 'package:fisatest/app/utils/size_config.dart';
import 'package:fisatest/app/utils/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';

extension BuildContextExtensions on BuildContext {
  showLoadingDialog(String message) {
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
        context: this,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: AppStyles.titleStyle(
                  context: this,
                ),
              ),
              10.pv,
              SizedBox(
                width: .60.sw,
                height: .20.sh,
                child: Image.asset(
                  AssetsUIValues.loading,
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: this,
        barrierDismissible: false,
        builder: (_) => CupertinoAlertDialog(
          content: Center(
            child: Column(
              children: [
                Text(message),
                10.pv,
                SizedBox(
                  width: .60.sw,
                  height: .20.sh,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(this).primaryColorDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  showActionDialog({
    required String alertMessage,
    required String okText,
    required VoidCallback onOkTap,
    required String cancelText,
  }) {
    showDialog(
        context: this,
        builder: (BuildContext context) {
          final size = MediaQuery.of(context).size;
          return AlertDialog(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              backgroundColor: ColorsTheme.deepSpace,
              content: SizedBox(
                height: 0.3.sh,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      alertMessage,
                      style: const TextStyle(fontFamily: 'YuGiOhMatrix'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            onOkTap();
                          },
                          child: Container(
                            width: size.width,
                            height: .08.sh,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(SizeConfig.sm),
                            ),
                            child: Center(
                              child: Text(
                                okText,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontFamily: 'YuGiOhMatrix'),
                              ),
                            ),
                          ),
                        ),
                        15.pv,
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: size.width,
                            height: .08.sh,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(SizeConfig.sm),
                            ),
                            child: Center(
                              child: Text(
                                cancelText,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontFamily: 'YuGiOhMatrix'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  messageDialog({required String message, VoidCallback? onPressed}) {
    showDialog(
        context: this,
        builder: (BuildContext context) {
          final size = MediaQuery.of(context).size;
          return AlertDialog(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              backgroundColor: ColorsTheme.jediBrown,
              content: SizedBox(
                height: size.height * 0.2,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(fontFamily: 'YuGiOhMatrix'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (onPressed != null) {
                          onPressed();
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        width: size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(SizeConfig.sm),
                        ),
                        child: const Center(
                          child: Text(
                            '¡OK entiendo!',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: 'YuGiOhMatrix'),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  void showImagesDialog({
    required BuildContext context,
    required List<CardImageModel> images,
  }) {
    final CarouselController _controller = CarouselController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          final size = MediaQuery.of(context).size;
          return AlertDialog(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: SizedBox(
                height: .60.sh,
                width: 800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Carrusel de Imagenes",
                      style: TextStyle(fontFamily: 'YuGiOhMatrix', fontSize: 19),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CarouselSlider(
                      items: images
                          .map((item) => Container(
                                child: Image.network(
                                  item.imageUrl,
                                  height: .70.sh,
                                  width: .9.sh,
                                ),
                              ))
                          .toList(),
                      carouselController: _controller,
                      options: CarouselOptions(
                          height: .40.sh,
                          viewportFraction: 1,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {}),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: size.width * 0.4,
                            height: .05.sh,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Cerrar",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green,
                                    fontFamily: 'YuGiOhMatrix'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ));
        });
  }
}
