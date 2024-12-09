// import 'package:flutter/material.dart';

// class CustomTabLabel extends StatelessWidget {
//   final String label;

//   const CustomTabLabel({
//     super.key,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Tab(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             label,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class CustomTabLabel extends StatelessWidget {
  final String label;

  const CustomTabLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1, // Limit to 1 line
              overflow: TextOverflow.ellipsis, // Show ellipsis for overflow
              textAlign: TextAlign.center, // Center the text
            ),
          ),
        ],
      ),
    );
  }
}
