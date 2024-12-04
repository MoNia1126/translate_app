// import 'package:flutter/material.dart';
//
// class CountryDropdown extends StatelessWidget {
//   // final List<Language> languages;
//   final ValueChanged<String> onLanguageSelected;
//
//   CountryDropdown({required this.onLanguageSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         labelText: 'Select Language',
//         // labelStyle: TextStyle(color: Colors.purple),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: Colors.purple,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: Colors.purple,
//           ),
//         ),
//       ),
//       dropdownColor: Colors.purple[50],
//       iconEnabledColor: Colors.purple,
//       items: languages.map((country) {
//         return DropdownMenuItem(
//           value: .code,
//           child: Text('${country.name} (${country.code})'),
//         );
//       }).toList(),
//       onChanged: (value) {
//         if (value != null) {
//           onLanguageSelected(value);
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:task2/data/models/language_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountryDropdown extends StatelessWidget {
  final List<Language> languages;
  final ValueChanged<String> onLanguageSelected;

  CountryDropdown({required this.languages, required this.onLanguageSelected});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      padding: EdgeInsets.all(18),
      decoration: InputDecoration(
        labelText: '${(AppLocalizations.of(context)!.selectLanguage)}',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.cyan,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.cyan,
          ),
        ),
      ),
      dropdownColor: Colors.cyan[50],
      iconEnabledColor: Colors.cyan,
      items: languages.map((language) {
        return DropdownMenuItem(
          value: language.code,
          child: Text('${language.name} (${language.code})'),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onLanguageSelected(value);
        }
      },
    );
  }
}

