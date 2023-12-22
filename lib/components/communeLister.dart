import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/commune.dart';
import 'package:flutter_examen1/models/departement.dart';
import 'package:flutter_examen1/services/communeService.dart';


class CommuneLister extends StatefulWidget {
  const CommuneLister({
    super.key,
    required this.regionCode,
    required this.selectedCommune,
  });

  final String regionCode;
  final Departement selectedCommune; // Utilisez le type Departement ici

  @override
  State<CommuneLister> createState() => _CommuneListerState();
}

class _CommuneListerState extends State<CommuneLister> {
  late Future<CommuneList?> communes;

  @override
  void initState() {
    super.initState();
    loadCommunes();
  }

  void loadCommunes() {
    setState(() {
      // Utilisez widget.selectedCommune.code au lieu de widget.regionCode
      communes = CommuneService.getCommunes(widget.selectedCommune.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: communes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data!.communes.isEmpty) {
          return const Center(child: Text("Aucune commune trouvée."));
        } else {
          List<Commune> communes = snapshot.data!.communes;
          return ListView.builder(
            itemCount: communes.length,
            itemBuilder: (context, index) {
              Commune commune = communes[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(commune.nom),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(commune.code),
                        Row(
                          children: [
                            Text("Population: ${commune.codeDepartement}"),
                            Text(
                                "Cde. Post.: ${commune.codesPostaux.join(',')}"),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Détails de la commune'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nom : ${commune.nom}'),
                                Text('Code : ${commune.code}'),
                                Text('Code Dep : ${commune.code}'),
                                Text('Siren : ${commune.code}'),
                                Text('Code Epci : ${commune.codeEpci}'),
                                Text("Population: ${commune.population.toString()}, "),
                                Text('Code postaux : ${commune.codeRegion}'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Fermer'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

// class CommuneLister extends StatefulWidget {
//   const CommuneLister({
//     Key? key,
//     required this.regionCode,
//     required this.selectedCommune,
//   }) : super(key: key);

//   final String regionCode;
//   final Departement selectedCommune; // Utilisez le type Departement ici

//   @override
//   State<CommuneLister> createState() => _CommuneListerState();
// }

// class _CommuneListerState extends State<CommuneLister> {
//   late Future<CommuneList?> communes;
//   @override
//   void initState() {
//     super.initState();
//     loadCommunes();
//   }

//   void loadCommunes() {
//     setState(() {
//       // Utilisez widget.selectedCommune.code au lieu de widget.regionCode
//       communes = CommuneService.getCommunes(widget.selectedCommune.code);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: communes,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Text("Error: ${snapshot.error}");
//         } else if (!snapshot.hasData || snapshot.data!.communes.isEmpty) {
//           return const Center(child: Text("Aucune commune trouvée."));
//         } else {
//           List<Commune> communes = snapshot.data!.communes;
//           return ListView.builder(
//             itemCount: communes.length,
//             itemBuilder: (context, index) {
//               Commune commune = communes[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: ListTile(
//                     title: Text(commune.nom),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text("Population: ${commune.population.toString()}, "),
//                             Text("Cde. Post.: ${commune.codesPostaux.join(',')}"),
//                           ],
//                         ),
//                       ],
//                     ),
//                     onTap: () {
//                       // Ajoutez votre logique onTap ici
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }


// class CommuneLister extends StatefulWidget {
//   const CommuneLister({
//     Key? key,
//     required this.regionCode,
//     required this.selectedCommune,
//   }) : super(key: key);

//   final String regionCode;
//   final Departement selectedCommune; // Utilisez le type Departement ici

//   @override
//   State<CommuneLister> createState() => _CommuneListerState();
// }

// class _CommuneListerState extends State<CommuneLister> {
//   late Future<CommuneList?> communes;

//   @override
//   void initState() {
//     super.initState();
//     loadCommunes();
//   }

//   void loadCommunes() {
//     setState(() {
//       // Utilisez widget.selectedCommune.code au lieu de widget.regionCode
//       communes = CommuneService.getCommunes(widget.selectedCommune.code);
//     });
//   }
//     @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: communes,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Text("Error: ${snapshot.error}");
//         } else if (!snapshot.hasData || snapshot.data!.communes.isEmpty) {
//           return const Center(child: Text("Aucune commune trouvée."));
//         } else {
//           List<Commune> communes = snapshot.data!.communes;
//           return ListView.builder(
//             itemCount: communes.length,
//             itemBuilder: (context, index) {
//               Commune commune = communes[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: ListTile(
//                     title: Text(commune.nom),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(commune.code),
//                         Row(
//                           children: [
//                             Text("Population: ${commune.codeDepartement}"),
//                             Text("Cde. Post.: ${commune.codesPostaux.join(',')}"),
//                           ],
//                         ),
//                       ],
//                     ),
//                     onTap: () {
//                       // Ajoutez votre logique onTap ici
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
 

// class CommuneLister extends StatefulWidget {
//   const CommuneLister({
//     super.key,
//     required this.regionCode, required Departement selectedCommune,
//   });

//   final String regionCode;

//   @override
//   State<CommuneLister> createState() => _CommuneListerState();
// }

// class _CommuneListerState extends State<CommuneLister> {
//   late Future<CommuneList?> communes;

//   @override
//   void initState() {
//     super.initState();
//     loadCommunes();
//   }

//   void loadCommunes() {
//     setState(() {
//       communes = CommuneService.getCommunes(widget.regionCode);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: communes,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Text("Error: ${snapshot.error}");
//         } else if (!snapshot.hasData || snapshot.data!.communes.isEmpty) {
//           return const Center(child: Text("Aucune commune trouvée."));
//         } else {
//           List<Commune> communes = snapshot.data!.communes;
//           return ListView.builder(
//             itemCount: communes.length,
//             itemBuilder: (context, index) {
//               Commune commune = communes[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: ListTile(
//                     title: Text(commune.nom),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(commune.code),
//                         Row(
//                           children: [
//                             Text("Population: ${commune.codeDepartement}"),
//                             Text("Cde. Post.: ${commune.codesPostaux.join(',')}"),
//                           ],
//                         ),
//                       ],
//                     ),
//                     onTap: () {
//                       // Ajoutez votre logique onTap ici
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_examen1/models/commune.dart';
// import 'package:flutter_examen1/services/communeService.dart';

// class CommuneLister extends StatefulWidget {
//   const CommuneLister(
//       {super.key, required this.regionCode, required this.communes});

//   final String regionCode;
//   final String communes;

//   @override
//   State<CommuneLister> createState() => _CommuneListerState();
// }

// class _CommuneListerState extends State<CommuneLister> {
//   late Future<CommuneList?> communes;

//   @override
//   void initState() {
//     super.initState();
//     loadCommunes();
//   }

//   void loadCommunes() {
//     setState(() {
//       communes = CommuneService.getCommunes(widget.regionCode);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: communes,
//         builder: (context, snapshot) {
//           // Les données sont arrivées sans erreur:
//           if (snapshot.hasData) {
//             List<Commune> communes = snapshot.data!.communes;
//             return ListView.builder(
//                 itemCount: snapshot.data!.communes.length,
//                 itemBuilder: (context, index) {
//                   Commune commune = communes[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       // You can customize Card properties here
//                       child: ListTile(
//                         title: Text(commune.nom),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(commune.code),
//                             Row(
//                               children: [
//                                 Text("Population: ${commune.codeDepartement}"),
//                                 Text("Cde. Post.: ${commune.codesPostaux.join(',')}"),
//                               ],
//                             ),
//                             // Text(commune.codeDepartement),
//                             // Text(commune.siren),
//                             // Text(commune.codeEpci),
//                             // Text(commune.codeRegion),
//                             // Text(),
//                             // Text(commune.population as String),
//                           ],
//                         ),
//                         // You can handle onTap here
//                         onTap: () {
//                           // Add your onTap logic
//                         },
//                       ),
//                     ),
//                   );
//                 });
//             // la requete a provoqué une erreur
//           } else if (snapshot.hasError) {
//             return Text("error: ${snapshot.error}");
//           }
//           return const Expanded(
//               child: Center(
//             child: CircularProgressIndicator(),
//           ));
//         });
//   }
// }
