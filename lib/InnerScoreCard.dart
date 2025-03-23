import 'package:flutter/material.dart';

class InnerScoreCard extends StatelessWidget {
  const InnerScoreCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Match 10 of 72'), Text('TATA IPL 2025')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [Icon(Icons.add_box_rounded), Text('RCB')]),
                Column(children: [Text('182/6'), Text('20')]),
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
                Column(children: [Text('136/2'), Text('11.2')]),
                Column(children: [Icon(Icons.check_box), Text('KKR')]),
              ],
            ),
            Row(
              children: [
                Text('TODO')
              ],
            )
          ],
        ),
      ),
    );
  }
}