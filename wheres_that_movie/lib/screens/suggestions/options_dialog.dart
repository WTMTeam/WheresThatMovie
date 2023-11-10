import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheres_that_movie/api/models/provider_model.dart';

class OptionsDialog extends StatefulWidget {
  final Function(dynamic) onOptionSelected;
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
  // * Provider variables
  late Future<List<Provider>> futureProviders;
  List<Provider> selectedProviders = [];

  // * Length variables

  // * Genre variables

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
              // heightFactor: 0.35,
              alignment: Alignment.topRight,
              // alignment: const Alignment(1.0, -1.0),
              child: IconButton(
                splashRadius: 10,
                padding: const EdgeInsets.all(0.0),
                icon: selectedProviders.isEmpty
                    ? Icon(
                        CupertinoIcons.xmark_circle,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      )
                    : Icon(
                        CupertinoIcons.check_mark_circled,
                        size: 30,
                        color: Colors.green.shade800,
                      ),
                onPressed: () {
                  if (widget.button == "Provider") {
                    widget.onOptionSelected(selectedProviders);
                  }

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

            // * If the Provider Button was pressed
            (widget.button == "Provider")
                ? FutureBuilder<List<Provider>>(
                    future: futureProviders,
                    builder: ((context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                Provider provider = snapshot.data?[index];
                                String imgUrl =
                                    "https://image.tmdb.org/t/p/w45${provider.logoPath}";
                                bool isSelected =
                                    selectedProviders.contains(provider);
                                return ListTile(
                                    leading: CachedNetworkImage(
                                      imageUrl: imgUrl,
                                      width: 50.0,
                                      errorWidget: (context, imgUrl, error) =>
                                          const Icon(
                                              Icons.no_photography_outlined,
                                              size: 50),
                                    ),
                                    title: Text(provider.providerName),
                                    subtitle: Text(
                                        provider.displayPriority.toString()),
                                    trailing: Checkbox(
                                        value: isSelected,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value != null) {
                                              if (value) {
                                                selectedProviders.add(provider);
                                              } else {
                                                selectedProviders
                                                    .remove(provider);
                                              }
                                            }
                                          });
                                        }));
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: Colors.amberAccent,
                                );
                              },
                              itemCount: 20),
                        );
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
