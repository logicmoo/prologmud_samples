#!/usr/bin/env swipl
/* * module * Debug the MUD Game

*/

% ==============================
% Setup Runtime paths
% ==============================

:- user:ensure_loaded(setup_paths).


% ==============================
% Load logicmoo REPL Base
% (and Default Daemons/inference engine)
% ==============================

:- user:ensure_loaded(logicmoo_repl).

% ==============================
% Now start the profiler
% ==============================

%%% ON :- initialization( profiler(_,walltime) ).
%%% ON :- initialization(use_module(library(swi/pce_profile))).

% [Required] Load the Logicmoo Library Utils
% :- qcompile_libraries.

% ==============================
% Debug the game
% ==============================

:- user:ensure_loaded(run_mud_game).

