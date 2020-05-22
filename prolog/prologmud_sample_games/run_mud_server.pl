#!/usr/bin/env swipl
/* * module  MUD server startup script in SWI-Prolog

?- 
 consult(library(prologmud_sample_games/run_mud_server)).


*/
% ==============================================
% INIT LOCAL DIR
% ==============================================

:- use_module(library(logicmoo_utils_all)).

:- attach_packs('/opt/logicmoo_workspace/packs_lib').
:- attach_packs('/opt/logicmoo_workspace/packs_web').
%
%:- user:['swish/server.pl'].
%:- listing(handler).
%:- listing(file_search_path).
%:- threads.
/*

% 
:- multifile swish_config:reply_page/1. % redefine SWISH's page maker:
:- dynamic swish_config:reply_page/1. % redefine SWISH's page maker:
:- user:['swish/swish.pl'].
:- user:['swish/server.pl'].
% :- assertz(user:file_search_path(swish,'swish/')).
:- user:['lps_corner/swish/user_module_clio.pl'].
:- server:server('0.0.0.0':3020).

:- break.

:- ['run-clio'].
*/

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



:- user:[library('theme/auto.pl')].

:- use_module(library(prolog_pack)).
:- multifile(user:file_search_path/2).
:-   dynamic(user:file_search_path/2).

:- attach_packs('/opt/logicmoo_workspace/packs_web/plweb/packs').
:- attach_packs('/opt/logicmoo_workspace/packs_lib').

% :- cpack_install([prov,amalgame,skos,cpack_repository,media_cache,'EDM','cloud',trill_on_swish,ecdemo,command,rdf_qa,waisda,jquery,accurator,pirates,cluster_search_ui,skos_browser,tag_matcher,statistics,opmv,vumix]).

:- pack_list_installed.

:- set_prolog_flag(ec_loader,false).

:- break.


:- abolish(system:trace,0).
:- asserta(system:trace).
% :- set_prolog_flag(encoding,text).


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


