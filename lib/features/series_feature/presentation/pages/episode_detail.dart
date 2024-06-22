import 'package:flutter/material.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features/shared/shared.dart';

class EpisodeDetail extends StatefulWidget {
  const EpisodeDetail({
    super.key,
    required this.episode,
  });

  final EpisodeEntity episode;

  @override
  State<EpisodeDetail> createState() => _EpisodeDetailState();
}

class _EpisodeDetailState extends State<EpisodeDetail> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Episode Detail')),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: ImageNetwork(
                imageUrl: widget.episode.originalImage,
                defaultIconColor: Colors.grey,
              ),
            ),
          ),
          PaddingWithText(
            text: '${widget.episode.number} - ${widget.episode.name}',
            fontSize: 24,
          ),
          PaddingWithText(
            text: widget.episode.season != 0
                ? 'Season: ${widget.episode.season}'
                : '',
            fontSize: 18,
          ),
          PaddingWithText(
            text: widget.episode.summary,
            fontSize: 14,
          ),
        ],
      ),
    ),
  );
}
