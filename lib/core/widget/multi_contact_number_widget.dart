// import 'package:flutter/material.dart';
// import 'package:mohan_impex/core/widget/app_text.dart';
// import 'package:mohan_impex/res/app_colors.dart';

// Widget multiContactNumberWidget(List list, Function()removeTap){
//   return SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       padding: EdgeInsets.only(top: 10),
//                       child: Row(
//                         children: list.map((e) {
//                           return Stack(
//                             children: [
//                               Container(
//                                   margin: EdgeInsets.symmetric(horizontal: 6),
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 2),
//                                   decoration: BoxDecoration(
//                                       color: AppColors.lightEBColor,
//                                       borderRadius: BorderRadius.circular(25)),
//                                   alignment: Alignment.center,
//                                   child: AppText(title: e)),
//                               Positioned(
//                                 right: 0,
//                                 top: 0,
//                                 child: InkWell(
//                                   onTap: () {
//                                     list.remove(e);
//                                   },
//                                   child: Container(
//                                     height: 12,
//                                     width: 12,
//                                     decoration: BoxDecoration(
//                                         color: AppColors.cardBorder,
//                                         shape: BoxShape.circle),
//                                     child: Icon(
//                                       Icons.close,
//                                       size: 10,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     );
// }