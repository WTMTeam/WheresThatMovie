import 'package:flutter/material.dart';
import '../../../widgets/my_container.dart';

class MyListContainer extends StatelessWidget {
  //const MyListContainerTest({Key? key}) : super(key: key);

  final List<String> myList;
  final Function(String) onRemoved;
  const MyListContainer({Key? key, required this.myList, required this.onRemoved}) : super(key: key);

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
                  // Build each item of the list
                  itemBuilder: ((context, index) {
                    return ListTile(
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
                      trailing: IconButton(
                        // Send the item that is to be removed to my_list.dart
                        onPressed: (){
                          final itemToRemove = myList[index];
                          onRemoved(itemToRemove);
                        },
                        icon: const Icon(Icons.delete_outline)
                      ),
                    );
                  }),  
                ),
            ],
          )
        ],
      )
    );
  }
}