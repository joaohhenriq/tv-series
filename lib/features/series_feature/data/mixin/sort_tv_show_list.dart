import 'package:tv_series_app/features/series_feature/series_feature.dart';

mixin SortTvShowList {
  List<TvShowEntity> sortTvShowList(List<TvShowEntity> tvShowList) {
    tvShowList.sort((a, b) => a.name.compareTo(b.name));
    return tvShowList;
  }
}