:- module(conf_cpack_server, []).
:- use_module(library(http/http_dispatch)).
:- use_module(api(cpack)).
:- use_module(api(lod)).

/** <module> Enable CPACK package services
*/

:- http_handler('/packs/', lod_api([]), [prefix]).
