:- module(prologmud_sample,[]).
:- user:ensure_loaded(prologmud_sample_games/init_mud_server).
:- current_prolog_flag(os_argv,[Was]),(app_argv('--noworld')->true;set_prolog_flag(os_argv,[Was,'--world'])).
:- user:ensure_loaded(prologmud_sample_games/run_mud_server).

