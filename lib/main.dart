import 'package:fisatest/app/enums/language_enum.dart';
import 'package:fisatest/app/utils/cubits/theme_cubit.dart';
import 'package:fisatest/app/utils/localstorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fisatest/app/_childrens/container/_childrens/navigation/navigation_cubit.dart';
import 'package:fisatest/app/blocs/blocs.dart';
import 'package:fisatest/app/global/env/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fisatest/app/routes/go_route.dart';
import 'package:fisatest/app/utils/di.dart';
import 'package:fisatest/app/utils/styles.dart';
import 'package:fisatest/locale/locale.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get_it/get_it.dart';

void main() async {
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.PROD,
  );
  Environment().initConfig(environment);
  WidgetsFlutterBinding.ensureInitialized();
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'es_ES',
    supportedLocales: ['es_ES', 'en_US'],
  );
  await setupLocator();
  runAppMethod(delegate);
}

void runAppMethod(LocalizationDelegate delegate) {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<InitBloc>(
          create: (context) => InitBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(const NavigationState()),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => LocalizedApp(
          delegate,
          const FisatestApp(),
        ),
      ),
    ),
  );
}

class FisatestApp extends StatefulWidget {
  const FisatestApp({super.key});

  @override
  State<FisatestApp> createState() => _FisatestAppState();
}

class _FisatestAppState extends State<FisatestApp> with WidgetsBindingObserver {
  final LocalStorageService _localStorageService = GetIt.I<LocalStorageService>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _localStorageService.setLanguageStorage = LanguageEnum.es.name;
    changeLocale(context, LanguageEnum.es.name);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    final router = MyAppRouter(context);
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: Material(
        child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, themeState) {
          return MaterialApp.router(
            title: translate('fisatest'),
            routerConfig: router.createdRouter(),
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.locale(context),
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            theme: themeState == ThemeState.light ? AppStyles.appThemeLight : AppStyles.appThemeDark,
            debugShowCheckedModeBanner: false,
          );
        }),
      ),
    );
  }
}
