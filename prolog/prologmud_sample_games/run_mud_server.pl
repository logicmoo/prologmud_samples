#!/usr/bin/env swipl
/* * module  MUD server startup script in SWI-Prolog

?- 
 consult(library(prologmud_sample_games/run_mud_server)).


*/
% ==============================================
% INIT LOCAL DIR
% ==============================================
:- use_module(library(prolog_autoload)).
:- use_module(library(prolog_pack)).
:- user:[library('theme/auto.pl')].
:- multifile(user:file_search_path/2).
:-   dynamic(user:file_search_path/2).


:- if( \+ exists_source(library(sldnfdraw))).
:- attach_packs('/opt/logicmoo_workspace/packs_lib').
:- endif.
:- if( \+ exists_source(library(pfc))).
:- attach_packs('/opt/logicmoo_workspace/packs_sys').
:- endif.
:- if( \+ exists_source(library(lps_syntax))).
:- attach_packs('/opt/logicmoo_workspace/packs_web').
:- endif.

mudSubPart(face,isEach(eyes,nose,mouth)).
mudSubPart([upper_torso,arms,left_arm,left_hand,left_digits]).
mudSubPart([upper_torso,arms,right_arm,right_hand,right_digits]).
mudSubPart([pelvis,legs,left_leg,left_foot,left_toes]).
mudSubPart([pelvis,legs,right_leg,right_foot,right_toes]).

:- multifile swish_config:reply_page/1. % redefine SWISH's page maker:
:- dynamic swish_config:reply_page/1. % redefine SWISH's page maker:
:- ['/opt/logicmoo_workspace/packs_web/swish/run_swish_and_clio'].

:- listing(handler).
:- listing(file_search_path).
:- threads.

:- prolog_load_context(directory,D),cd(D).


%:- if(current_prolog_flag(argv,[])).
%  sudo -u prologmud_server gdb -x gdbinit -return-child-result -ex "set pagination off" -ex run -ex quit --args swipl -l run_mud_server.pl --all --world --repl --lisp --lispsock --sumo --planner --nonet --repl --noworld
:- if(\+ ((current_prolog_flag(argv,X),member(E,X),atom_concat('--',_,E)))).
:- current_prolog_flag('argv',WasArgV),
   append(WasArgV,[         
   '--','--all','--pdt','--world','--repl','--lisp','--lispsock','--sumo', '--planner',
   '--cliop','--sigma','--www', '--irc','--swish','--docs','--plweb',   
   '--no-fork', '--workers=16', '--port=3020', 
   %'--user=www-data',
   % '--nonet' '--noworld',
   '--logtalk',
   '--elfinder', '--defaults' ], NewArgV),
   set_prolog_flag('argv',NewArgV).

:- current_prolog_flag('argv',Is),writeq(set_prolog_flag('argv',Is)),!,nl.
:- endif.
%:- endif.


:- attach_packs('/opt/logicmoo_workspace/packs_web/plweb/packs').

% :- cpack_install([prov,amalgame,skos,cpack_repository,media_cache,'EDM','cloud',trill_on_swish,ecdemo,command,rdf_qa,waisda,jquery,accurator,pirates,cluster_search_ui,skos_browser,tag_matcher,statistics,opmv,vumix]).

:- pack_list_installed.

:- set_prolog_flag(ec_loader,false).

%:- break.


%:- abolish(system:trace,0).
%:- asserta(system:trace).
% :- set_prolog_flag(encoding,text).

:- use_module(library(http/http_path)).
:- multifile http:location/3.
:- dynamic   http:location/3.
http:location(root, '/', []).
http:location(swish, '/swish', []).

:- '$set_typein_module'(baseKB).
:- '$set_source_module'(baseKB).
:- ensure_loaded(library(nomic_mu)).
% http://gitlab.logicmoo.org:3020/pldoc/pack/
%:- asserta((pldoc_http:doc_enabled:-!)).

% ==============================================
% [Required] Load the Logicmoo User System
% ==============================================
:- ensure_loaded(library(logicmoo_lib)).


% ==============================================
% ============= MUD SERVER CODE LOADING =============
% ==============================================

:- baseKB:ensure_loaded(library(logicmoo_mud)).


%:- user:['/opt/logicmoo_workspace/packs_web/plweb/plweb.pl'].
%:- doc_enable(true).
%:- plweb:with_mutex(plweb_init, server_init).
% :- plweb:server([port(3020)]).

/*
:- break.

blast_op(OP):- forall(current_op(_,XFX,OP),op(0,XFX,OP)).
:- blast_op(false).
:- blast_op(if).
:- blast_op(then).
:- blast_op(else).
*/

% :- prolog_load_context(directory,D), cd('/home/prologmud_server/lpn/www'),user:[server],cd(D).


end_of_file.
end_of_file.
end_of_file.
end_of_file.
end_of_file.
end_of_file.
end_of_file.
end_of_file.
end_of_file.
end_of_file.
end_of_file.
end_of_file.









end_of_file.
end_of_file.
end_of_file.
end_of_file.
end_of_file.

:- ensure_loaded(baseKB:library('logicmoo/common_logic/common_logic_clif.pfc')).
:- ensure_loaded(baseKB:library('logicmoo/common_logic/common_logic_sumo.pfc')).

:- kif_compile.

:- mpred_trace_all.
:- zebra0.
:- forall(trait(P),listing(P)).


% :- zebra5.
% :- rtrace.
% :- mpred_trace_exec.
%:- zebra.
%:- clif_show.

%:- break.


