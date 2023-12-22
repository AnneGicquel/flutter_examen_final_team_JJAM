// import 'package:flutter/material.dart';
// import 'package:flutter_examen1/components/departementLister.dart';

// class DepartementsPage extends StatelessWidget {
//   const DepartementsPage({
//     Key? key,
//     required this.regionName,
//     required this.regionCode,
//   });

//   final String regionName;
//   final String regionCode;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: kToolbarHeight + 20.0), 
//             child: DepartementLister(regionCode: regionCode, regionName: regionName),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width, //largeur totale de l'écran
//             color: Colors.blue.withOpacity(0.2), 
//             padding: const EdgeInsets.all(20.0),
//             child: Text(
//               "Le département : $regionName ($regionCode), compte ... communes.\nCliquez sur l'une des communes suivantes pour en savoir plus...",
//               style: TextStyle(color: Colors.black),
//               //textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text(
//           "Région : $regionName",
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }






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

// void _showDialog(BuildContext context, String regionName, String regionCode, String departements) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Colors.transparent, // Rend l'arrière-plan transparent
//         content: Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: const Color.fromRGBO(4, 160, 232, 0.8), // Couleur bleue semi-transparente
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Le département: $regionName ($regionCode) compte ${departements.length} communes. \nCliquez sur l'une des communes suivantes pour en savoir plus...",
//                 style: const TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 16.0),
//               // Ajoutez d'autres widgets pour afficher les communes ici
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           CloseButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
// );
// }

