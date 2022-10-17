import 'package:flutter/cupertino.dart';

class ReuseRow extends StatelessWidget {
  String title, value;
  ReuseRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value, textAlign: TextAlign.center),
              SizedBox(
                height: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
