import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HistoryShimmer extends StatelessWidget {
  const HistoryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        for (int i = 0; i < 10; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Card(
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 5,
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 10),
                    ),
                    for(int k = 0; k < 5; k++)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            height: 5,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 10,
                            height: 5,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 20,
                            height: 5,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 40,
                            height: 5,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
