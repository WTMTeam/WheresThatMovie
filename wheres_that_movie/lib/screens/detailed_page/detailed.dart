// detailed.dart
// Author: Samuel Rudqvist
// Created Date: Feb 12 2023
// Purpose:
//    The detailed screen provides details about where the
//    movie or show is available for Streaming, Buying and Renting.
//
// Modification Log:
//    (03/07/2023)(SR): Removed dead code.
//    (03/07/2023)(SR): Changed deprecated headlines and interpolation
//                      for the image path for the icons.
//    (04/07/2023)(SR): AppBar added and styling changes, netflix route works
//                      when the netflix app is installed.
//

// ! check out Hero widget
// * https://www.youtube.com/watch?v=M9J-JJOuyE0

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wheres_that_movie/database/database_helper.dart';
import 'package:wheres_that_movie/screens/detailed_page/local_widgets/country_dropdown.dart';
import 'package:wheres_that_movie/widgets/flash_message.dart';
import 'package:wheres_that_movie/widgets/my_container.dart';

class DetailedPage extends StatefulWidget {
  final int id;
  final bool isMovie;

  const DetailedPage({
    Key? key,
    required this.id,
    required this.isMovie,
  }) : super(key: key);

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  final String apiKey = 'dbffa0d16fb8dc2873531156a5c5f41a';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYmZmYTBkMTZmYjhkYzI4NzM1MzExNTZhNWM1ZjQxYSIsInN1YiI6IjYzODYzNzE0MDM5OGFiMDBjODM5MTJkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qQjwnSQLDfVNAuinpsM-ATK400-dnwuWUVirc7_AiQY';
  List streamingProviders = [];
  List logoPaths = [];
  List purchaseProviders = [];
  List locations = ["US", "SE"];
  List<String> options = ["Stream", "Buy", "Rent"];
  final List<String> supportedProviders = [
    'Netflix',
    'Disney Plus',
    'Paramount Plus',
    'Amazon Prime Video',
  ];

  String title = "No title";
  String posterPath = " No posterPath";
  String mediaType = "No mediaType";
  String description = "No description";
  String currentOption = "Stream";
  String countryCode = "";

  bool _isLoading = false;
  bool _wentWrong = false;
  bool _noSuchMethod = false;
  bool itemExists = false;

  List myList = [];

  late Map movieResult;
  late Map showResult;

  // Function to get the different providers for the
  // current movie or show
  getProviders(int id, String currentOption) async {
    _isLoading = true;
    _noSuchMethod = false;

    try {
      final tmdbWithCustomLogs = TMDB(
        //TMDB instance
        ApiKeys(apiKey, readAccessToken), //ApiKeys instance with your keys,
        logConfig: const ConfigLogger(
          showLogs: true, //must be true than only all other logs will be shown
          showErrorLogs: true,
        ),
      );

      Map providerResult;

      // Check if it is a movie or show and call the proper function \\

      if (widget.isMovie) {
        movieResult = await tmdbWithCustomLogs.v3.movies.getDetails(id);
        providerResult =
            await tmdbWithCustomLogs.v3.movies.getWatchProviders(id);
      } else {
        showResult = await tmdbWithCustomLogs.v3.tv.getDetails(id);
        providerResult =
            await tmdbWithCustomLogs.v3.tv.getWatchProviders(id.toString());
        // print(providerResult);
      }

      setState(() {
        if (widget.isMovie) {
          title = movieResult['title'];
          description = movieResult['overview'];
          posterPath = movieResult['poster_path'];
        } else {
          title = showResult['name'];
          description = showResult['overview'];
          posterPath = showResult['poster_path'];
        }
        if (currentOption == "Stream") {
          if (providerResult['results'][countryCode]['flatrate'] == null) {
            _noSuchMethod = true;
          } else {
            streamingProviders =
                providerResult['results'][countryCode]['flatrate'] ?? [];
            // print("link: ${providerResult['results'][countryCode]['link']}");
          }
        } else if (currentOption == "Buy") {
          if (providerResult['results'][countryCode]['buy'] == null) {
            _noSuchMethod = true;
          } else {
            streamingProviders =
                providerResult['results'][countryCode]['buy'] ?? [];
          }
        } else if (currentOption == "Rent") {
          if (providerResult['results'][countryCode]['rent'] == null) {
            _noSuchMethod = true;
          } else {
            streamingProviders =
                providerResult['results'][countryCode]['rent'] ?? [];
          }
        }
      });
      _isLoading = false;
    } on NoSuchMethodError {
      setState(() {
        _noSuchMethod = true;
        _isLoading = false;
      });
    } catch (e) {
      if (e is NoSuchMethodError) {
        setState(() {
          _isLoading = false;
          _noSuchMethod = true;
        });
      } else {
        setState(() {
          _isLoading = false;
          _wentWrong = true;
        });
      }
    }
  }

