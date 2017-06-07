/* Generated file
   This file defines the search-path for added packs
*/

:- module(conf_packs, []).

:- multifile user:file_search_path/2.
:- dynamic user:file_search_path/2.
:- multifile cpack:registered_cpack/2.

:- cpack_register(trill_on_swish,'cpack/trill_on_swish',[home_url('http://cliopatria.swi-prolog.org/packs/trill_on_swish'),requires([])]).
:- cpack_register(webaccess,'cpack/webaccess',[home_url('http://cliopatria.swi-prolog.org/packs/webaccess'),requires([])]).
:- cpack_register('EDM','cpack/EDM',[home_url('http://cliopatria.swi-prolog.org/packs/EDM'),requires([webaccess])]).
:- cpack_register(find_resource,'cpack/find_resource',[home_url('http://cliopatria.swi-prolog.org/packs/find_resource'),requires([])]).
:- cpack_register(skos,'cpack/skos',[home_url('http://cliopatria.swi-prolog.org/packs/skos'),requires([])]).
:- cpack_register(autocompletion,'cpack/autocompletion',[home_url('http://cliopatria.swi-prolog.org/packs/autocompletion'),requires([find_resource,skos])]).
:- cpack_register(prov,'cpack/prov',[home_url('http://cliopatria.swi-prolog.org/packs/prov'),requires([])]).
:- cpack_register(yui3,'cpack/yui3',[home_url('http://cliopatria.swi-prolog.org/packs/yui3'),requires([])]).
:- cpack_register(skos_browser,'cpack/skos_browser',[home_url('http://cliopatria.swi-prolog.org/packs/skos_browser'),requires([skos,yui3])]).
:- cpack_register(statistics,'cpack/statistics',[home_url('http://cliopatria.swi-prolog.org/packs/statistics'),requires([])]).
:- cpack_register(void,'cpack/void',[home_url('http://cliopatria.swi-prolog.org/packs/void'),requires([])]).
:- cpack_register(amalgame,'cpack/amalgame',[home_url('http://cliopatria.swi-prolog.org/packs/amalgame'),requires([autocompletion,prov,skos,skos_browser,statistics,void,yui3])]).
:- cpack_register(cloud,'cpack/cloud',[home_url('http://cliopatria.swi-prolog.org/packs/cloud'),requires([])]).
:- cpack_register(owl,'cpack/owl',[home_url('http://cliopatria.swi-prolog.org/packs/owl'),requires([])]).
:- cpack_register(isearch,'cpack/isearch',[home_url('http://cliopatria.swi-prolog.org/packs/isearch'),requires([owl,statistics])]).
:- cpack_register(ecdemo,'cpack/ecdemo',[home_url('http://cliopatria.swi-prolog.org/packs/ecdemo'),requires(['EDM',amalgame,cloud,isearch])]).
:- cpack_register(foaf,'cpack/foaf',[home_url('http://cliopatria.swi-prolog.org/packs/foaf'),requires([])]).
:- cpack_register(foaf_user,'cpack/foaf_user',[home_url('http://cliopatria.swi-prolog.org/packs/foaf_user'),requires([foaf])]).
:- cpack_register(cpack_repository,'cpack/cpack_repository',[home_url('http://cliopatria.swi-prolog.org/packs/cpack_repository'),requires([foaf,foaf_user,isearch])]).
:- cpack_register(swish,'cpack/swish',[home_url('http://cliopatria.swi-prolog.org/packs/swish'),requires([])]).
