

import 'package:filter_app/app/colors/colors.dart';
import 'package:filter_app/app/modules/filter_home/refactors/sort_by_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/filter_home_controller.dart';

class FilterHomeView extends GetView<FilterHomeController> {
  FilterHomeView({Key? key}) : super(key: key);
  final FilterHomeController filterHomeController =
      Get.put(FilterHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        titleTextStyle: GoogleFonts.jost(
            fontSize: 25, color: textColor, fontWeight: FontWeight.w600),
        title: const Text('Filter Options'),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 20),
            child: Column(
              children: [
                Obx(() {
                  return Visibility(
                    visible:
                        filterHomeController.nameList.isEmpty ? false : true,
                    child: SizedBox(
                      height: 40,
                      width: 100.w,
                      child: Obx(() {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: filterHomeController.nameList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (cont, index) {
                              final nameData =
                                  filterHomeController.nameList[index];
                              return Card(
                                color: const Color.fromARGB(220, 255, 255, 255),
                                shape: const BeveledRectangleBorder(),
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "x ${nameData.name}",
                                        style: GoogleFonts.jost(
                                            color: textColor, fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                    ),
                  );
                }),
                SortByWidget(filterHomeController: filterHomeController),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: filterHomeController.getDataFromJson(),
                    builder: (context, snpashot) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              filterHomeController.filterDataFromJson.length,
                          itemBuilder: (context, index1) {
                            final filteredData =
                                filterHomeController.filterDataFromJson[index1];

                            return Visibility(
                              visible:
                                  filteredData.name == "Sort by" ? false : true,
                              child: Card(
                                elevation: 0,
                                surfaceTintColor: cardColor,
                                child: ExpansionTile(
                                  shape: Border.all(
                                    color: cardColor,
                                  ),
                                  backgroundColor: cardColor,
                                  title: Row(
                                    children: [
                                      Text(
                                        filteredData.name,
                                        style: GoogleFonts.jost(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Obx(() {
                                        return Visibility(
                                          visible: filterHomeController
                                                              .selectedLength[
                                                          index1] ==
                                                      -1 ||
                                                  filterHomeController
                                                              .selectedLength[
                                                          index1] ==
                                                      0
                                              ? false
                                              : true,
                                          child: Text(
                                            "(${filterHomeController.selectedLength[index1].toString()})",
                                            style: GoogleFonts.jost(
                                                fontWeight: FontWeight.w500,
                                                color: radioActiveColor),
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            filteredData.taxonomies.length,
                                        itemBuilder: (context, index) {
                                          final taxonamyData =
                                              filteredData.taxonomies[index];

                                          return Obx(() {
                                            return RadioListTile.adaptive(
                                              value: true,
                                              toggleable: true,
                                              activeColor: radioActiveColor,
                                              groupValue: filterHomeController
                                                      .multiplieItemBoolListForFilteringList[
                                                  index1][index],
                                              onChanged: (value) {
                                                filterHomeController
                                                    .selectedTaxonomieFunct(
                                                        index1,
                                                        index,
                                                        value,
                                                        taxonamyData);
                                              },
                                              title: Text(
                                                filteredData.name ==
                                                        "Neighbourhoods"
                                                    ? taxonamyData.city
                                                        .toString()
                                                    : taxonamyData.name
                                                        .toString(),
                                                style: GoogleFonts.jost(),
                                              ),
                                            );
                                          });
                                        })
                                  ],
                                ),
                              ),
                            );
                          });
                    })
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor)),
          onPressed: () {},
          child: Obx(() {
            return Text(
              "SHOW ${filterHomeController.selectedCount} RESULTS",
              style: const TextStyle(color: cardColor),
            );
          })),
    );
  }
}
