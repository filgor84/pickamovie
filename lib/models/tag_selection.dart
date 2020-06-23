import 'package:flutter/foundation.dart';

import 'movie.dart';

class TagSelection {
  String tagName;
  Movie suggMovie;

  TagSelection({
    @required tagName,
    @required suggMovie,
  });
}
