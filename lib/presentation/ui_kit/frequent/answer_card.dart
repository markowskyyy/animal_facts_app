// import 'package:animal_facts_app/core/design.dart';
// import 'package:flutter/material.dart';
//
// class AnswerCard extends StatelessWidget {
//   final int index;
//   final String text;
//   final bool isCorrectAnswer;
//   const AnswerCard({
//     super.key,
//     required this.index,
//     required this.text,
//     required this.isCorrectAnswer,
//   });
//
//   final isSelected = selectedAnswer == index;
//
//   Color backgroundColor = AppColors.white;
//   Color borderColor = Colors.transparent;
//   Color textColor = AppColors.darkText;
//   Color iconColor = AppColors.grey;
//
//   if (isSelected) {
//     if (isCorrectAnswer) {
//     backgroundColor = AppColors.green.withOpacity(0.1);
//     borderColor = AppColors.green;
//     textColor = AppColors.green;
//     iconColor = AppColors.green;
//     } else {
//     backgroundColor = AppColors.red.withOpacity(0.1);
//     borderColor = AppColors.red;
//     textColor = AppColors.red;
//     iconColor = AppColors.red;
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: selectedAnswer == null
//           ? () {
//         setState(() {
//           selectedAnswer = index;
//           isCorrect = isCorrectAnswer;
//         });
//       }
//           : null,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: borderColor, width: 2),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.02),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (isSelected)
//               Icon(
//                 isCorrectAnswer ? Icons.check_circle : Icons.cancel,
//                 color: iconColor,
//                 size: 20,
//               )
//             else
//               Container(
//                 width: 20,
//                 height: 20,
//                 margin: const EdgeInsets.only(top: 2),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: AppColors.grey),
//                 ),
//               ),
//             const Gap(12),
//             Expanded(
//               child: Text(
//                 text,
//                 style: AppTextStyles.body.copyWith(
//                   color: textColor,
//                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
