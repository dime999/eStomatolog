import 'dart:math';

import 'package:flutter/material.dart';

class ClinicListItem extends StatelessWidget {
  final String title;
  final String address;
  final String image;
  final GlobalKey backgroundImageKey = GlobalKey();

  ClinicListItem({
    Key? key,
    required this.title,
    required this.address,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 170,
                width: width,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.blue,
                          size: 18,
                        ),
                        Text(
                          address,
                          style: const TextStyle(
                              color: Colors.black38, fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: Transform.rotate(
                    angle: pi / -4,
                    child: const Icon(
                      Icons.arrow_downward,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
