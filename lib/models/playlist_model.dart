class PlaylistModel {
  int? id;
  String name;

  PlaylistModel({
    this.id,
    required this.name,
  });

  // Convert a Playlist object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Convert a Map object into a Playlist object
  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
