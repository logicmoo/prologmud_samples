#!/usr/bin/env swipl
/* * module  MUD server startup script in SWI-Prolog

?- 
 ignore(( \+ exists_source(library(prologmud_sample_games/run_mud_server)), 
     attach_packs('/opt/logicmoo_workspace/packs_sys'))),
 consult(library(prologmud_sample_games/run_mud_server)).

%  sudo -u prologmud_server gdb -x gdbinit -return-child-result -ex "set pagination off" -ex run -ex quit --args swipl -l run_mud_server.pl --all --nonet --noworld


W:\opt\logicmoo_workspace\packs_sys\logicmoo_utils\prolog;W:\opt\logicmoo_workspace\packs_sys\logicmoo_base\prolog;W:\opt\logicmoo_workspace\packs_sys\pfc\prolog;W:\opt\logicmoo_workspace\packs_sys\logicmoo_nlu\prolog\logicmoo_nlu;W:\opt\logicmoo_workspace\packs_sys\prologmud\prolog;W:\opt\logicmoo_workspace\packs_sys\logicmoo_nlu\prolog\marty_white;W:\opt\logicmoo_workspace\packs_sys\logicmoo_nlu\ext\chat80;W:\opt\logicmoo_workspace\packs_sys\logicmoo_nlu\ext\ape


*/

load_package_dirs:- 
  findall(PackDir,'$pack':pack(Pack, PackDir),Before),
  ignore(( \+ exists_source(library(logicmoo_common)), attach_packs('/opt/logicmoo_workspace/packs_sys'))),
  ignore(( \+ exists_source(library(sldnfdraw)), attach_packs('/opt/logicmoo_workspace/packs_lib'))),
  ignore(( \+ exists_source(library(rserve_client)), attach_packs('/opt/logicmoo_workspace/packs_web/swish/pack'))),
  ignore(( \+ exists_source(library(lps_corner)), attach_packs('/opt/logicmoo_workspace/packs_web'))),
  % ignore(( \+ exists_source(pack(plweb/pack_info)), attach_packs('/opt/logicmoo_workspace/packs_web'))),
  findall(PackDir,'$pack':pack(Pack, PackDir),After),
  (Before==After -> writeln(load_package_dirs) ; catch(pack_list_installed,_,true)),
  !.

 
:- initialization(load_package_dirs, now).
:- initialization(load_package_dirs, restore_state).

:- multifile(sandbox:safe_primitive/1).
:- dynamic(sandbox:safe_primitive/1).
:- multifile(sandbox:safe_meta_predicate/1).
:- dynamic(sandbox:safe_meta_predicate/1).

:- dynamic(http_unix_daemon:http_daemon/0).

:- use_module(library(logicmoo_common)).
sandbox:safe_primitive(dumpst:dumpST()).
sandbox:safe_meta_predicate(system:notrace/1).

:- if(\+ prolog_load_context(reloading,true)).
:- use_module(library(sandbox)).
:- use_module(library(pengines_sandbox)).
% :- rtrace.
:- dmsg("Ensure run_mud_server").
%:- rtrace(dmsg2("Ensure Run_MUD_SERVER1")).
%:- break.

:- system:use_module(library(console_input)).
:- system:use_module(library(date)).
:- system:use_module(library(make)).
:- system:use_module(library(qsave)).
:- system:use_module(library(prolog_autoload)).
:- system:use_module(library(prolog_pack)).
:- system:use_module(library(lists)).
:- system:use_module(library(backcomp)).
:- system:use_module(library(edit)).
:- system:use_module(library(prolog_trace)).
:- system:use_module(library(threadutil)).
:- system:use_module(library(debug)).
:- system:use_module(library(yall)).
:- system:use_module(library(time)).
:- abolish(system:time/1).
:- system:use_module(library(statistics)).


