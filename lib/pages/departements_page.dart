import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/departementLister.dart';

class DepartementsPage extends StatelessWidget {
  const DepartementsPage(
      {super.key, required this.regionName, required this.regionCode});

  final String regionName;
  final String regionCode;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Barre d'applications (AppBar)
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Région : $regionName",
          style: const TextStyle(
            color: Colors.white,
          ),),),
            
            
        body: Flexible(child: DepartementLister(regionCode: regionCode, regionName:regionName)));
  }
}

