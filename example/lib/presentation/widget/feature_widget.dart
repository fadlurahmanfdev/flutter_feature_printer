import 'package:flutter/material.dart';
import 'package:flutter_feature_printer_example/data/dto/model/feature_model.dart';

class ItemFeatureWidget extends StatelessWidget {
  final FeatureModel feature;
  const ItemFeatureWidget({
    super.key,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Icon(Icons.developer_mode),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(feature.title),
                Text(feature.desc),
              ],
            ),
          )
        ],
      ),
    );
  }
}