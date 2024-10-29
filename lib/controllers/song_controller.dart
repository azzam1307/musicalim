import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SongController extends GetxController {
  var songs = <Map<String, String>>[].obs;  // Observable list for songs

  @override
  void onInit() {
    loadSongsFromJson(); // Load JSON when controller is initialized
    super.onInit();
  }

  void loadSongsFromJson() async {
    final jsonString = await rootBundle.loadString('assets/songs.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    songs.value = jsonData.map((song) => Map<String, String>.from(song)).toList();
  }
}