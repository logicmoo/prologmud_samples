:- module(conf_isearch, []).
:- use_module(library(http/http_dispatch)).
:- use_module(isearch(applications/isearch)).
:- use_module(cliopatria(hooks)).

/** <module> Interactive search

Provide interactive search based on   property-chains and multi-facetted
browsing.

@author Michiel Hildebrand
*/

% Hijack the search-field, redirecting the queries to the interactive
% search page.

:- http_handler(cliopatria(isearch_literal),
		isearch_page([ header(false),
			       query_type(literal)
			     ]),
		[id(list_triples_with_literal), priority(10)]).
:- http_handler(cliopatria(isearch),
		isearch_page([ header(false)
			     ]),
		[id(search), priority(10)]).




