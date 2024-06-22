import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onTap,
    required this.loading,
    required this.labelText,
  });

  final TextEditingController controller;
  final void Function() onTap;
  final bool loading;
  final String labelText;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          bottom: 12.0,
          left: 12.0,
          right: 12.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (_) => loading ? () {} : onTap(),
                    decoration: InputDecoration(
                      labelText: labelText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: loading ? () {} : onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF525557),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
}
