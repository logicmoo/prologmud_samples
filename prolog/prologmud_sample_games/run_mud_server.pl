#!/usr/bin/env swipl
/* * module  MUD server startup script in SWI-Prolog

?- 
 consult(library(prologmud_sample_games/run_mud_server)).


*/

:- prolog_load_context(directory,D),cd(D).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INIT MUD SERVER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- '$set_source_module'(baseKB).
:- '$set_typein_module'(baseKB).

:- set_prolog_stack(global, limit(32*10**9)).
:- set_prolog_stack(local, limit(32*10**9)).
:- set_prolog_stack(trail, limit(32*10**9)).

:- user:ensure_loaded(init_mud_server).

:- if( \+ is_startup_file(_) ).
:- initialization_after_boot(run_mud_server).
:- endif.


:- set_prolog_flag(access_level,system).
:- debug.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Optionaly] Start the telent server % iCommanderdata66
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- if( \+ app_argv('--noworld')).
start_telnet:- 
   user:ensure_loaded(init_mud_server),
  on_x_log_cont((call(call,start_mud_telnet_4000))).
:- after_boot(start_telnet).

% :- assert_setting01(lmconf:eachFact_Preconditional(isRuntime)).

% [Manditory] This loads the game and initializes so test can be ran
:- baseKB:ensure_loaded(sample_games('src_game_nani/objs_misc_household.pfc')).
:- baseKB:ensure_loaded(sample_games('src_game_nani/a_nani_household.pfc')).
:- endif.

% isa(starTrek,mtCycL).
lst :- baseKB:ensure_loaded(sample_games('src_game_startrek/?*.pfc*')).
lstr :- forall(registered_mpred_file(F),baseKB:ensure_loaded(F)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Optional] the following game files though can be loaded separate instead
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- declare_load_dbase(sample_games('src_game_nani/?*.pfc*')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Optional] the following worlds are in version control in examples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% :- add_game_dir(sample_games('src_game_wumpus'),prolog_repl).
% :- add_game_dir(sample_games('src_game_sims'),prolog_repl).
% :- add_game_dir(sample_games('src_game_nani'),prolog_repl).
% :- add_game_dir(sample_games('src_game_startrek'),prolog_repl).

%:- check_clause_counts.

:- sanity(argIsa(genlPreds,2,_)).

:- after_boot_sanity_test(argIsa(genlPreds,2,_)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sanity tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- if( \+ app_argv('--noworld')).
sanity_test_ifood_rez:- ignore((
     user:ensure_loaded(init_mud_server),
     % mpred_notrace_exec,
     % flag_call(runtime_debug>true),
     ain(isa(iFoodRez2,tFood)),must(isa(iFoodRez2,tEatAble)))),
    must((call(call,parseIsa_Call(tEatAble,O,["food"],Rest)),O=iFoodRez2,Rest=[])).

:- after_boot_sanity_test((dmsg(sanity_test_ifood_rez))).


:- after_boot_sanity_test((gripe_time(1.0,must(coerce("s",vtDirection,_))))).
:- after_boot_sanity_test((gripe_time(2.0,must( \+ coerce(l,vtDirection,_))))).
:- endif.
:- after_boot_sanity_test((statistics)).
:- after_boot_sanity_test(check_clause_counts).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Required/Optional]  Ensures...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% :- after_boot(set_prolog_flag(runtime_debug,0)).
:- during_boot(set_prolog_flag(unsafe_speedups,false)).

:- if( \+ app_argv('--noworld')).
:- if(app_argv('--world')).
:- lst.
:- endif.
:- lstr.
:- endif.

:- during_boot(ain(tSourceData(iWorldData8))).
:- ain(isLoaded(iWorldData8)).
:- after_boot(with_mpred_trace_exec(ain(isRuntime))).

lar0 :- app_argv('--repl'),!,dmsg("Ctrl-D to start MUD"),prolog,lar.
lar0 :- lar.
       
lar :- % set_prolog_flag(dmsg_level,never),
       if_defined(login_and_run,wdmsg("MUD code not loaded")).

:- add_history(profile(ain(tAgent(foofy)))).
%:- after_boot(qsave_lm(lm_init_mud)).
:- after_boot(lar0).

:- statistics.

:- if(gethostname(gitlab)).                                            

:- set_prolog_flag(runtime_debug,3).
:- set_prolog_flag(runtime_safety,3).
:- set_prolog_flag(runtime_speed,0).

:- else.

:- set_prolog_flag(runtime_debug,1).
:- set_prolog_flag(runtime_safety,1).
:- set_prolog_flag(runtime_speed,1).

:- endif.


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

:- break.


