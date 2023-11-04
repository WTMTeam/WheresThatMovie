import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheres_that_movie/api/models/provider_model.dart';

class OptionsDialog extends StatefulWidget {
  final Function(String) onOptionSelected;
  final String button;
  const OptionsDialog({
    super.key,
    required this.onOptionSelected,
    required this.button,
  });

  @override
  State<OptionsDialog> createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  late Future<List<Provider>> futureProviders;

  @override
  void initState() {
    super.initState();
    // loadUsers();
    // futureUsers = UserService().getUser();
    // getAllFilms();
    futureProviders = ProviderService().getProviders();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    String alertTitle = "";
    if (widget.button == "Provider") {
      alertTitle = "Streaming Service";
    } else if (widget.button == "Genre") {
      alertTitle = "Genre";
    } else if (widget.button == "movieOrShow") {
      alertTitle = "Movie or TV-Show";
    } else if (widget.button == "length") {
      alertTitle = "Choose Length";
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // title: Text(alertTitle),
      insetPadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: SizedBox(
        width: screenWidth / 1.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              heightFactor: 0.35,
              // alignment: Alignment.topRight,
              alignment: const Alignment(1.1, -0.1),
              child: IconButton(
                splashRadius: 10,
                padding: const EdgeInsets.all(0.0),
                icon: Icon(
                  CupertinoIcons.xmark_circle,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    alertTitle,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Divider(
                thickness: 5.0,
                // color: Colors.red,
              ),
            ),

            // Convert the iterable to a list of widgets
            // Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, b))

            // ...options.map((option) => ListTile(
            //       title: Text(option),
            //       onTap: () {
            //         onOptionSelected(option);
            //         Navigator.pop(context);
            //       },
            //     )),
            // * If the Provider Button was pressed
            // ! Not working
            (widget.button == "Provider")
                ? FutureBuilder<List<Provider>>(
                    future: futureProviders,
                    builder: ((context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              Provider provider = snapshot.data?[index];
                              String imgUrl =
                                  "https://image.tmdb.org/t/p/w45${provider.logoPath}";
                              return ListTile(
                                title: Text(provider.providerName),
                                subtitle:
                                    Text(provider.displayPriority.toString()),
                                trailing: CachedNetworkImage(
                                  imageUrl: imgUrl,
                                  width: 50.0,
                                  errorWidget: (context, imgUrl, error) =>
                                      const Icon(Icons.no_photography_outlined,
                                          size: 50),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: Colors.amberAccent,
                              );
                            },
                            itemCount: 20);
                        // itemCount: snapshot.data!.length);
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }),
                  )
                : const Text("test")
          ],
        ),
      ),
    );
  }
}
