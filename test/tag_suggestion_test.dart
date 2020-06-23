
import 'package:flutter_test/flutter_test.dart';
import 'package:pickamovie/models/tag.dart';
//import 'package:test/test.dart';
import 'package:pickamovie/recsys/tag_suggestion.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Can read json data', () async {
    var tagSugg = TagSuggestions();
    await tagSugg.updateAvailableTags();
    expect(tagSugg.hasAvailableTags(), true);
  });

  test('Can get random tags', () async{
    var tagSugg = TagSuggestions();
    await tagSugg.updateAvailableTags();
    List<Tag> randomTags = tagSugg.getNRandomTags(6);
    //print(randomTags);
    expect(randomTags.length, 6);
  });

  test('Can get top tags', () async{
    var tagSugg = TagSuggestions();
    await tagSugg.updateAvailableTags();
    List<Tag> topTags = tagSugg.getNTopTags(6);
    //print(randomTags);
    expect(topTags.length, 6);
  });


}
