import 'package:pickamovie/models/tag.dart';
import 'package:pickamovie/recsys/tag_suggestion.dart';

class SuggestionPager{
  List <List<Tag>>_windowSuggestion=[];
  int _curPos=0;
  TagSuggestions _tagSuggestions=TagSuggestions();

  Future <List<Tag>> getNextWindow() async{
    _curPos++;
    if (_curPos==_windowSuggestion.length)
    {
      _windowSuggestion.add(_tagSuggestions.getNTopTags(3) + _tagSuggestions.getNRandomTags(3));
    }
    return _windowSuggestion[_curPos];
  }
  Future <List<Tag>> getLastWindow() async{
    _curPos--;
    return _windowSuggestion[_curPos];
  }
  hasNextWindow(){
    return _tagSuggestions.hasAvailableTags();
  }
  hasLastWindow(){
    return _curPos>0;
  }

}