// service_selector.dart
// Author: Samuel Rudqvist
// Date Created: 09/26/2022
//

//********************************************************************//
//*       This is the container for displaying the streaming         *//
//*               services in the user's list.                       *//
//********************************************************************//


import 'package:flutter/material.dart';
import 'package:streaming_service_lister/widgets/my_container.dart';

class MyListContainer extends StatefulWidget {
  const MyListContainer({Key? key}) : super(key: key);

  @override
  State<MyListContainer> createState() => _MyListContainerState();
}

class Movie{
  String name;
  int testInt;

  Movie({required this.name, required this.testInt});
}

class TvShow{
  String name;
  int testInt;

  TvShow({required this.name, required this.testInt});
}

class _MyListContainerState extends State<MyListContainer> {
  
  List<String> myList = ["test", "test2","test5"];
  List<Movie> movieList = [];
  List<TvShow> tvShowList = [];
  
  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        children: <Widget>[
          
          Column(
            children: <Widget>[
              // Check if myList is empty 
              myList.isEmpty? 
                Text(
                  "Add a Movie or Show",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ):
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0,),
                  child: Text(
                    "Your List",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: myList.length,
                  // prototypeItem: ListTile(
                  //   title: Text(myList.first)
                  // ),
                  itemBuilder: ((context, index) {
                    return ListTile(
                      //minVerticalPadding: 0.0,
                      dense: true,
                      visualDensity: const VisualDensity(vertical: 0.0),
                      title: Text(
                        myList[index],
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),  
                ),
            ],
          )
          
            
            // ListView(
            //       children: [
            //         for (var item in myList) 
            //         Text(
            //           item, 
            //           style: TextStyle(
            //             color: Theme.of(context).primaryColor,
            //             fontSize: 20.0,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         )
            //       ],
            //     ),
                
                
              
              
          //),
        ],
      )
    );
  }
}