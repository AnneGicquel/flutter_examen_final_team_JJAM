import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/departement.dart';
import 'package:flutter_examen1/services/departementService.dart';

class DepartementLister extends StatefulWidget {
  const DepartementLister({super.key});

  @override
  State<DepartementLister> createState() => _DepartementListerState();
}

class _DepartementListerState extends State<DepartementLister> {
  late Future<DepartementsList?> departements;

  @override
  void initState() {
    super.initState();
    loadDepartements();
  }

  void loadDepartements() {
    setState(() {
      departements = DepartementService.getDepartements();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: departements,
        builder: (context, snapshot) {
          // Les données sont arrivées sans erreur:
          if (snapshot.hasData) {
            List<Departement> departements = snapshot.data!.departements;
            return ListView.builder(
                itemCount: snapshot.data!.departements.length,
                itemBuilder: (context, index) {
                  Departement departement = departements[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      // You can customize Card properties here
                      child: ListTile(
                        title: Text(departement.nom),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(departement.code),
                            Text('\$${departement.codeRegion}'),
                          ],
                        ),
                        // You can handle onTap here
                        onTap: () {
                          // Add your onTap logic
                        },
                      ),
                    ),
                  );
                });
            // la requete a provoqué une erreur
          } else if (snapshot.hasError) {
            return Text("error: ${snapshot.error}");
          }
          return const Expanded(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }
}