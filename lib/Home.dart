import 'package:flutter/material.dart';
import 'package:googly_app/InnerScoreCard.dart';
import 'package:googly_app/OuterScoreCard.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InnerScoreCard(),
        OuterScoreCard()
      ],
    );
  }
}