  getMyList() async {
    bool currExists = await SQLHelper.checkItem(widget.id);
    setState(() {
      itemExists = currExists;
    });
  }

  @override
  void initState() {
    currentOption = "Stream";
    getProviders(widget.id, currentOption);
    getMyList();

    super.initState();
  }

  final ScrollController _myController = ScrollController();

  // void launchNetflix(String movieId) async {
  //   final netflixScheme = 'nflx://www.netflix.com/title/$movieId';
  //   final webUrl = 'https://www.netflix.com/title/$movieId';
  //   // print("Web URL: $webUrl");
  //   if (await canLaunchUrl(Uri.parse(netflixScheme))) {
  //     await launchUrl(Uri.parse(netflixScheme));
  //   } else {
  //     await launchUrl(Uri.parse(webUrl));
  //   }
  // }

  void openApp(String scheme) async {
    Uri appScheme = Uri.parse(scheme);
    if (Platform.isIOS) {
      // iOS-specific implementation
      print("IOS");
      if (await canLaunchUrl(appScheme)) {
        print("canlaunchUrl");
        await launchUrl(appScheme);
      } else {
        print("opening app in app store");
        switch (scheme) {
          case 'nflx://':
            await launchUrl(
                Uri.parse('https://itunes.apple.com/app/id363590051'));
            break;
          case 'disneyplus://':
            await launchUrl(
                Uri.parse('https://itunes.apple.com/app/id1446075923'));
            break;
          case 'paramountplus://':
            await launchUrl(Uri.parse(
                'https://itunes.apple.com/us/app/cbs-all-access-stream-tv/id530168168'));
            break;
          case 'primevideo://':
            await launchUrl(Uri.parse(
                'https://itunes.apple.com/us/app/amazon-prime-video/id545519333'));
            break;
          default:
        }
// url = Uri.parse('https://itunes.apple.com/app/id363590051');
        // await launchUrl(Uri.parse('https://itunes.apple.com/app/id363590051'));
        // throw 'Could not launch Netflix.';
      }
    } else {
      // Android-specific implementation
      //! Implement the rest of these
      const String appPackageName = 'com.netflix.mediaclient';
      if (await DeviceApps.isAppInstalled(appPackageName)) {
        await DeviceApps.openApp(appPackageName);
      } else {
        throw 'Could not launch Netflix.';
      }
    }
  }

  // Future<void> _launchInWebViewOrVC(Uri url, String provider) async {
  //   final netflixUrl =
  //       'https://itunes.apple.com/us/app/netflix/id363590051?mt=8';

  //   try {
  //     if (!await launchUrl(
  //       url,
  //       mode: LaunchMode.platformDefault,
  //       webViewConfiguration: const WebViewConfiguration(
  //           headers: <String, String>{'my_header_key': 'my_header_value'}),
  //     )) {
  //       throw Exception('Could not launch $url');
  //     }
  //   } catch (error) {
  //     // url for disney plus
  //     // url = Uri.parse('https://itunes.apple.com/app/id363590051');
  //     if (provider == "Netflix") {
  //       url = Uri.parse('https://itunes.apple.com/app/id363590051');
  //     } else if (provider == "Disney Plus") {
  //       url = Uri.parse('https://itunes.apple.com/app/id1446075923');
  //     } else if (provider == "Paramount Plus") {
  //       url = Uri.parse(
  //           'https://itunes.apple.com/us/app/cbs-all-access-stream-tv/id530168168');
  //     }
  //     if (!await launchUrl(
  //       url,
  //       mode: LaunchMode.platformDefault,
  //       webViewConfiguration: const WebViewConfiguration(
  //           headers: <String, String>{'my_header_key': 'my_header_value'}),
  //     )) {}
  //   }
  // }

  // Insert a new journal to the database
  Future<void> _addItem(
      int movieId, String movieTitle, String moviePath, bool isMovie) async {
    int isMovieInt = 0;
    if (isMovie) {
      isMovieInt = 1;
    }
    await SQLHelper.createItem(movieId, movieTitle, moviePath, isMovieInt);
    setState(() {
      getMyList();
    });
  }

