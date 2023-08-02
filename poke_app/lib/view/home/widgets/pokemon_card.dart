import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_app/constants/color.dart';

import '/model/pokemon.dart';
import '/utils/navigate.dart';
import '/widgets/view_images.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Stack(
        children: <Widget>[
          Positioned(
            width: MediaQuery.of(context).size.width - 20,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.types
                        .map((t) => FilterChip(
                            backgroundColor: kPrimaryColor,
                            label: Text(
                              t,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  SizedBox(
                    height: 16.h,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: () => navigate(context, ViewImage(url: pokemon.image)),
              child: Container(
                height: 180.h,
                width: 180.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(pokemon.image),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
