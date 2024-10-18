import 'dart:convert';
import 'package:responsi1/helpers/api.dart';
import 'package:responsi1/helpers/api_url.dart';
import 'package:responsi1/model/bahasa.dart';

class BahasaBloc {
  // Mendapatkan daftar bahasa
  static Future<List<Bahasa>> getBahasa() async {
    String apiUrl =
        ApiUrl.listBahasa; // sesuaikan jika ada endpoint khusus untuk bahasa
    var response = await Api().get(apiUrl);

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      List<dynamic> listBahasa = (jsonObj as Map<String, dynamic>)['data'];
      List<Bahasa> bahasas = [];

      for (var item in listBahasa) {
        bahasas.add(Bahasa.fromJson(item));
      }

      return bahasas;
    } else {
      throw Exception("Failed to load bahasa");
    }
  }

  // Menambahkan bahasa baru
  static Future<bool> addBahasa({required Bahasa bahasa}) async {
    String apiUrl =
        ApiUrl.createBahasa; // sesuaikan jika ada endpoint khusus untuk bahasa

    var body = {
      "original_language": bahasa.originalLanguage,
      "translated_language": bahasa.translatedLanguage,
      "translator_name": bahasa.translatorName,
    };

    var response = await Api().post(apiUrl, body);

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'];
    } else {
      throw Exception("Failed to add bahasa");
    }
  }

  // Memperbarui bahasa yang sudah ada
  static Future<bool> updateBahasa({required Bahasa bahasa}) async {
    // Pastikan id bahasa tidak null sebelum memanggil int.parse
    if (bahasa.id == null) {
      throw Exception("ID bahasa tidak boleh null");
    }

    String apiUrl = ApiUrl.updateBahasa(
        bahasa.id!); // Jika id adalah int, tidak perlu parse
    print(apiUrl);

    var body = {
      "original_language": bahasa.originalLanguage,
      "translated_language": bahasa.translatedLanguage,
      "translator_name": bahasa.translatorName,
    };

    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'];
    } else {
      throw Exception("Failed to update bahasa");
    }
  }

  // Menghapus bahasa
  static Future<bool> deleteBahasa({required int id}) async {
    String apiUrl = ApiUrl.deleteBahasa(
        id); // sesuaikan jika ada endpoint khusus untuk bahasa
    var response = await Api().delete(apiUrl);

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return (jsonObj as Map<String, dynamic>)['data'];
    } else {
      throw Exception("Failed to delete bahasa");
    }
  }
}