:- system:use_module(library(apply)).
:- system:use_module(library(assoc)).
:- system:use_module(library(base64)).
:- system:use_module(library(charsio)).
:- system:use_module(library(codesio)).
:- system:use_module(library(crypt)).
:- system:use_module(library(ctypes)).
:- system:use_module(library(debug)).
:- system:use_module(library(dialect)).
:- system:use_module(library(doc_files)).
:- system:use_module(library(doc_http)).
:- system:use_module(library(edinburgh)).
:- system:use_module(library(error)).
:- system:use_module(library(filesex)).
:- system:use_module(library(gensym)).
:- system:use_module(library(git)).
:- system:use_module(library(http/html_head)).
:- system:use_module(library(http/http_dispatch)).
:- system:use_module(library(http/http_path)).
:- system:use_module(library(http/mimetype)).
:- system:use_module(library(lazy_lists)).
:- system:use_module(library(listing)).
:- system:use_module(library(lists)).
:- system:use_module(library(memfile)).
:- system:use_module(library(modules)).
:- system:use_module(library(nb_rbtrees)).
:- system:use_module(library(occurs)).
:- system:use_module(library(operators)).
:- system:use_module(library(option)).
:- system:use_module(library(ordsets)).
:- system:use_module(library(pairs)).
:- system:use_module(library(pldoc)).
:- system:use_module(library(pldoc/doc_html)).
:- system:use_module(library(pldoc/doc_process)).
:- system:use_module(library(pldoc/doc_search)).
:- system:use_module(library(pldoc/doc_util)).
:- system:use_module(library(pldoc/man_index)).
:- system:use_module(library(porter_stem)).
:- system:use_module(library(pprint)).
:- system:use_module(library(predicate_options)).
:- system:use_module(library(process)).
:- system:use_module(library(prolog_clause)).
:- system:use_module(library(prolog_code)).
:- system:use_module(library(prolog_codewalk)).
:- system:use_module(library(prolog_config)).
:- system:use_module(library(prolog_source)).
:- system:use_module(library(prolog_stack)).
:- system:use_module(library(prolog_xref)).
:- system:use_module(library(pure_input)).
:- system:use_module(library(quintus)).
:- system:use_module(library(readutil)).
:- system:use_module(library(sgml)).
:- system:use_module(library(sgml_write)).
:- system:use_module(library(sha)).
:- system:use_module(library(shell)).
:- system:use_module(library(shlib)).
:- system:use_module(library(socket)).
:- system:use_module(library(solution_sequences)).
:- system:use_module(library(sort)).
:- system:use_module(library(ssl)).
:- system:use_module(library(system)).
:- system:use_module(library(thread_pool)).
:- system:use_module(library(uri)).
:- system:use_module(library(url)).
:- system:use_module(library(uuid)).
:- system:use_module(library(varnumbers)).
:- system:use_module(library(when)).
:- system:use_module(library(writef)).
:- system:use_module(library(zlib)).

:- system:use_module(library(jpl)).
%:- use_module(library(wfs)).
:- system:use_module(library(wfs),[call_residual_program/2,call_delays/2,delays_residual_program/2,answer_residual/2]).
:- system:use_module(library(gui_tracer)). % autoloading swi_ide:guitracer/0 from /usr/lib/swipl/xpce/prolog/lib/gui_tracer
:- system:use_module(library(swi_compatibility)). %% autoloading swi_ide:auto_call/1 from /usr/lib/swipl/xpce/prolog/lib/swi_compatibility
:- endif.


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

% :- initialization(shell('./PreStartMUD.sh'),program).

:- current_prolog_flag('argv',Is),writeq(current_prolog_flag('argv',Is)),!,nl.

:- use_module(library(logicmoo_utils)).
:- use_module(library(logicmoo_common)).

check_startup_flags:- 
   current_prolog_flag(argv,WasArgV),
   ignore((  
           \+ ((member(E,WasArgV), 
                atom_concat('--',_,E))),
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
   set_prolog_flag('argv',NewArgV))),
   current_prolog_flag(argv,Is),
   asserta(lmconf:saved_app_argv(Is)),
   writeq(set_prolog_flag('argv',Is)),!,nl.

:- initialization(check_startup_flags, now).
:- initialization(check_startup_flags, restore_state).

mud_baseKB :- '$set_typein_module'(baseKB),'$set_source_module'(baseKB),module(baseKB).

% ==============================================
% WWW Support
% ==============================================

% :- cpack_install([prov,amalgame,skos,cpack_repository,media_cache,'EDM','cloud',trill_on_swish,ecdemo,command,rdf_qa,waisda,jquery,accurator,pirates,cluster_search_ui,skos_browser,tag_matcher,statistics,opmv,vumix]).


load_plweb :-  
 % set_prolog_flag(cant_qsave_logicmoo,true),
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

:- run_lps_corner('/opt/logicmoo_workspace/packs_web/lps_corner/examples/goat.pl').

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
% ============= MUD SERVER CODE LOADING =============
% ==============================================


remove_undef_srch:- remove_undef_search.

:- before_boot(remove_undef_srch).

do_setup_history:-  
 ((
  current_input(S),
   catch(prolog:history(S, load), _, true),
  ignore((prolog_load_context(file,File),forall((source_file(Code,File),strip_module(Code,_,Atom),atom(Atom)),add_history(Code)))),
  logicmoo_startup:((
  add_history(mpred_why(mudIsa(iCoffeeCup7, tSpatialThing))),
  add_history(make:make_no_trace),
  add_history(shell('./PreStartMUD.sh')),
  add_history(run_lps_corner('/opt/logicmoo_workspace/packs_web/lps_corner/examples/goat.pl')),
  add_history([pack(logicmoo_base/t/examples/fol/'einstein_simpler_03.pfc')]),
  add_history([pack(logicmoo_base/t/examples/fol/'einstein_simpler_04.pfc')]),
  add_history(make:make_no_trace),
  add_history(load_plweb),
  add_history(help(match_regex/2)),
  add_history(list_undefined),
  add_history(listing(lmconf:at_restore_goal/2)),
  add_history(statistics),        
  add_history(make),        
  add_history(mmake),
  add_history(login_and_run),        
  add_history(loadSumo),
  add_history(loadTinyKB),
  add_history(threads),
  add_history(run_pending_inits),
  add_history(use_module(library(sexpr_reader))),
  add_history(input_to_forms("( #\\a #\\u0009 . #\\bell )",'$VAR'('O'),'$VAR'('Vs'))),
  add_history(tstl),
  add_history(qconsult_kb7166),
  add_history(load_lps_corner),
  add_history(qsave_logicmoo),
  add_history(start_all),
  add_history(load_before_compile),
  add_history(adventure),
  add_history(start_all),
  add_history(start_mud_telnet),
  add_history(lar),
  add_history(lst),
  add_history((+ 1 = _Y)))))),
  !.

