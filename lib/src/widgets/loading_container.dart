import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: buildContainer(),
          ),
        ),
        Divider(
          height: 8.0,
          thickness: 1.0,
        ),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 1.0, bottom: 1.0),
    );
  }
}
