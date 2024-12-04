// import 'package:flutter/material.dart';
//
// class CustomTextField extends StatelessWidget {
// String text;
// String hint;
// CustomTextField({required this.text,required this.hint});
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _controller = TextEditingController();
//
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: TextField(
//         controller: _controller,
//         decoration: InputDecoration(
//           labelText: text,
//           hintText: hint,
//           border: OutlineInputBorder(),
//           contentPadding:
//           EdgeInsets.symmetric(vertical: 32, horizontal: 24),
//           suffixIcon: GestureDetector(
//             onTap: () {
//               // _translateText(_controller.text);
//             },
//             child: Icon(Icons.translate),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hint;
  final TextEditingController controller;
  final VoidCallback onTranslate;

  CustomTextField({
    required this.text,
    required this.hint,
    required this.controller,
    required this.onTranslate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          hintText: hint,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          suffixIcon: GestureDetector(
            onTap: onTranslate,
            child: Icon(Icons.translate),
          ),
        ),
      ),
    );
  }
}
