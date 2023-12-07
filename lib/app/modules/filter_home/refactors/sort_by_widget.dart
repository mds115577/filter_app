import 'package:filter_app/app/colors/colors.dart';
import 'package:filter_app/app/modules/filter_home/controllers/filter_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SortByWidget extends StatelessWidget {
  const SortByWidget({
    super.key,
    required this.filterHomeController,
  });

  final FilterHomeController filterHomeController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      surfaceTintColor: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sort by",
              style: GoogleFonts.jost(
                  fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Obx(() {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filterHomeController.sortNameList.length,
                  itemBuilder: (context, index) {
                    final sortData = filterHomeController.sortNameList[index];
                    return Obx(() {
                      return RadioListTile.adaptive(
                        activeColor: radioActiveColor,
                        value: true,
                        groupValue:
                            filterHomeController.sortGroupValueList[index],
                        onChanged: (value) {
                          filterHomeController.onSortListClicked(index, value);
                        },
                        title: index == 0
                            ? Row(
                                children: [
                                  Text(sortData, style: GoogleFonts.jost()),
                                  Text(" (default)",
                                      style: GoogleFonts.jost(
                                          fontWeight: FontWeight.w300))
                                ],
                              )
                            : Text(
                                sortData,
                                style: GoogleFonts.jost(),
                              ),
                      );
                    });
                  });
            })
          ],
        ),
      ),
    );
  }
}
