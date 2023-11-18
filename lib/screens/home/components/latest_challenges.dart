import 'package:disappear/screens/home/components/latest_challenge_item.dart';
import 'package:disappear/themes/color_scheme.dart';
import 'package:disappear/themes/text_theme.dart';
import 'package:flutter/material.dart';

class LatestChallenges extends StatelessWidget {
  const LatestChallenges({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Tantangan',
            style: semiBoldBody5.copyWith(color: primary40),
          ),
        ),
        const SizedBox(height: 16,),
        SizedBox(
          height: 120,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: const [
              SizedBox(width: 12,),
              LatestChallengeItem(),
              SizedBox(width: 12,),
              LatestChallengeItem(),
              SizedBox(width: 12,),
              LatestChallengeItem(),
              SizedBox(width: 12,),
              LatestChallengeItem(),
              SizedBox(width: 12,),
            ],
          ),
        ),
      ],
    );
  }
}