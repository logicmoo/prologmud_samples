#!/usr/bin/env swipl
/*  MUD server startup script in SWI-Prolog

*/

:- prolog_load_context(directory,D),cd(D).

:- use_module(library(prolog_pack)).
:- if( \+ prolog_pack:current_pack(prologmud_samples)).
:- multifile(user:file_search_path/2).
:-   dynamic(user:file_search_path/2).
:- prolog_load_context(directory,Dir),
   absolute_file_name('../../../',Y,[relative_to(Dir),file_type(directory)]),
   (( \+ user:file_search_path(pack,Y)) ->asserta(user:file_search_path(pack,Y));true).
:- initialization(attach_packs,now).
:- endif.
:- pack_list_installed.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SETUP KB EXTENSIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- '$set_typein_module'(baseKB).
:- '$set_source_module'(baseKB).

:- use_module(library(plunit)).
:- kb_global(plunit:loading_unit/4).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Required] Load the Logicmoo User System
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- user:load_library_system(library(logicmoo_lib)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ============= MUD SERVER CODE LOADING =============
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- if(\+ exists_source(prologmud(mud_loader))).
:- must((absolute_file_name(pack('prologmud/prolog/prologmud'),Dir),asserta(user:file_search_path(prologmud,Dir)))).
:- sanity(exists_source(prologmud(mud_loader))).
:- endif.

:- if( \+ app_argv('--noworld')).
:- baseKB:ensure_loaded(prologmud(mud_loader)).
:- endif.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ============= MUD SERVER CODE LOADED =============
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- with_mpred_trace_exec(ain(isLoaded(iSourceCode7))).

:- flag_call(runtime_debug=true).

:- if((gethostname(ubuntu),fail)). % INFO this fail is so we can start faster
:- show_entry(gripe_time(40, doall(baseKB:regression_test))).
:- endif.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Optional] Creates or suppliments a world
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- if( \+ user:file_search_path(sample_games,_Dir)).
:- must((absolute_file_name(pack('prologmud_samples/prolog/prologmud_sample_games'),Dir),asserta(user:file_search_path(sample_games,Dir)))).
:- sanity(user:file_search_path(sample_games,_Dir)).
:- endif.

:- dynamic(lmconf:eachRule_Preconditional/1).
:- dynamic(lmconf:eachFact_Preconditional/1).
:- assert_setting01(lmconf:eachRule_Preconditional(true)).
:- assert_setting01(lmconf:eachFact_Preconditional(true)).

:- if(functorDeclares(mobExplorer)).

:- sanity(functorDeclares(tSourceData)).
:- sanity(functorDeclares(mobExplorer)).


==>((tCol(tLivingRoom),
 tSet(tRegion),
 tSet(tLivingRoom),

 tSet(mobExplorer),
 genls(tLivingRoom,tRegion),
 genls(tOfficeRoom,tRegion),


genlsFwd(tLivingRoom,tRegion),
genlsFwd(tOfficeRoom,tRegion),

% create some seats
mobExplorer(iExplorer1),
mobExplorer(iExplorer2),
mobExplorer(iExplorer3),
mobExplorer(iExplorer4),
mobExplorer(iExplorer5),
mobExplorer(iExplorer6),

(tHumanBody(skRelationAllExistsFn)==>{trace_or_throw(tHumanBody(skRelationAllExistsFn))}),

genls(mobExplorer,tHominid))).

:- endif.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Required] isRuntime Hook
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
(((localityOfObject(P,_),isRuntime)==>{if_defined(put_in_world(P))})).
:- user:use_module(library('file_scope')).
:- set_prolog_flag_until_eof(do_renames,term_expansion).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Optional] Creates or suppliments a world
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- if( \+ app_argv('--noworld')).
:- if( \+ tRegion(_)).

==> prologHybrid(mudAreaConnected(tRegion,tRegion),rtSymmetricBinaryPredicate).
==> rtArgsVerbatum(mudAreaConnected).

==>((
tRegion(iLivingRoom7),
tRegion(iOfficeRoom7),

mobExplorer(iExplorer7),
wearsClothing(iExplorer7,'iBoots773'),
wearsClothing(iExplorer7,'iCommBadge774'),
wearsClothing(iExplorer7,'iGoldUniform775'),
mudStowing(iExplorer7,'iPhaser776'))).

:- kb_shared(baseKB:tCol/1).
:- kb_shared(baseKB:ttCoercable/1).
% :- add_import_module(mpred_type_isa,baseKB,end).
onSpawn(localityOfObject(iExplorer7,tLivingRoom)).

==>((
pddlSomethingIsa('iBoots773',['tBoots','ProtectiveAttire','PortableObject','tWearAble']),
pddlSomethingIsa('iCommBadge774',['tCommBadge','ProtectiveAttire','PortableObject','tNecklace']),
pddlSomethingIsa('iGoldUniform775',['tGoldUniform','ProtectiveAttire','PortableObject','tWearAble']),
pddlSomethingIsa('iPhaser776',['tPhaser','Handgun',tWeapon,'LightingDevice','PortableObject','Device-SingleUser','tWearAble']),

mobMonster(iCommanderdata66),
mobExplorer(iCommanderdata66),
mudDescription(iCommanderdata66,txtFormatFn("Very scary looking monster named ~w",[iCommanderdata66])),
tAgent(iCommanderdata66),
tHominid(iCommanderdata66),
wearsClothing(iCommanderdata66,'iBoots673'),
wearsClothing(iCommanderdata66,'iCommBadge674'),
wearsClothing(iCommanderdata66,'iGoldUniform675'),
mudStowing(iCommanderdata66,'iPhaser676'),

pddlSomethingIsa('iBoots673',['tBoots','ProtectiveAttire','PortableObject','tWearAble']),
pddlSomethingIsa('iCommBadge674',['tCommBadge','ProtectiveAttire','PortableObject','tNecklace']),
pddlSomethingIsa('iGoldUniform675',['tGoldUniform','ProtectiveAttire','PortableObject','tWearAble']),
pddlSomethingIsa('iPhaser676',['tPhaser','Handgun',tWeapon,'LightingDevice','PortableObject','Device-SingleUser','tWearAble']))).


onSpawn(localityOfObject(iCommanderdata66,tOfficeRoom)).
onSpawn(mudAreaConnected(tLivingRoom,tOfficeRoom)).
:- endif.
:- endif.

