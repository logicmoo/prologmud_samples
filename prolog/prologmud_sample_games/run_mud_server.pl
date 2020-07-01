#!/usr/bin/env swipl
/* * module  MUD server startup script in SWI-Prolog

?- 
 ignore(( \+ exists_source(library(prologmud_sample_games/run_mud_server)), 
     attach_packs('/opt/logicmoo_workspace/packs_sys'))),
 consult(library(prologmud_sample_games/run_mud_server)).

%  sudo -u prologmud_server gdb -x gdbinit -return-child-result -ex "set pagination off" -ex run -ex quit --args swipl -l run_mud_server.pl --all --nonet --noworld

*/


:- system:use_module(library(console_input)).
:- system:use_module(library(make)).
:- system:use_module(library(qsave)).
:- use_module(library(prolog_autoload)).
:- system:use_module(library(lists),[append/3]).
%:- '$set_source_module'(baseKB).
%:- 'module'(baseKB).
%:- set_prolog_flag(runtime_speed,0). % 0 = dont care
:- set_prolog_flag(runtime_speed, 0). % 1 = default
:- set_prolog_flag(runtime_debug, 3). % 2 = important but dont sacrifice other features for it
:- set_prolog_flag(runtime_safety, 3).  % 3 = very important
:- set_prolog_flag(unsafe_speedups, false).
:- set_prolog_flag(logicmoo_message_hook,dumpst).
:- set_prolog_flag(encoding,text).
:- set_prolog_flag(lisp_repl_goal,true).

load_package_dirs:- 
  findall(PackDir,'$pack':pack(Pack, PackDir),Before),
  ignore(( \+ exists_source(library(logicmoo_common)), attach_packs('/opt/logicmoo_workspace/packs_sys'))),
  ignore(( \+ exists_source(library(sldnfdraw)), attach_packs('/opt/logicmoo_workspace/packs_lib'))),
  ignore(( \+ exists_source(library(rserve_client)), attach_packs('/opt/logicmoo_workspace/packs_web/swish/pack'))),
  ignore(( \+ exists_source(library(lps_corner)), attach_packs('/opt/logicmoo_workspace/packs_web'))),
  % ignore(( \+ exists_source(pack(plweb/pack_info)), attach_packs('/opt/logicmoo_workspace/packs_web'))),
  findall(PackDir,'$pack':pack(Pack, PackDir),After),
  (Before==After -> dmsg(load_package_dirs) ; catch(pack_list_installed,_,true)),
  !.

 
:- initialization(load_package_dirs, now).
:- initialization(load_package_dirs, restore_state).
:- initialization(load_package_dirs, program).
% :- initialization(shell('./PreStartMUD.sh'),program).

:- current_prolog_flag('argv',Is),writeq(current_prolog_flag('argv',Is)),!,nl.

:- use_module(library(logicmoo_utils)).
:- use_module(library(logicmoo_common)).

:- autoload(library(apply),[maplist/2]).
:- autoload(library(lists),[member/2,append/3]).
:- if(\+ ((current_prolog_flag(argv,X),member(E,X),atom_concat('--',_,E)))).
:- current_prolog_flag('argv',WasArgV),
   append(WasArgV,[
   '--',
   '--all', % all default options (in case there are new ones!)
   '--pdt', % Prolog Development for Eclipse
   '--mud', % Load MUD server
   '--world', % Load MUD server World
   '--clif', % Support for CLIF
   '--sumo', % Support for SUMO
   '--tinykb', % Support for LarKC
   '--nlkb', % Load CYC NL 
   '--cyckb', % Load CYC KB 
   '--sigma', % Sigma Inference Engine Server  https://logicmoo.org/logicmoo/
   '--planner', % Load any planners
   '--cliop',  % https://logicmoo.org/cliopatria/
   '--www', % https://logicmoo.org/*
   '--irc', % Launch IRC Eggdrop Client
   '--swish', % https://logicmoo.org/swish/
   '--docs', % https://logicmoo.org/pldoc/
   '--plweb',   % https://logicmoo.org/plweb
   '--no-fork', '--workers=16', '--port=3020', 
   %'--user=www-data',
   % '--nonet' '--noworld',
   % '--lispsock', % '--wamcl', % is already implied by --lispsock
   '--logtalk', % Support Logtalk
   '--elfinder', % Support Filesystem Browser   https://logicmoo.org/ef/
   '--defaults' 
   ], NewArgV),
   set_prolog_flag('argv',NewArgV).