  void _deleteItem(int movieOrShowId) async {
    List<Map<String, dynamic>> currItem =
        await SQLHelper.getItem(movieOrShowId);
    int id = currItem[0]['id'];
    await SQLHelper.deleteItem(id);
    getMyList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (_isLoading) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const <Widget>[
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    } else if (_wentWrong) {
      return Scaffold(
        // resizeToAvoidBottomInset: false,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Center(
              child: Text(
                "Something Went Wrong",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: title.length > 10
                ? Text(
                    title,
                    style: Theme.of(context).textTheme.displayMedium,
                    overflow: TextOverflow.ellipsis,
                  )
                : Text(
                    title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 10.0,
          ),
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: MyContainer(
                        child: Text(description,
                            style: Theme.of(context).textTheme.bodyLarge)),
                  ),
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: itemExists
                          ? const Text(
                              "Remove from My List",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text(
                              "Add to My List",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    onPressed: () {
                      if (itemExists) {
                        _deleteItem(widget.id);
                      } else {
                        _addItem(widget.id, title, posterPath, widget.isMovie);
                      }
                      getMyList();
                    },
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0)),
                      child: CountryDropdown(
                        onChanged: (code) {
                          countryCode = code;
                          // print("here");
                          getProviders(widget.id, currentOption);
                        },
                      )),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        // border: Border.all(color: Colors.red)),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    constraints: const BoxConstraints(maxHeight: 55.0),

                    // child: MyContainer(
                    child: Container(
                      // width: screenWidth - 100,
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(10.0),
                        dropdownColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        value: currentOption,
                        items: options
                            .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) => setState(
                          () {
                            if (value != null) currentOption = value;
                            getProviders(widget.id, currentOption);
                          },
                        ),
                      ),
                    ),
                  ),
                  // ),
                  _noSuchMethod
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: MyCustomErrorMessage(
                            errorText: currentOption,
                            isMovie: widget.isMovie,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          shrinkWrap: true,
                          itemCount: streamingProviders.length,
                          controller: _myController,
                          itemBuilder: ((context, index) {
                            print(streamingProviders[index]['provider_name']);
                            String imgUrl =
                                "https://image.tmdb.org/t/p/w45${streamingProviders[index]['logo_path']}";
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: MyContainer(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(5),
                                  leading: CachedNetworkImage(
                                    imageUrl: imgUrl,
                                    width: 50.0,
                                    errorWidget: (context, imgUrl, error) =>
                                        const Icon(
                                            Icons.no_photography_outlined,
                                            size: 50),
                                  ),
                                  title: Text(streamingProviders[index]
                                      ['provider_name']),
                                  // trailing: streamingProviders[index]
                                  //                 ['provider_name'] ==
                                  //             "Netflix" ||
                                  //         streamingProviders[index]
                                  //                 ['provider_name'] ==
                                  //             "Disney Plus" ||
                                  //         streamingProviders[index]
                                  //                 ['provider_name'] ==
                                  //             "Paramount Plus"

                                  trailing: supportedProviders.contains(
                                          streamingProviders[index]
                                              ['provider_name'])
                                      ? IconButton(
                                          icon: Icon(Icons.open_in_new),
                                          onPressed: () {
                                            if (streamingProviders[index]
                                                    ['provider_name'] ==
                                                "Netflix") {
                                              // launchNetflix(widget.id.toString());
                                              // print(widget.id);

                                              // _launchInWebViewOrVC(
                                              //     Uri.parse(
                                              //         //  dynamic providerName = streamingProviders[index]['provider_name'];
                                              //         "nflx://www.netflix.com/search?q=$title"),
                                              //     streamingProviders[index]
                                              //         ['provider_name']);

                                              // _launchInWebViewOrVC(Uri.parse(
                                              //     "https://www.netflix.com/watch/$widget.id"));
                                              openApp('nflx://');
                                            } else if (streamingProviders[index]
                                                    ['provider_name'] ==
                                                "Disney Plus") {
                                              openApp('disneyplus://');
                                              // _launchInWebViewOrVC(
                                              //     Uri.parse("disneyplus://"),
                                              //     streamingProviders[index]
                                              //         ['provider_name']);
                                            } else if (streamingProviders[index]
                                                    ['provider_name'] ==
                                                "Paramount Plus") {
                                              openApp('paramountplus://');
                                              // Search link https://www.paramountplus.com/search/
                                              // _launchInWebViewOrVC(
                                              //     Uri.parse(
                                              //         // "paramountplus://www.paramountplus.com/search/"));
                                              //         "paramountplus://"),
                                              //     streamingProviders[index]
                                              //         ['provider_name']);
                                            } else if (streamingProviders[index]
                                                    ['provider_name'] ==
                                                "Amazon Prime Video") {
                                              openApp('primevideo://');
                                            }
                                          },
                                        )
                                      : null,
                                ),
                              ),
                            );
                          })),
                  const SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ));
    }
  }
}
