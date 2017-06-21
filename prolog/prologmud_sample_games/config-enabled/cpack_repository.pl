:- module(conf_cpack_repository, []).
:- use_module(cpack_repository(applications/cpack_submit)).
:- use_module(cpack_repository(applications/cpack_home)).
:- use_module(library(http/http_path)).
:- use_module(user(user_db)).
:- use_module(cliopatria(hooks)).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdf_library)).

:- use_module(library(http/http_dispatch)).

/** <module> CPACK repository interface
*/

http:location(cpack, root(cpack), []).

cliopatria:menu_popup_order(cpack, 250).
cliopatria:menu_label(cpack, 'CPACK').

cliopatria:menu_item( 50=cpack/cpack_home,	 	   'Home').
cliopatria:menu_item(100=cpack/cpack_list_packages,	   'List packs').
cliopatria:menu_item(200=cpack/cpack_submit_form,	   'Submit pack').
cliopatria:menu_item(300=cpack/cpack_clone_server_form,	   'Clone server') :-
	logged_on(admin).
cliopatria:menu_item(400=cpack/cpack_refresh_metadata_api, 'Refresh metadata') :-
	logged_on(_).
cliopatria:menu_item(275=current_user/cpack_my_packages,   'My CPACKs') :-
	logged_on(_).

:- rdf_attach_library(cliopatria(rdf)).
:- rdf_load_library(cpack).
:- rdf_load_library(owl).
:- rdf_load_library(dcterms).
:- rdf_load_library(graphviz).

% Hack, make submittedBy work for rdf_has/3.

:- rdf_set_predicate(cpack:submitted,   inverse_of(cpack:submittedBy)).
:- rdf_set_predicate(cpack:submittedBy, inverse_of(cpack:submitted)).
:- rdf_set_predicate(cpack:resolves,    inverse_of(cpack:resolvesAs)).
:- rdf_set_predicate(cpack:resolvesAs,  inverse_of(cpack:resolves)).

% CPACK is an extension of ClioPatria and uses the ClioPatria skin.

:- multifile
	user:body//2.

user:body(user(Style), Body) -->
	user:body(cliopatria(Style), Body).

% Tailor the package =isearch= (it is recommented to load that)

:- rdf_meta
	exclude_property(r).

cliopatria:facet_exclude_property(P) :-
	exclude_property(P).

exclude_property(cpack:repository).
exclude_property(cpack:base).
exclude_property(cpack:path).
exclude_property(cpack:size).