:- endif.


:- current_prolog_flag('argv',Is),
   asserta(lmconf:saved_app_argv(Is)),
   writeq(set_prolog_flag('argv',Is)),!,nl.


% ==============================================
% WWW Support
% ==============================================

% :- cpack_install([prov,amalgame,skos,cpack_repository,media_cache,'EDM','cloud',trill_on_swish,ecdemo,command,rdf_qa,waisda,jquery,accurator,pirates,cluster_search_ui,skos_browser,tag_matcher,statistics,opmv,vumix]).
load_cliop_swish:- 
  set_prolog_flag(cant_qsave_logicmoo,true),
  user:['/opt/logicmoo_workspace/packs_web/swish/remote_swish.pl'],!.


load_plweb :-  
 set_prolog_flag(cant_qsave_logicmoo,true),
 ignore(( \+ exists_source(pack(plweb/pack_info)), attach_packs('/opt/logicmoo_workspace/packs_web'))),
 % :- attach_packs('/opt/logicmoo_workspace/packs_web/plweb/packs').
 @((user:['/opt/logicmoo_workspace/packs_web/plweb/plweb.pl'],
  doc_enable(true),
  call(call,call(plweb:with_mutex(plweb_init, server_init)))),plweb).

swish:is_really_module.

run_lps_corner(File):- is_list(File),!,maplist(run_lps_corner,File).
run_lps_corner(File):-
   absolute_file_name(File,DB),
   DB:use_module(library(lps_corner)), 
   listing(db:actions/1),
   listing(interpreter:actions/1),
   interpreter:check_lps_program_module(DB),
   DB:consult(DB),
   interpreter:must_lps_program_module(DB),
   elsewhere:listing(DB:_),
   DB:golps(X),
   listing(interpreter:lps_program_module/1),
   wdmsg(X).

load_lps_corner:- 
  set_prolog_flag(cant_qsave_logicmoo,true),
  run_lps_corner('/opt/logicmoo_workspace/packs_web/lps_corner/examples/binaryChop2.pl').
     
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

:- goat:['/opt/logicmoo_workspace/packs_web/lps_corner/examples/goat.pl'].

:- interpreter:must_lps_program_module(DB),
   %elsewhere:listing(DB:_),   
   DB:golps(X),
   listing(lps_program_module/1),
   format('~N~p.~n',[X]).

:- break.

blast_op(OP):- forall(current_op(_,XFX,OP),op(0,XFX,OP)).
:- blast_op(false).
:- blast_op(if).
:- blast_op(then).
:- blast_op(else).
*/

% ==============================================
% KB Support
% ==============================================

load_clif:-
 '$set_source_module'(baseKB),
 'module'(baseKB),
 baseKB:use_module(library(logicmoo_clif)),
 baseKB:ensure_loaded(library('logicmoo/common_logic/common_logic_clif.pfc')),
 baseKB:ensure_loaded(library('logicmoo/common_logic/common_logic_sumo.pfc')).

% ==============================================
% ============= MUD SERVER CODE LOADING =============
% ==============================================

load_logicmoo_mud :- baseKB:ensure_loaded(library(logicmoo_mud)), baseKB:start_runtime.

remove_undef_srch:- remove_undef_search.

:- before_boot(remove_undef_srch).

:- during_load(user:use_module(library(eggdrop))).

