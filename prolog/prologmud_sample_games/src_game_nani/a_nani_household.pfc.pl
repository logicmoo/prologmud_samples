/** <module> a_nani_household
% This file contains the definitions for the room in a household
% To create a new world, simply change the room definitions as
% described below (or in manual)
%

use this file with...

:- ensure_loaded('a_nani_household.pfc').

*/

:- style_check(-singleton).
:- style_check(-discontiguous).
% :- style_check(-atom).

:- op(600,fx,onSpawn).

:- file_begin(pfc).

% ==================================================
% Rooms
% ==================================================

/* technically the following are not needed due the mudAreaConnected/2s below */
:-onSpawn tRegion(tKitchen).
:-onSpawn tRegion(tHall).
:-onSpawn tRegion(tCellar).
:-onSpawn tRegion(tOfficeRoom).
:-onSpawn tRegion(tLivingRoom).
:-onSpawn tRegion(tDiningRoom).
:-onSpawn tRegion(tBedRoom).
:-onSpawn tRegion(tBathRoom).
:-onSpawn tRegion(tClosetRoom).
:-onSpawn tRegion(tBackYard).


% ==================================================
% Doors
% ==================================================
 
prologHybrid(mudAreaConnected(tRegion,tRegion),rtSymmetricBinaryPredicate).

:-onSpawn mudAreaConnected(tLivingRoom,tOfficeRoom).
:-onSpawn mudAreaConnected(tHall,tDiningRoom).
:-onSpawn mudAreaConnected(tHall,tBedRoom).
:-onSpawn mudAreaConnected(tHall,tLivingRoom).
:-onSpawn mudAreaConnected(tHall,tBathRoom).
:-onSpawn mudAreaConnected(tKitchen, tCellar).
:-onSpawn mudAreaConnected(tDiningRoom, tKitchen).
:-onSpawn mudAreaConnected(tBedRoom, tClosetRoom).
:-onSpawn mudAreaConnected(tKitchen, tBackYard).
:-onSpawn mudAreaConnected(iArea1008, tBackYard).
