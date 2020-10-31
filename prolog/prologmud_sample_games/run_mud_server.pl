#!/usr/bin/env swipl
/* * module  MUD server startup script in SWI-Prolog

?- 
 ignore(( \+ exists_source(library(prologmud_sample_games/run_mud_server)), 
     attach_packs('/opt/logicmoo_workspace/packs_sys'))),
 consult(library(prologmud_sample_games/run_mud_server)).

%  sudo -u prologmud_server gdb -x gdbinit -return-child-result -ex "set pagination off" -ex run -ex quit --args swipl -l run_mud_server.pl --all --nonet --noworld


C:\Users\logicmoo>rem C:\Windows\System32\runas.exe /savecred /user:remote-user 
 "\"C:\Program Files\swipl\bin\swipl.exe\" -f \"C:\Users\remote-user\AppData\Local\swi-prolog\pack\prologmud_samples\prolog\prologmud_sample_games\run_mud_server.pl\""


?- cd(library(prologmud_sample_games)).
?- [run_mud_server].


W:\opt\logicmoo_workspace\packs_sys\logicmoo_utils\prolog;W:\opt\logicmoo_workspace\packs_sys\logicmoo_base\prolog;W:\opt\logicmoo_workspace\packs_sys\pfc\prolog;W:\opt\logicmoo_workspace\packs_sys\logicmoo_nlu\prolog\logicmoo_nlu;W:\opt\logicmoo_workspace\packs_sys\prologmud\prolog;W:\opt\logicmoo_workspace\packs_sys\logicmoo_nlu\prolog\marty_white;W:\opt\logicmoo_workspace\packs_sys\logicmoo_nlu\ext\chat80;W:\opt\logicmoo_workspace\packs_sys\logicmoo_nlu\ext\ape


*/
:- getenv('DISPLAY',_)->true;setenv('DISPLAY', '10.0.0.122:0.0').
%:- (notrace(gtrace),nodebug).
:- set_prolog_flag(verbose_load,true).
:- set_prolog_flag(pfc_version,2.0).
:- set_prolog_flag(dmsg_level,always).

attach_packs_relative(Rel):-
   once(((
    (working_directory(Dir,Dir);prolog_load_context(directory,Dir)),
    (absolute_file_name(Rel,PackDir,[relative_to(Dir),file_type(directory),file_errors(fail)]);
      absolute_file_name(Rel,PackDir,[file_type(directory),file_errors(fail)])),
    writeln(attach_packs(PackDir)),attach_packs(PackDir)));writeln(failed(attach_packs_relative_web(Rel)))).

load_package_dirs:- 
  findall(PackDir,'$pack':pack(Pack, PackDir),Before),  
  ignore(( \+ exists_source(library(logicmoo_common)), attach_packs_relative('../../..'))),
  findall(PackDir,'$pack':pack(Pack, PackDir),After),
  (Before==After -> writeln(load_package_dirs(After)) ; true),
  ignore(catch(make_directory('/tmp/tempDir/pack'),_,true)),
  (user:file_search_path(pack,'/tmp/tempDir/pack') -> true ; asserta(user:file_search_path(pack,'/tmp/tempDir/pack'))),
  attach_packs('/tmp/tempDir/pack'),
  pack_install(logicmoo_utils,[upgrade(true),interactive(false)]),
  pack_list_installed,
  !.
 
:- initialization(load_package_dirs, now).
:- initialization(load_package_dirs, restore_state).


%:- dmsg("Ensure run_mud_server").
%:- rtrace(dmsg2("Ensure Run_MUD_SERVER1")).
%:- break.


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

:- use_module(library(logicmoo_common)).

