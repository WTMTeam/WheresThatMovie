# Where's That Movie?

Repository for an iOS app using the Flutter framework.










### Links for API and Attribution
https://www.themoviedb.org/about/logos-attribution
https://api.themoviedb.org/3/movie/744/watch/providers?api_key=dbffa0d16fb8dc2873531156a5c5f41a&locale=US

Hi @yurirp4, you can make a call to the /watch/providers method to see where it is streaming:

https://api.themoviedb.org/3/tv/88396/watch/providers?api_key=###
You can use append_to_response with this call as well:

https://api.themoviedb.org/3/tv/88396?api_key=###&append_to_response=watch/providers
You can also use discover to query details by provider and country:

https://api.themoviedb.org/3/discover/tv?api_key=###&with_watch_providers=337&watch_region=CA
To find Disney+ content in Canada, for example.
