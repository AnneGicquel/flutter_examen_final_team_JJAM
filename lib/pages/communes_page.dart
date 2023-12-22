import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/communeLister.dart';
import 'package:flutter_examen1/models/departement.dart';

class CommunePage extends StatelessWidget {
  const CommunePage({
    super.key,
    required this.regionCode,
    required this.selectedCommune,
  });

  final String regionCode;
  final Departement selectedCommune;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Département : ${selectedCommune.nom}",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: CommuneLister(
        regionCode: regionCode,
        selectedCommune: selectedCommune,
      ),
    );
  }
}