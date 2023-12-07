
import 'package:filter_app/app/modules/filter_home/model/filter_data_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FilterHomeController extends GetxController {
  //TODO: Implement FilterHomeController

  final count = 0.obs;

  void increment() => count.value++;

  dynamic groupValue;

  RxList<bool> sortGroupValueList = <bool>[false, false, false, false].obs;

  RxList<String> sortNameList = <String>[
    'Nearest to Me',
    'Trending this Week',
    'Newest Added',
    'Alphabetical'
  ].obs;

  RxList<Datum> filterDataFromJson = <Datum>[].obs;
  RxList<RxList<bool>> multiplieItemBoolListForFilteringList =
      <RxList<bool>>[].obs;
  RxList<dynamic> selectedLength = <dynamic>[].obs;
  RxList<Taxonomy> nameList = <Taxonomy>[].obs;
  RxInt selectedCount = 0.obs;

  onSortListClicked(index, value) {
    if (value != null) {
      for (int i = 0; i < sortGroupValueList.length; i++) {
        if (i == index) {
          sortGroupValueList[i] = value;
        } else {
          sortGroupValueList[i] = false;
        }
      }
    }
  }

  getDataFromJson() async {
    final data = await rootBundle.loadString("assets/filter_data.json");
    final decodeData = (data);

    final filterModel = filterModelFromJson(decodeData);

    selectedCount.value = 0;
    filterDataFromJson.assignAll(filterModel.data);
    selectedLength.clear();
    multiplieItemBoolListForFilteringList =
        RxList.of(filterModel.data.map((datum) {
      return RxList.of(
          List<bool>.generate(datum.taxonomies.length, (index) => false));
    }));

    for (int i = 0; i < filterDataFromJson.first.taxonomies.length; i++) {
      selectedLength.add(0);
    }
  }

  selectedTaxonomieFunct(index1, index, value, Taxonomy data) {
    if (multiplieItemBoolListForFilteringList[index1][index] == true) {
      multiplieItemBoolListForFilteringList[index1][index] = false;
      nameList.removeWhere((element) => element == data);
    } else {
      multiplieItemBoolListForFilteringList[index1][index] = value!;

      nameList.add(data);
    }

    var count = 0;

    for (var element in multiplieItemBoolListForFilteringList[index1]) {
      if (element == true) {
        count = count + 1;
      }
    }

    selectedLength[index1] = count;

    selectedCount.value =
        selectedLength.reduce((value, element) => value + element);
  }
}
