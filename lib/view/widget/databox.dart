import 'package:flutter/cupertino.dart';

class DataBox extends StatefulWidget {
  String name, data;
  double width;
  var color, image;
  DataBox(
      {Key? key,
      required this.name,
      required this.data,
      this.width = 155,
      required this.color,
      required this.image})
      : super(key: key);

  @override
  State<DataBox> createState() => _DataBoxState();
}

class _DataBoxState extends State<DataBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 18),
                ),
                Image(height: 60, width: 60, image: AssetImage(widget.image))
              ],
            ),
            Text(
              widget.data,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
