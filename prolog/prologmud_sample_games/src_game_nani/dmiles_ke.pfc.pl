/** <module> a_nani_household
% This file contains the definitions for the room in a household
% To create a new world, simply change the room definitions as
% described below (or in manual)
%

use this file with...

:- declare_load_dbase('../games/src_game_nani/a_nani_household.pfc.pl').

*/

:- style_check(-singleton).
:- style_check(-discontiguous).

:- op(600,fx,onSpawn).

:- file_begin(pfc).

tRegion(dmiles_room).
mudAreaConnected(dmiles_room,iHall7).

tSet(tOakDesk).
genls(tOakDesk,tFurniture).


tOakDesk(iOakDesk7).
tOakDesk(iOakDesk8).
localityOfObject(iOakDesk7,dmiles_room).
localityOfObject(iOakDesk8,dmiles_room).


