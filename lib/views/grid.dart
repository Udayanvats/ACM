// ignore_for_file: avoid_unnecessary_containers

import 'package:acm/models/Movies.dart';
import 'package:acm/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

class gird extends StatefulWidget {
  const gird({super.key});

  @override
  State<gird> createState() => _girdState();
}

// ignore: camel_case_types
class _girdState extends State<gird> {
  // List<Movie>? movie;
  // var isLoaded = false;

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  // getData() async {
  //   movie = (RemoteService().getMovie) as List<Movie>?;
  //   if (movie != null) {
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      // ignore: prefer_const_constructors
      backgroundColor: Color(0xFFD2FFF4),

      // ig
    );
  }
}
