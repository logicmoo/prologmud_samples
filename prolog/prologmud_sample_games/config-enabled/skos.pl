:- module(conf_skos, []).

/** <module> Provide SKOS visualization hooks.

This module provides hooks for showing SKOS entities
*/
:- use_module(cliopatria(hooks)).
:- use_module(library(semweb/rdfs)).
:- use_module(library(skos_schema)).
:- use_module(components(skos/components)).
:- use_module(components(skos/graph)).

cliopatria:context_graph(R, RDF, Options) :-
	skos_context_graph(R, RDF, Options).

cliopatria:node_shape(URI, Shape, Options) :-
	skos_node_shape(URI, Shape, Options).
