:- module(conf_autocompletion, []).

/** <module> Configurable autocompletion webservice
*/

% define skos: namespace prefix and load  SKOS RDF schema:
:- use_module(library(skos_schema)).
:- use_module(api(autocomplete_api)).