:- before_boot(do_setup_history).

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
  % set_prolog_flag(cant_qsave_logicmoo,true),
  mud_baseKB,
  baseKB:ensure_loaded(library(nomic_mu)),
  add_history(srv_mu_main),
  add_history(mu:srv_mu),
  !.

:- user:use_module(library(eggdrop)).

% ==============================================
% =========== LOGICMOO COMPILATION =============
% ==============================================
% :- prolog_load_context(directory,D),cd(D).
dont_export(_,F,_):- atom_concat('$',_,F),!.
dont_export(M,_,_):- atom_concat('$',_,M),!.
dont_export(_,attr_unify_hook,2).
dont_export(_,attribute_goals,3).
dont_export(_,project_attributes,2).
dont_export(_,attr_portray_hook,2).
dont_export(_,portray,1).
dont_export(_,term_expansion,_).
dont_export(_,rdf_rewrite,_).
dont_export(rdf_rewrite,_,_).
dont_export(utility_translation,_,_).
dont_export(_,goal_expansion,_).
dont_export(_,clause_expansion,_).


expose_all:-
     forall((current_predicate(M:F/A),functor(P,F,A),
       (predicate_property(M:P,imported_from(RM))->true;RM=M),
       \+ dont_export(M,F,A)),
       (catch((RM:export(RM:F/A),system:import(RM:F/A)),E,nop(dmsg(E))))).


load_before_compile:- 
   mud_baseKB,
   user:ensure_loaded('/opt/logicmoo_workspace/packs_web/swish/run_swish_and_clio.pl').

start_network:- 
   egg_go,
   shell('./PreStartMUD.sh'),
   broadcast:broadcast(http(pre_server_start)),
   cp_server:cp_server([]),
   broadcast:broadcast(http(post_server_start)),
   swish:start_swish_stat_collector,!.
   
load_rest:-
      baseKB:use_module(library(logicmoo_clif)),
      baseKB:ensure_loaded(library('logicmoo/common_logic/common_logic_sumo.pfc')),
      add_history(try_zebra),
   baseKB:ensure_loaded(library(logicmoo_mud)),
   baseKB:ensure_loaded(library(logicmoo_nlu)),
   add_history(start_all),
   add_history(qsave_logicmoo),
   nodebug,
  (current_prolog_flag(gui_tracer,true)->noguitracer;true),
   % run_before_qsave,
   do_setup_history,
   finish_processing_world,
  !.




qsave_logicmoo :-
   mud_baseKB,
   %load_before_compile,
   set_prolog_flag(lisp_repl_goal,true),
   current_prolog_flag(stack_limit,Stack_limit),
   qsave_program(logicmoo_server,
   [   class(development), 
       verbose(true),
       stack_limit(Stack_limit),
       toplevel(prolog),
       goal(prolog),
       % undefined(error), 
       op(save),%map('logicmoo_server.map'), % foreign(no_save),
       autoload(true),       
       stand_alone(false)]),
   add_history(start_all),
   !.

import_some:- 
      forall((current_predicate(baseKB:F/A),M=baseKB,functor(P,F,A),
         (predicate_property(M:P,imported_from(RM))->true;RM=M)),
         (RM:export(RM:F/A),rtrace:import(RM:F/A))),   
      forall((current_predicate(M:F/A),M==baseKB,functor(P,F,A),
         (predicate_property(M:P,imported_from(RM))->true;RM=M)),
         (RM:export(RM:F/A),rtrace:import(RM:F/A))), !.

start_rest:- 
   mud_baseKB,
   % rtrace,
   load_nomic_mu,% autoload_all([verbose(true)]), 
   load_lps_corner,% autoload_all([verbose(true)]), 
   import_some,
   expose_all,
   baseKB:start_runtime_mud,
   %run_setup_now,  
   baseKB:start_mud_telnet, 
   % adventure,
   % lar,
   baseKB:listing(mudAtLoc),
   threads,
   !.

:- set_prolog_flag(no_sandbox, true).
:- use_module(library(pfc_lib)).

:- load_before_compile.
:- initialization(start_network,restore).
:- if(\+ compiling).
:- initialization(start_network,now).
:- endif.
%:- load_rest.
:- initialization(start_rest,restore).
:- if(\+ compiling).
%:- initialization(start_rest,now).
:- endif.
% :- initialization(qsave_logicmoo, main).

