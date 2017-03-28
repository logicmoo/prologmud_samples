#!/usr/bin/env swipl
/* * module  MUD server startup script in SWI-Prolog

?- 
 consult(library(prologmud_sample_games/run_mud_server)).


*/

:- prolog_load_context(directory,D),cd(D).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INIT MUD SERVER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- user:ensure_loaded(init_mud_server).


:- '$set_source_module'(baseKB).
:- '$set_typein_module'(baseKB).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Optionaly] Start the telent server % iCommanderdata66
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start_telnet:- on_x_log_cont(start_mud_telnet_4000).
:- after_boot(start_telnet).


% :- assert_setting01(lmconf:eachFact_Preconditional(isRuntime)).

% isa(starTrek,mtCycL).
lst :- app_argv('--noworld'),!.
lst :- baseKB:ensure_loaded(sample_games('src_game_startrek/?*.pfc.pl')).
% [Manditory] This loads the game and initializes so test can be ran
:- declare_load_dbase(sample_games('src_game_nani/a_nani_household.pfc.pl')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Optional] the following game files though can be loaded separate instead
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- declare_load_dbase(sample_games('src_game_nani/objs_misc_household.pfc.pl')).
:- declare_load_dbase(sample_games('src_game_nani/?*.pfc.pl')).

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
sanity_test_ifood_rez:- ignore((
     % mpred_notrace_exec,
     % flag_call(runtime_debug>true),
     ain(isa(iFoodRez2,tFood)),must(isa(iFoodRez2,tEatAble)))),
    must((parseIsa_Call(tEatAble,O,["food"],Rest),O=iFoodRez2,Rest=[])).

:- after_boot_sanity_test((dmsg(sanity_test_ifood_rez))).


:- after_boot_sanity_test((gripe_time(1.0,must(coerce("s",vtDirection,_))))).
:- after_boot_sanity_test((gripe_time(2.0,must( \+ coerce(l,vtDirection,_))))).
:- after_boot_sanity_test((statistics)).
:- after_boot_sanity_test(check_clause_counts).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Required/Optional]  Ensures...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% :- after_boot(set_prolog_flag(runtime_debug,0)).
:- during_boot(set_prolog_flag(unsafe_speedups,false)).

:- lst.
:- statistics.
:- ain(tSourceData(iWorldData8)).
:- ain(isLoaded(iWorldData8)).
:- after_boot(ain(isRuntime)).

lar0 :- dmsg("Ctrl-D to start MUD"),prolog,lar.
lar :- set_prolog_flag(dmsg_level,never),login_and_run.

:- add_history(profile(ain(tAgent(foofy)))).

% :- after_boot(lar0).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Required/Optional]  Ensures...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
initialization_after_boot:- listing(lmconf:after_boot_goal/1),dmsg(after_boot_call),after_boot_call,lar0.
:- initialization(initialization_after_boot,after_load).
:- initialization(initialization_after_boot,restore).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Required/Optional]  Ensures...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- statistics.
:- after_boot(qsave_lm(lm_init_mud)).


