import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:smart_quran_new_version/model/model_list_ayat.dart';

class ListAyatProvider with ChangeNotifier {
  //mengambil list dari model riwayat kesehatan
  ModelListAyat _items;

  ModelListAyat get itemsListAyat => _items;

  set itemsListAyat(ModelListAyat value) {
    _items = value;
    //melakukan listener dari setiap perubahan data
    notifyListeners();
  }

  Future<ModelListAyat> fetchListAyat() async {
    final response =
        await http.get('https://api.banghasan.com/quran/format/json/surat');
    if (response.statusCode == 200) {
      final convertData = json.decode(response.body);
      final data = convertData[0].hasil;
      ModelListAyat _newData;
      if (data == null) {
        return null;
      } else {
        for (var i = 0; i < data.length; i++) {
          var addData = ModelListAyat.fromJson(data);
          _newData = addData;
        }

        itemsListAyat = _newData;

        return itemsListAyat;
      }
    } else {
      throw Exception('Failed to load List Ayat');
    }
  }
}
