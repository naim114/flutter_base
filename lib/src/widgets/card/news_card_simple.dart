import 'package:flutter/material.dart';

Widget newsCardSimple() => GestureDetector(
      onTap: () {
        // TODO push to news view
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(
                    'assets/images/noimage.png',
                    fit: BoxFit.cover,
                  )),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stolen or Original? Hear Songs From 7 Landmark Copyright Cases.",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
