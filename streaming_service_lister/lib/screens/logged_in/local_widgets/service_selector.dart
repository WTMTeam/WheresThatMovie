// service_selector.dart
// Author: Samuel Rudqvist
// Date Created: 09/10/2022
//

//********************************************************************//
//*       This is the container for selecting the streaming          *//
//*               services to include in the search.                 *//
//********************************************************************//


import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:streaming_service_lister/widgets/my_container.dart';

class MyServiceSelector extends StatefulWidget {
  const MyServiceSelector({Key? key}) : super(key: key);
  
  

  @override
  State<MyServiceSelector> createState() => _MyServiceSelectorState();


}

class _MyServiceSelectorState extends State<MyServiceSelector> {

  bool netflixValue = false;
  bool huluValue = false;
  bool amazonValue = false;

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0,),
            child: Text(
              "Select Streaming Services",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0, 
                  horizontal: 8.0),
              ),
              Expanded(
                child: Text(
                  "Netflix",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              // 
              Checkbox(
                checkColor: const Color.fromARGB(255, 0, 255, 0),
                activeColor: const Color.fromARGB(0, 0, 0, 0),                
                value: netflixValue, 
                onChanged: (value){
                  setState(() {
                    netflixValue = value!;
                  });
                },
              ),
            ],
          ),

          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0, 
                  horizontal: 8.0),
              ),
              Expanded(
                child: Text(
                  "Amazon",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
                
              ),
              // 
              Checkbox(
                checkColor: const Color.fromARGB(255, 0, 255, 0),
                activeColor: const Color.fromARGB(0, 0, 0, 0),                
                value: amazonValue, 
                onChanged: (value){
                  setState(() {
                    amazonValue = value!;
                  });
                },
              ),

              // Switch(
              //   value: amazonValue, 
              //   onChanged: (value) {
              //     setState(() {
              //       amazonValue = value;
              //     });
              //   },
              //   activeColor: Colors.green,
              //   activeTrackColor: Colors.green,
              // ),
            ],
          ),
          
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0, 
                  horizontal: 8.0),
              ),
              Expanded(
                child: Text(
                  "Hulu",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
                
              ),
              // 

              Checkbox(
                checkColor: const Color.fromARGB(255, 0, 255, 0),
                activeColor: const Color.fromARGB(0, 0, 0, 0),                
                value: huluValue, 
                onChanged: (value){
                  setState(() {
                    huluValue = value!;
                  });
                },
              ),

            ],
          ),

        ],
      ),
    );
  }
}

// class MyServiceSelector1 extends StatefulWidget {
//   MyServiceSelector1({Key? key}) : super(key: key);
//   bool netflixValue = false;
//   bool amazonValue = false;
//   bool huluValue = false;

//   @override
//   Widget build(BuildContext context) {
//     return MyContainer(
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0,),
//             child: Text(
//               "Select Streaming Services",
//               style: TextStyle(
//                 color: Theme.of(context).primaryColor,
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),

//           Row(
//             children: <Widget>[
//               const Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 20.0, 
//                   horizontal: 8.0),
//               ),
//               Expanded(
//                 child: Text(
//                   "Netflix",
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               // TODO: add checkbox here
//               Checkbox(
//                 checkColor: Color.fromARGB(255, 0, 255, 0),
//                 activeColor: Colors.red,
//                 value: netflixValue, 
//                 onChanged: (bool value){
//                   setState(() {
//                     netflixValue = value;
//                   });
//                 },
//               ),
//             ],
//           ),

//           Row(
//             children: <Widget>[
//               const Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 20.0, 
//                   horizontal: 8.0),
//               ),
//               Expanded(
//                 child: Text(
//                   "Amazon",
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 16,
//                   ),
//                 ),
                
//               ),
//               // TODO: add checkbox here
//             ],
//           ),
          
//           Row(
//             children: <Widget>[
//               const Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 20.0, 
//                   horizontal: 8.0),
//               ),
//               Expanded(
//                 child: Text(
//                   "Hulu",
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 16,
//                   ),
//                 ),
                
//               ),
//               // TODO: add checkbox here
//             ],
//           ),

//         ],
//       ),
//     );
//   }
// }

