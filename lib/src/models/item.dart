class ItemModel {
  final int id = 0;
  final bool deleted = false;
  final String type = '';
  final String by = '';
  final int time = 0;
  final String text = '';
  final bool dead = false;
  final int parent = 0;
  final List<dynamic> kids = List.empty();
  final String url = '';
  final int score = 0;
  final String title = '';
  final int descendants = 0;

  // Receives a big blob of parsed json data
  ItemModel.fromJson(Map<String dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'],
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'],
        parent = parsedJson['parent'],
        kids = parsedJson['kids'],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];
}
