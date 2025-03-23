import 'package:flutter/material.dart';

class OuterScoreCard extends StatelessWidget {
  const OuterScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'T20 8 of 72'
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))
                  ),
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(Icons.adjust, color: Colors.red),
                        Text('LIVE'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.add_box_rounded
                    ),
                    Text('RCB')
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '182/6'
                    ),
                    Text('(20)')
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                        Icons.check_box_rounded
                    ),
                    Text('KKR')
                  ],
                ),
                Row(
                  children: [
                    Text(
                        '132/2'
                    ),
                    Text('(12.1)')
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CRR: 11.4'
                ),
                SizedBox(width: 2,),
                Icon(Icons.adjust),
                SizedBox(width: 2,),
                Text(
                  'RRR: 5.75'
                )
              ],
            ),
            Text(
              'KKR needs 45 runs in 45 balls to win'
            )
          ],
        ),
      ),
    );
  }
}
