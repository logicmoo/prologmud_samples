/* Generated file
   This file defines the search-path for added packs
*/

:- module(conf_packs, []).

:- multifile user:file_search_path/2.
:- dynamic user:file_search_path/2.
:- multifile cpack:registered_cpack/2.

%:- cpack_register(trill_on_swish,'cpack/trill_on_swish',[home_url('https://cliopatria.swi-prolog.org/packs/trill_on_swish'),requires([])]).
:- cpack_register(find_resource,'cpack/find_resource',[home_url('https://cliopatria.swi-prolog.org/packs/find_resource'),requires([])]).
:- cpack_register(foaf,'cpack/foaf',[home_url('https://cliopatria.swi-prolog.org/packs/foaf'),requires([])]).
:- cpack_register(foaf_user,'cpack/foaf_user',[home_url('https://cliopatria.swi-prolog.org/packs/foaf_user'),requires([foaf])]).
:- cpack_register(owl,'cpack/owl',[home_url('https://cliopatria.swi-prolog.org/packs/owl'),requires([])]).
:- cpack_register(statistics,'cpack/statistics',[home_url('https://cliopatria.swi-prolog.org/packs/statistics'),requires([])]).
:- cpack_register(isearch,'cpack/isearch',[home_url('https://cliopatria.swi-prolog.org/packs/isearch'),requires([owl,statistics])]).
:- cpack_register(cpack_repository,'cpack/cpack_repository',[home_url('https://cliopatria.swi-prolog.org/packs/cpack_repository'),requires([foaf,foaf_user,isearch])]).
:- cpack_register(skos,'cpack/skos',[home_url('https://cliopatria.swi-prolog.org/packs/skos'),requires([])]).
:- cpack_register(autocompletion,'cpack/autocompletion',[home_url('https://cliopatria.swi-prolog.org/packs/autocompletion'),requires([find_resource,skos])]).
:- cpack_register(prov,'cpack/prov',[home_url('https://cliopatria.swi-prolog.org/packs/prov'),requires([])]).
:- cpack_register(yui3,'cpack/yui3',[home_url('https://cliopatria.swi-prolog.org/packs/yui3'),requires([])]).
:- cpack_register(skos_browser,'cpack/skos_browser',[home_url('https://cliopatria.swi-prolog.org/packs/skos_browser'),requires([skos,yui3])]).
:- cpack_register(void,'cpack/void',[home_url('https://cliopatria.swi-prolog.org/packs/void'),requires([])]).
:- cpack_register(amalgame,'cpack/amalgame',[home_url('https://cliopatria.swi-prolog.org/packs/amalgame'),requires([autocompletion,prov,skos,skos_browser,statistics,void,yui3])]).
:- cpack_register(webaccess,'cpack/webaccess',[home_url('https://cliopatria.swi-prolog.org/packs/webaccess'),requires([])]).
:- cpack_register('EDM','cpack/EDM',[home_url('https://cliopatria.swi-prolog.org/packs/EDM'),requires([webaccess])]).
:- cpack_register(cloud,'cpack/cloud',[home_url('https://cliopatria.swi-prolog.org/packs/cloud'),requires([])]).
:- cpack_register(ecdemo,'cpack/ecdemo',[home_url('https://cliopatria.swi-prolog.org/packs/ecdemo'),requires(['EDM',amalgame,cloud,isearch])]).
:- cpack_register(rdf_qa,'cpack/rdf_qa',[home_url('https://cliopatria.swi-prolog.org/packs/rdf_qa'),requires([])]).
:- cpack_register(media_cache,'cpack/media_cache',[home_url('https://cliopatria.swi-prolog.org/packs/media_cache'),requires([])]).
:- cpack_register(tag_matcher,'cpack/tag_matcher',[home_url('https://cliopatria.swi-prolog.org/packs/tag_matcher'),requires([find_resource])]).
:- cpack_register(yaz,'cpack/yaz',[home_url('https://cliopatria.swi-prolog.org/packs/yaz'),requires([find_resource,isearch,tag_matcher,yui3])]).
%:- cpack_register(waisda,'cpack/waisda',[home_url('https://cliopatria.swi-prolog.org/packs/waisda'),requires([skos,yaz])]).
%:- cpack_register(swish,'cpack/swish',[home_url('https://cliopatria.swi-prolog.org/packs/swish'),requires([])]).
:- cpack_register(jquery,'cpack/jquery',[home_url('https://cliopatria.swi-prolog.org/packs/jquery'),requires([])]).
:- cpack_register(command,'cpack/command',[home_url('https://cliopatria.swi-prolog.org/packs/command'),requires([])]).
:- cpack_register(pirates,'cpack/pirates',[home_url('https://cliopatria.swi-prolog.org/packs/pirates'),requires([])]).
:- cpack_register(versioned_graph,'cpack/versioned_graph',[home_url('https://cliopatria.swi-prolog.org/packs/versioned_graph'),requires([])]).
:- cpack_register(annotation_service,'cpack/annotation_service',[home_url('https://cliopatria.swi-prolog.org/packs/annotation_service'),requires([versioned_graph])]).
:- cpack_register(cluster_search,'cpack/cluster_search',[home_url('https://cliopatria.swi-prolog.org/packs/cluster_search'),requires([find_resource,media_cache])]).
:- cpack_register(accurator,'cpack/accurator',[home_url('https://cliopatria.swi-prolog.org/packs/accurator'),requires([annotation_service,cluster_search,media_cache])]).
:- cpack_register(image_annotation,'cpack/image_annotation',[home_url('https://cliopatria.swi-prolog.org/packs/image_annotation'),requires([annotation_service,autocompletion,media_cache,yui3])]).
:- cpack_register(cluster_search_ui,'cpack/cluster_search_ui',[home_url('https://cliopatria.swi-prolog.org/packs/cluster_search_ui'),requires([image_annotation])]).
%:- cpack_register(vumix,'cpack/vumix',[home_url('https://cliopatria.swi-prolog.org/packs/vumix'),requires([annotation_service,autocompletion,find_resource,versioned_graph,yaz,yui3])]).
:- cpack_register(opmv,'cpack/opmv',[home_url('https://cliopatria.swi-prolog.org/packs/opmv'),requires([])]).
