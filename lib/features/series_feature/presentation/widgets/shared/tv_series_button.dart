import 'package:flutter/material.dart';

enum TvSeriesButtonOption { loadMore, tryAgain }

class TvSeriesButton extends StatelessWidget {
  const TvSeriesButton({
    super.key,
    required this.option,
    required this.onTap,
    required this.loading,
  });

  final TvSeriesButtonOption option;
  final void Function() onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (option) {
      case TvSeriesButtonOption.loadMore:
        color = const Color(0xFF525557);
        text = 'Load more';
        break;
      case TvSeriesButtonOption.tryAgain:
        color = Colors.red;
        text = 'Ops, try again!';
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ElevatedButton(
        onPressed: loading ? () {} : onTap,
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
