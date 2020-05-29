#!/usr/bin/env swipl
/* * module  MUD server startup script in SWI-Prolog

?- 
 consult(library(prologmud_sample_games/run_mud_server)).


*/
:- current_prolog_flag('argv',Is),writeq(set_prolog_flag('argv',Is)),!,nl.
% :- cpack_install([prov,amalgame,skos,cpack_repository,media_cache,'EDM','cloud',trill_on_swish,ecdemo,command,rdf_qa,waisda,jquery,accurator,pirates,cluster_search_ui,skos_browser,tag_matcher,statistics,opmv,vumix]).

:- user:['/opt/logicmoo_workspace/packs_web/swish/remote_swish'].



:- user:ensure_loaded(library(lps_corner)).


:- cls.

:- binaryChop2:['/opt/logicmoo_workspace/packs_web/lps_corner/examples/binaryChop2'].


:- interpreter:must_lps_program_module(DB),
   elsewhere:listing(DB:_),
   DB:golps(X),
   listing(lps_program_module/1),
   wdmsg(X).
/*
:- break.

:- user:['/opt/logicmoo_workspace/packs_web/lps_corner/examples/goat.pl'].

:- interpreter:must_lps_program_module(DB),
   %elsewhere:listing(DB:_),   
   DB:golps(X),
   listing(lps_program_module/1),
   format('~N~p.~n',[X]).

:- break.

:- party:['/opt/logicmoo_workspace/packs_web/lps_corner/examples/party.pl'].

:- interpreter:must_lps_program_module(DB),
   elsewhere:listing(DB:_),   
   DB:golps(X),
   listing(lps_program_module/1),
   format('~N~p.~n',[X]).

:- break.
*/

% ==============================================
% INIT LOCAL DIR
% ==============================================

% :- prolog_load_context(directory,D),cd(D).


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
:- endif.


:- attach_packs('/opt/logicmoo_workspace/packs_web/plweb/packs').

:- current_prolog_flag('argv',Is),writeq(set_prolog_flag('argv',Is)),!,nl.
% :- cpack_install([prov,amalgame,skos,cpack_repository,media_cache,'EDM','cloud',trill_on_swish,ecdemo,command,rdf_qa,waisda,jquery,accurator,pirates,cluster_search_ui,skos_browser,tag_matcher,statistics,opmv,vumix]).

:- pack_list_installed.




:- listing(handler).
:- listing(file_search_path).
:- threads.


:- set_prolog_flag(ec_loader,false).

%:- break.


%:- abolish(system:trace,0).
%:- asserta(system:trace).
% :- set_prolog_flag(encoding,text).

:- baseKB:ensure_loaded(library(nomic_mu)).
% http://gitlab.logicmoo.org:3020/pldoc/pack/
%:- asserta((pldoc_http:doc_enabled:-!)).

% ==============================================
% [Required] Load the Logicmoo User System
% ==============================================
:- baseKB:ensure_loaded(library(logicmoo_lib)).


% ==============================================
% ============= MUD SERVER CODE LOADING =============
% ==============================================

:- baseKB:ensure_loaded(library(logicmoo_mud)).


:- if( exists_source('/opt/logicmoo_workspace/packs_web/plweb/plweb.pl') ).
%:- user:['/opt/logicmoo_workspace/packs_web/plweb/plweb.pl'].
%:- doc_enable(true).
%:- plweb:with_mutex(plweb_init, server_init).
% :- plweb:server([port(3020)]).
:- add_history(user:['/opt/logicmoo_workspace/packs_web/plweb/plweb.pl']).
:- add_history(plweb:with_mutex(plweb_init, server_init)).
:- endif.

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


