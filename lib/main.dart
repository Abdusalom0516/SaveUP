import 'package:boilerplate/core/design_system/app_theme.dart';
import 'package:boilerplate/core/utils/app_router.dart';
import 'package:boilerplate/core/utils/theme_manager.dart';
import 'package:boilerplate/features/home/presentation/screens/home_screen.dart';
import 'package:boilerplate/infrastructure/injector/injector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:hr/observer/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // Here I will Inject Classes
  setupInjector();
  // Bloc.observer = AppBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ThemeManagerCubit())],
      child: BlocBuilder<ThemeManagerCubit, ThemeMode>(
        builder: (context, state) => ScreenUtilInit(
          designSize: Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: AppRouter.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme.copyWith(
              splashColor: Colors.transparent,
              dividerColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            darkTheme: AppTheme.darkTheme.copyWith(
              splashColor: Colors.transparent,
              dividerColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            themeMode: state,
            home: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
