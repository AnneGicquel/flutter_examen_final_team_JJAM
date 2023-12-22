import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/departement.dart';
import 'package:flutter_examen1/pages/communes_page.dart';
import 'package:flutter_examen1/services/departementService.dart';

class DepartementLister extends StatefulWidget {
  const DepartementLister(
      {super.key, required this.regionCode, required this.regionName});

  final String regionCode;
  final String regionName;

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
      departements = DepartementService.getDepartements(widget.regionCode);
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context)
                    .size
                    .width, //largeur totale de l'écran
                color: Colors.blue.withOpacity(0.2),
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Le département : ${widget.regionName}, compte ${departements.length} communes.\nCliquez sur l'une des communes suivantes pour en savoir plus...",
                  style: const TextStyle(color: Colors.black),
                ),
              ),


Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.departements.length,
                  itemBuilder: (context, index) {
                    Departement departement = departements[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTapDown: (details) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CommunePage(
                                regionCode: widget.regionCode,
                                selectedCommune: departement,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(departement.nom),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(departement.code),
                                Text('\$${departement.codeRegion}'),
                              ],
                            ),
                            onTap: () {
                              print("liyhkujhgkjgkjuhgjgj");
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );

          // la requête a provoqué une erreur
        } else if (snapshot.hasError) {
          return Text("error: ${snapshot.error}");
        }
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_examen1/models/departement.dart';
// import 'package:flutter_examen1/pages/communes_page.dart';
// import 'package:flutter_examen1/services/departementService.dart';

// class DepartementLister extends StatefulWidget {
//   const DepartementLister(
//       {super.key, required this.regionCode, required this.regionName});

//   final String regionCode;
//   final String regionName;

//   @override
//   State<DepartementLister> createState() => _DepartementListerState();
// }

// class _DepartementListerState extends State<DepartementLister> {
//   late Future<DepartementsList?> departements;

//   @override
//   void initState() {
//     super.initState();
//     loadDepartements();
//   }

//   void loadDepartements() {
//     setState(() {
//       departements = DepartementService.getDepartements(widget.regionCode);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: departements,
//         builder: (context, snapshot) {
//           // Les données sont arrivées sans erreur:
//           if (snapshot.hasData) {
//             List<Departement> departements = snapshot.data!.departements;
//             return ListView.builder(
//                 itemCount: snapshot.data!.departements.length,
//                 itemBuilder: (context, index) {
//                   Departement departement = departements[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                       onTapDown: (details) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => CommunePage(
//                               regionCode: widget.regionCode,
//                               selectedCommune: departement,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         child: ListTile(
//                           title: Text(departement.nom),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(departement.code),
//                               Text('\$${departement.codeRegion}'),
//                             ],
//                           ),
//                           onTap: () {
//                           },
//                         ),
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
