:- module(conf_skos_browser, []).

:- use_module(library(semweb/rdf_library)).
:- use_module(library(skos_schema)).

/** <module> SKOS vocabulary browser
*/

http:location(skosbrowser, cliopatria(skos/browse), []).
http:location(skosapi, cliopatria(skos/api), []).

:- use_module(api(skos_concepts)).
:- use_module(applications(skos_browser)).

% I rather have the application do stuff like this:
% :- rdf_attach_library(vocs). 
