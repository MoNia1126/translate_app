import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/cubit/changeLanguageCubit/change_language_cubit.dart';
import 'package:task2/cubit/languageCubit/language_cubit.dart';
import 'package:task2/cubit/languageCubit/language_state.dart';
import 'package:task2/data/models/language_model.dart';
import 'package:task2/data/services/api_service_get.dart';
import 'package:task2/presentation/widgets/custom_text_field.dart';
import 'package:task2/presentation/widgets/language_drop_down.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  late final LanguageCubit _languageCubit;
  List<Language> _languages = []; // To store languages fetched from the API

  @override
  void initState() {
    super.initState();
    _languageCubit = LanguageCubit(); // Initialize the cubit here
    _fetchLanguages(); // Fetch languages on init
  }

  void _fetchLanguages() async {
    try {
      final ApiService apiService = ApiService();
      _languages = await apiService.getLanguages();
      setState(() {}); // Update the UI once languages are fetched
    } catch (e) {
      print('Error fetching languages: $e');
    }
  }

  void _translate() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      _languageCubit.translateText(text);
    }
  }

  void _onLanguageSelected(String code) {
    _languageCubit.changeTargetLanguage(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.languageTranslator),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Choose Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('English'),
                          onTap: () {
                            BlocProvider.of<ChangeLanguageCubit>(context)
                                .changeLanguageToEnglish();
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text('العربية'),
                          onTap: () {
                            BlocProvider.of<ChangeLanguageCubit>(context)
                                .changeLanguageToArabic();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: BlocBuilder<LanguageCubit, LanguageState>(
            bloc: _languageCubit,
            builder: (context, state) {
              if (state is LanguageLoading) {
                return CircularProgressIndicator();
              } else if (state is LanguageError) {
                return Text(state.message, style: TextStyle(color: Colors.red));
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      text: "${(AppLocalizations.of(context)!.enterTextToTranslate)}",
                      hint: "${(AppLocalizations.of(context)!.enterText)}",
                      controller: _controller,
                      onTranslate: _translate,
                    ),
                    SizedBox(height: 20),
                    if (_languages.isNotEmpty) // Only show dropdown if languages are loaded
                      CountryDropdown(
                        languages: _languages,
                        onLanguageSelected: _onLanguageSelected,
                      ),
                    SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.92,
                      height: MediaQuery.of(context).size.height * 0.1,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Text(
                        state is LanguageLoaded ? state.translatedText : '',
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
// class _HomePageState extends State<HomePage> {
//   final TextEditingController _controller = TextEditingController();
//   late final LanguageCubit _languageCubit;
//   List<Language> _languages = []; // To store languages fetched from the API
//
//   @override
//   void initState() {
//     super.initState();
//     final apiService = ApiService();
//     final languageRepository = LanguageRepository(apiService);
//     _languageCubit = LanguageCubit(languageRepository);
//
//     _fetchLanguages(); // Fetch languages on init
//   }
//
//   void _fetchLanguages() {
//     _languageCubit.fetchLanguages();
//   }
//
//   void _translate() {
//     final text = _controller.text;
//     if (text.isNotEmpty) {
//       _languageCubit.translateText(text);
//     }
//   }
//
//   void _onLanguageSelected(String code) {
//     _languageCubit.changeTargetLanguage(code);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Language Translator"),
//         backgroundColor: Colors.cyan,
//       ),
//       body: Container(
//         child: Center(
//           child: BlocBuilder<LanguageCubit, LanguageState>(
//             bloc: _languageCubit,
//             builder: (context, state) {
//               if (state is LanguageLoading) {
//                 return CircularProgressIndicator();
//               } else if (state is LanguageError) {
//                 return Text(state.message, style: TextStyle(color: Colors.red));
//               } else if (state is LanguagesLoaded) {
//                 _languages = state.languages;
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CustomTextField(
//                       text: "Enter text to translate",
//                       hint: "Enter text",
//                       controller: _controller,
//                       onTranslate: _translate,
//                     ),
//                     SizedBox(height: 20),
//                     if (_languages.isNotEmpty)
//                       CountryDropdown(
//                         languages: _languages,
//                         onLanguageSelected: _onLanguageSelected,
//                       ),
//                     SizedBox(height: 30),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.92,
//                       height: MediaQuery.of(context).size.height * 0.1,
//                       padding: EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 5.0,
//                             spreadRadius: 2.0,
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         '',
//                         // Check if the state is LanguageLoaded and then access translatedText
//                         // state is LanguageLoaded ? state.translatedText : '',
//                         style: const TextStyle(fontSize: 18.0, color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 );
//               } else if (state is LanguageLoaded) {
//                 // Handle the LanguageLoaded state separately if it is expected outside of LanguagesLoaded
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CustomTextField(
//                       text: "Enter text to translate",
//                       hint: "Enter text",
//                       controller: _controller,
//                       onTranslate: _translate,
//                     ),
//                     SizedBox(height: 30),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.92,
//                       height: MediaQuery.of(context).size.height * 0.1,
//                       padding: EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 5.0,
//                             spreadRadius: 2.0,
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         state.translatedText,
//                         style: const TextStyle(fontSize: 18.0, color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 );
//               } else {
//                 return Text('Unexpected state');
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
// }
