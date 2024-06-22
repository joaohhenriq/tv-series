import 'package:flutter/material.dart';
import 'package:tv_series_app/features/people_feature/people_feature.dart';
import 'package:tv_series_app/features/shared/shared.dart';

class PersonDetail extends StatefulWidget {
  const PersonDetail({
    super.key,
    required this.personEntity,
  });

  final PersonEntity personEntity;

  @override
  State<PersonDetail> createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Person Detail')),
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
                imageUrl: widget.personEntity.originalImage,
                defaultIconColor: Colors.grey,
              ),
            ),
          ),
          PaddingWithText(
            text: widget.personEntity.name,
            fontSize: 24,
          ),
        ],
      ),
    ),
  );
}
