// import 'package:flutter/material.dart';
// import 'package:vendeaze/core/app_export.dart';

// // ignore: must_be_immutable
// class ProductcardItemWidget extends StatelessWidget {
//   final String productId;
//   final VoidCallback onAddPressed;
//   ProductCardItemWidget({required this.productId, required this.onAddPressed});

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context); // Ensure you have access to the theme

//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 8.h,
//         vertical: 7.v,
//       ),
//       decoration: AppDecoration.outlineOnError.copyWith(
//         borderRadius: BorderRadiusStyle.roundedBorder18,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 133.v,
//             width: 107.h,
//             margin: EdgeInsets.only(left: 15.h),
//             child: Stack(
//               alignment: Alignment.topRight,
//               children: [
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Text(
//                     "Lays Chips",
//                     style: theme.textTheme.titleLarge,
//                   ),
//                 ),
//                 CustomImageView(
//                   imagePath: ImageConstant.img21,
//                   height: 106.v,
//                   width: 75.h,
//                   alignment: Alignment.topRight,
//                   margin: EdgeInsets.only(right: 11.h),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 3.v),
//           Padding(
//             padding: EdgeInsets.only(left: 2.h),
//             child: Text(
//               "33gm",
//               style: theme.textTheme.bodySmall,
//             ),
//           ),
//           SizedBox(height: 12.v),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 8.v),
//                 child: Text(
//                   "Rs 10",
//                   style: theme.textTheme.bodyMedium,
//                 ),
//               ),
//               InkWell(
//                 onTap: onAddPressed, // Use the callback here when "ADD" is tapped
//                 child: Container(
//                   height: 30.v,
//                   width: 79.h,
//                   margin: EdgeInsets.only(left: 29.h),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: theme.colorScheme.primary,
//                     border: Border.all(
//                       color: theme.colorScheme.onPrimary,
//                       width: 1.h,
//                       strokeAlign: strokeAlignOutside,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: theme.colorScheme.onError,
//                         spreadRadius: 2.h,
//                         blurRadius: 2.h,
//                         offset: Offset(
//                           0,
//                           4,
//                         ),
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     "ADD",
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       color: theme.colorScheme.onPrimary,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 1.v),
//         ],
//       ),
//     );
//   }
// }