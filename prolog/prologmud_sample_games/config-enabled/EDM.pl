:- module(conf_EDM, []).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdfs)).
:- use_module(cliopatria(hooks)).

/** <module> View Europeana Data Model

This config installs hooks into the  system   to  vizualise parts of the
Europeana Data Model (EDM).
*/

:- rdf_register_ns(ens, 'http://www.europeana.eu/schemas/edm/').
:- rdf_register_ns(ore, 'http://www.openarchives.org/ore/terms/').

:- use_module(components(edm/components)).
:- use_module(components(edm/graph)).

cliopatria:display_link(R, Options) -->
	edm_display_link(R, Options).

cliopatria:context_graph(R, RDF, Options) :-
	edm_context_graph(R, RDF, Options).

cliopatria:node_shape(URI, Shape, Options) :-
	edm_node_shape(URI, Shape, Options).

cliopatria:list_resource(Proxy) -->
	{ rdfs_individual_of(Proxy, ore:'Proxy') },
	edm_proxy_view(Proxy, []).

cliopatria:format_search_result(Proxy, _Graph) -->
	{ rdfs_individual_of(Proxy, ore:'Proxy') },
	edm_result_summary(Proxy, []).
