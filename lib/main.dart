import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/cubit/changeLanguageCubit/change_language_cubit.dart';
import 'package:task2/cubit/changeLanguageCubit/change_language_state.dart';
import 'package:task2/presentation/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChangeLanguageCubit(),
        child: BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
        builder: (context, state) {
    return MaterialApp(
      title: 'Translate App',
      home: HomePage(),
      locale: state.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
    ));
}
}