check_startup_flags:- 
   current_prolog_flag(argv,WasArgV),
   ignore((  
           \+ ((member(E,WasArgV), 
                atom_concat('--',_,E))),
   append(WasArgV,[
   '--',   

   '--mud', % Load MUD server
   '--world', % Load MUD server World
   %'--nonet' '--noworld',

   '--clif', % Support for CLIF
   '--sumo', % Support for SUMO
   '--nlkb', % Load CYC NL 
   '--cyckb', % Load CYC KB 
   '--tinykb', % Support for LarKC

   '--www', % https://logicmoo.org/*
   '--no-fork', '--workers=16', '--port=3020',
   %'--user=www-data',
   '--sigma', % Sigma Inference Engine Server  https://logicmoo.org/logicmoo/
   '--cliop',  % https://logicmoo.org/cliopatria/
   '--irc', % Launch IRC Eggdrop Client
   '--swish', % https://logicmoo.org/swish/
   '--docs', % https://logicmoo.org/pldoc/
   '--plweb',   % https://logicmoo.org/plweb/
   
   % '--lispsock', % '--wamcl', % is already implied by --lispsock

   '--logtalk', % Support Logtalk
   '--elfinder', % Support Filesystem Browser   https://logicmoo.org/ef/
   '--nopdt', % Prolog Development for Eclipse
   '--planner', % Load any planners

   '--all', % all default options (in case there are new ones!)
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
 %ignore(( \+ exists_source(pack(plweb/pack_info)), attach_packs('/opt/logicmoo_workspace/packs_web'))),
 % :- attach_packs('/opt/logicmoo_workspace/packs_web/plweb/packs').
 @((user:['/opt/logicmoo_workspace/packs_web/plweb/plweb.pl'],
  doc_enable(true),
  call(call,call(plweb:with_mutex(plweb_init, server_init)))),plweb).


% ==============================================
% ============= MUD SERVER CODE LOADING =============
% ==============================================


remove_undef_srch:- remove_undef_search.

:- before_boot(remove_undef_srch).

do_setup_history:-!.
do_setup_history:-  
 ((
  current_input(S),
  ignore(catch(prolog:history(S, load), _, true)),  
  logicmoo_startup:((
  add_history([
  (mpred_why(mudIsa(iCoffeeCup7, tSpatialThing))),
  (make:make_no_trace),
  (update_changed_files),
  (shell('./PreStartMUD.sh')),
  ([pack(logicmoo_base/t/examples/fol/'einstein_simpler_03.pfc')]),
  ([pack(logicmoo_base/t/examples/fol/'einstein_simpler_04.pfc')]),
  (make:make_no_trace),
  (load_plweb),
  (help(match_regex/2)),
  (list_undefined),
  (listing(lmconf:at_restore_goal/2)),
  (statistics),        
  (make),        
  (mmake),
  (login_and_run),
  ignore((prolog_load_context(file,File),forall((source_file(Code,File),strip_module(Code,_,Atom),atom(Atom)),(Code)))),
  (loadSumo),
  (loadTinyKB),
  (threads),
  (run_pending_inits),
  % (use_module(library(sexpr_reader))),
  (input_to_forms("( #\\a #\\u0009 . #\\bell )",'$VAR'('O'),'$VAR'('Vs'))),
  (tstl),
  (qconsult_kb7166),
  (qsave_logicmoo),
  (start_all),
  (load_before_compile),
  (adventure),
  (start_all),
  (start_mud_telnet),
  (lar),
  (lst)]),
  
  maplist(add_history, [ 
   mud_baseKB,
   % rtrace,
   load_nomic_mu,% autoload_all([verbose(true)]), 
   import_some,
   expose_all,
   %baseKB:start_runtime_mud,
   %run_setup_now,  
   %baseKB:start_mud_telnet, 
   % adventure,
   % lar,
   baseKB:listing(mudAtLoc)]),
  add_history((+ 1 = _Y)))))),
  !.

:- before_boot(do_setup_history).

zebra00:- [(pack(logicmoo_base/t/examples/fol/'einstein_simpler_04.pfc'))].
% :- kif_compile.
%:- load_library_system(library(logicmoo_nlu)).
:- set_prolog_flag(ec_loader,false).
%:- abolish(system:trace,0).
%:- asserta(system:trace).
%load_lpn :- prolog_load_context(directory,D), cd('/home/prologmud_server/lpn/www'),user:[server],cd(D).
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


:- multifile(rdf_rewrite:arity/2).
:- dynamic(rdf_rewrite:arity/2).                         
/*
 (1) * /usr/local/share/swi-prolog/pack
   (2)   /usr/share/swi-prolog/pack
   (3)   /var/lib/snapd/desktop/swi-prolog/pack
   (4)   /etc/xdg/swi-prolog/pack

*/
load_before_compile:- 
   use_module(library(logicmoo_webui)),
   
   %:- use_module(library(logicmoo_nlu)).

   mud_baseKB,
   /*
   ignore(catch(pack_install(rocksdb),_,true)),
   ignore(catch(pack_install(sldnfdraw),_,true)),
   ignore(catch(pack_install(aleph),_,true)),
   ignore(catch(pack_install(phil),_,true)),
   ignore(catch(pack_install(cplint_r),_,true)),
   */
   ignore((
    \+ exists_directory('/tmp/tempDir/') -> catch(shell('./PreStartMUD.sh'),_,true))),
   %ignore(( exists_directory('/tmp/tempDir') -> cd('/tmp/tempDir'))),
   webui_load_swish_and_clio,   
   add_history(start_network).

%start_network:- 
%   load_before_compile,!.

start_network:-       
   load_before_compile,
   egg_go,   
   webui_start_swish_and_clio,
   threads,statistics,
   !.
   
load_rest:-
   nodebug,
   load_nomic_mu,
   load_before_compile,
   baseKB:ensure_loaded(library(logicmoo_nlu)),
   baseKB:ensure_loaded(library(narsese)),
   baseKB:ensure_loaded(library(logicmoo_clif)),
   baseKB:ensure_loaded(library('logicmoo/common_logic/common_logic_sumo.pfc')),   
   add_history(try_zebra),
   add_history(start_all),
   add_history(qsave_logicmoo),
   system:reexport(pldata(kb_0988)),
   (current_prolog_flag(gui_tracer,true)->noguitracer;true),
   % run_before_qsave,
   do_setup_history,
   nodebug,
   baseKB:ensure_loaded(library(logicmoo_mud)),
   baseKB:ensure_loaded(library(logicmoo_cg)),
   baseKB:ensure_loaded(library(logicmoo_ec)),
   finish_processing_world,
  !.

:- add_history(load_before_compile).

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

import_some:- !.
import_some:- 
      forall((current_predicate(baseKB:F/A),M=baseKB,functor(P,F,A),
         (predicate_property(M:P,imported_from(RM))->true;RM=M)),
         (RM:export(RM:F/A),rtrace:import(RM:F/A))),   
      forall((current_predicate(M:F/A),M==baseKB,functor(P,F,A),
         (predicate_property(M:P,imported_from(RM))->true;RM=M)),
         (RM:export(RM:F/A),rtrace:import(RM:F/A))), !.

start_rest:- 
   load_rest,
   mud_baseKB,
   % rtrace,
   %load_nomic_mu,% autoload_all([verbose(true)]), 
   import_some,
   expose_all,
   baseKB:start_runtime_mud,
   run_setup_now,  
   baseKB:start_mud_telnet, 
   % adventure,
   % lar,
   baseKB:listing(mudAtLoc),
   threads,
   !.

skip_sandboxing(F):- functor(P,F,1), 
  (SF1 = (sandbox:F/1)),
  sandbox:redefine_system_predicate(SF1),
  sandbox:multifile(SF1),
  sandbox:dynamic(SF1),
  sandbox:asserta((P:-!)).

skip_sandboxing:-
 maplist(skip_sandboxing,
  [safe_goal,
   safe_call,
   safe_directive,
   safe_meta_predicate,
   safe_source_directive,
   safe_load_file_option,
   safe_source_directive]).

:- skip_sandboxing.

baseKB:start_rest:- start_rest.

start_all :- start_network, start_rest.

:- set_prolog_flag(no_sandbox, true).
% :- use_module(library(pfc_lib)).

:- load_before_compile.

:- initialization(start_network,restore).
:- if( \+ compiling).
:- initialization(start_network,now).
:- endif.


:- set_prolog_flag(debug,true).
:- set_prolog_flag(access_level,system).


:- abolish(user:prolog_load_file/2).
:- dynamic(user:prolog_load_file/2).

:- load_rest.
:- initialization(start_rest,restore).
:- if( \+ compiling).
:- initialization(start_rest,now).
:- endif.
% :- initialization(qsave_logicmoo, main).
:- initialization(initialize,restore).
:- if( \+ compiling).
:- initialization(initialize,now).
:- endif.

%:- setenv('DISPLAY', '192.168.88.1:0.0').
%:- (notrace(gtrace),nodebug).
%:- guitracer.


:- prolog. 