:- before_boot(egg_go).

% ==============================================
% =========== LOGICMOO COMPILATION =============
% ==============================================
% :- prolog_load_context(directory,D),cd(D).


load_before_compile:- current_prolog_flag(cant_qsave_logicmoo,true),!.
load_before_compile:- 
  autoload_all([verbose(true)]),
  load_clif,
  autoload_all([verbose(true)]),
  load_logicmoo_mud,
  autoload_all([verbose(true)]),
  %load_lps_corner,  
  %autoload_all([verbose(true)]), 
  baseKB:listing(mudAtLoc),
  add_history(load_after_compile),
  add_history(qsave_logicmoo),
  nodebug,
  (current_prolog_flag(gui_tracer,true)->noguitracer;true),
  !.

qsave_logicmoo :- current_prolog_flag(cant_qsave_logicmoo,true),!,dmsg(current_prolog_flag(cant_qsave_logicmoo,true)).
qsave_logicmoo :-
   set_prolog_flag(lisp_repl_goal,true),
   %abolish(html_write:xhtml_ns,4),
   %assert((html_write:xhtml_ns(Id, Value, A, B) :- html_current_option(dialect(xhtml)), C=A, !, D=C, html_post(xmlns, \attribute(xmlns:Id=Value), D, B))),
   %assert(html_write:xhtml_ns(_, _, A, A)),
   qsave_program(logicmoo_server,
   [class(development), verbose(true),goal(prolog)]),
   add_history(load_after_compile),
   !.

load_after_compile:-  
  shell('./PreStartMUD.sh'),
  load_cliop_swish,
  load_lps_corner, 
  % load_plweb,
  load_nomic_mu,
  '$set_source_module'(baseKB),
  'module'(baseKB),
  add_history(try_zebra),
  add_history(load_nomic_mu),
  !.

do_setup_history:-  
 ((
  current_input(S),
   catch(prolog:history(S, load), _, true),
  ignore((prolog_load_context(file,File),forall((source_file(Code,File),strip_module(Code,_,Atom),atom(Atom)),add_history(Code)))),
  logicmoo_startup:((
  add_history(mpred_why(mudIsa(iCoffeeCup7, tSpatialThing))),
  add_history(make:make_no_trace),
  add_history(shell('./PreStartMUD.sh')),
  add_history([pack(logicmoo_base/t/examples/fol/'einstein_simpler_03.pfc')]),
  add_history([pack(logicmoo_base/t/examples/fol/'einstein_simpler_04.pfc')]),
  add_history(make:make_no_trace),
  add_history(load_plweb),
  add_history(load_lps_corner),
  add_history(load_cliop_swish),
  add_history(load_clif),
  add_history(qsave_logicmoo),
  add_history(load_after_compile),
  add_history(load_before_compile),
  add_history((+ 1 = _Y)))))),
  !.

zebra00:- [(pack(logicmoo_base/t/examples/fol/'einstein_simpler_04.pfc'))].
% :- kif_compile.
%:- load_library_system(library(logicmoo_nlu)).
:- set_prolog_flag(ec_loader,false).
%:- abolish(system:trace,0).
%:- asserta(system:trace).
load_lpn :- prolog_load_context(directory,D), cd('/home/prologmud_server/lpn/www'),user:[server],cd(D).
try_zebra:- mpred_trace_all, zebra00, 
 forall(trait(P),listing(P)),
 add_history(clif_show),
 add_history(listing(person)),
 clif_show.

load_nomic_mu:- 
  set_prolog_flag(cant_qsave_logicmoo,true),
  baseKB:ensure_loaded(library(nomic_mu)),
  add_history(srv_mu_main),
  add_history(mu:srv_mu),
  !.

:- before_boot(do_setup_history).

% :- initialization(load_before_compile, now).
% :- initialization(load_before_compile, program).
% :- initialization(load_after_compile, restore_state).

% :- rtrace.

