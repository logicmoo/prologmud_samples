/** <module> 
% This file contains the definitions for the objects in a household
% To create a new world, simply change the tObj definitions as
% described below (or in manual)
%
% *******Object definitions*******
%.
% Use the label_type_props(label,typecode,[property1,property2,etc.]]).
% label is whats used to refer to the tObj in the running world
% typecode is whats used to refer to the tObj for initialization (see world.pl)
*/

:- style_check(-singleton).
:- style_check(-discontiguous).
% :- style_check(-atom).

% ==================================================
% Where Things are Located
% ==================================================

:- file_begin(pfc).

:-decl_mpred_hybrid(localityOfObject(tObj,tSpatialThing)).
% which will imply ... :-decl_mpred_hybrid(localityOfObject(kappa(Self,genls(Self,obj)),kappa(Self2,genls(Self2,tSpatialThing)))).



:- thread_local(infSupertypeName).
% alolwos lexical deduction such as tStandTable is a tTable and a tBedRoom is a tRoom
% :-onSpawn localityOfObject(tStandTable, tBedRoom).

:- op(600,fx,onSpawn).

% onSpawn accepts class in any argument
% though also isntances like 

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


:-onSpawn localityOfObject(tRedApple, tKitchen).
:-onSpawn localityOfObject(tGreenApple, tKitchen).
%:-onSpawn localityOfObject(iFn(tApple,[mudColor(vRed)]), tKitchen).
%:-onSpawn localityOfObject(iFn(tApple,[mudColor(vGreen)]), tKitchen).
:-onSpawn localityOfObject(tDesk, tOfficeRoom).
:-onSpawn localityOfObject(tFlashlight, tDesk).
:-onSpawn localityOfObject(tWashingMachine, tCellar).
:-onSpawn localityOfObject(tNani, tWashingMachine).
:-onSpawn localityOfObject(tBroccoli, tKitchen).
:-onSpawn localityOfObject(tCrackers, tKitchen).
:-onSpawn localityOfObject(tComputer, tDesk).
:-onSpawn localityOfObject(tEnvelope, tDesk).
:-onSpawn localityOfObject(tStamp, tEnvelope).
:-onSpawn localityOfObject(tKey, tEnvelope).
:-onSpawn localityOfObject(tBed, tBedRoom).
:-onSpawn localityOfObject(tStandTable, tBedRoom).
:-onSpawn localityOfObject(tPajamas, tStandTable).
:-onSpawn localityOfObject(tShirt, tClosetRoom).
:-onSpawn localityOfObject(tPillow, tBed).
:-onSpawn localityOfObject(tBlanket, tBed).                                                              
:-onSpawn localityOfObject(tTable, tKitchen).
:-onSpawn localityOfObject(tCoat, tClosetRoom).
:-onSpawn localityOfObject(tPants, tClosetRoom).
:-onSpawn localityOfObject(tLightSwitch, tBedRoom).
:-onSpawn localityOfObject(tBall, tBackYard).
:-onSpawn localityOfObject(tSofa, tLivingRoom).
:-onSpawn localityOfObject(tEasyChair, tLivingRoom).
:-onSpawn localityOfObject(tCoffeeTable, tLivingRoom).
:-onSpawn localityOfObject(tCoffeeCup, tKitchen).
:-onSpawn localityOfObject(tCoffee, tCoffeeCup).
%:-onSpawn localityOfObject(tBook(mudColor(vGreen)), tCoffeeTable).
%:-onSpawn localityOfObject(tBook(mudColor(vPink)), tCoffeeTable).
:-onSpawn localityOfObject(tGreenBook, tCoffeeTable).
:-onSpawn localityOfObject(tPinkBook, tCoffeeTable).
:-onSpawn localityOfObject(tBookcase, tLivingRoom).
:-onSpawn localityOfObject(tDresser, tBedRoom).
:-onSpawn localityOfObject(tTopDrawer, tDresser).
:-onSpawn localityOfObject(tMiddleDrawer, tDresser).
:-onSpawn localityOfObject(tBottomDrawer, tDresser). 
:-onSpawn localityOfObject(tHousePlant, tPlanter).
:-onSpawn localityOfObject(tPlanter, tGueridon). 
:-onSpawn localityOfObject(tGueridon, tLivingRoom).
:-onSpawn localityOfObject(tGardenPlant, tBackYard).
:-onSpawn localityOfObject(tCandle,tKitchen).
:-onSpawn localityOfObject(tBathTub,tBathRoom).
:-onSpawn localityOfObject(tShower,tBathRoom).
:-onSpawn localityOfObject(tToilet,tBathRoom).
:-onSpawn localityOfObject(tTreadmill,tHall).
:-onSpawn localityOfObject(tSink,tBathRoom).
:-onSpawn localityOfObject(tKitchenSink,tKitchenCounter).
:-onSpawn localityOfObject(tFridge,tKitchen).
:-onSpawn localityOfObject(tStove,tKitchen).
:-onSpawn localityOfObject(tKitchenCounter,tKitchen).



% ==================================================
% Classes of things
% ==================================================

genls(tCandle,tPortableDevice).
genls(tFlashlight, tPortableDevice).
genls(tFlashlight, tTurnOnAble).
genls(tDesk, tOfficeRoomFurnature).
genls(tApple, tFood).
genls(tNani, tArt).
genls(tNani, tWashAble).
genls(tClothing, tWashAble).
genls(tClothing, tWearAble).
genls(tNani, tCarryAble).
genls(tBroccoli, tFood).
genls(tFood,tEatAble).
genls(tCrackers, tFood).
genls(tEnvelope, tOfficeItem).
genls(tStamp, tOfficeItem).
genls(tKey, tOfficeItem).
genls(tBall, tCarryAble).




genls(tPajamas, tClothing).
genls(tShirt, tClothing).
genls(tCoat, tClothing).
genls(tPants, tClothing).
genls(tClothing, tFoldAble).
genls(tClothing, tWearAble).

genls(tCoffeeCup, tLiquidContainer).
genls(tCoffeeCup, tDrinkAble).
genls(tCoffeeCup, tCarryAble).
genls(tCoffee, tLiquid).
genls(tBook, tReadAble).

genls(tPillow, tBedding).
genls(tBlanket, tBedding).                                                              
genls(tBedding, tFoldAble).
genls(tFoldAble, tCarryAble).
genls(tPortableDevice,tCarryAble).
genls(tPhysicalDevice,tUseAble).
genls(tWearAble, tCarryAble).
genls(tFood,tCarryAble).
genls(tCarryAble,tObj).
% genls(tPartofObj,isTDisjoint(tCarryAble)).
disjointWith(tPartofObj,tCarryAble).

genls(tLightSwitch, tWallFurnature).
genls(tComputer, tOfficeFurnature).
genls(tPartofFurnature,tPartofObj).

genls(tBed, tBedRoomFurnature).
genls(tStandTable, tBedRoomFurnature).
genls(tDresser, tBedRoomFurnature).

genls(tWashingMachine, tDeviceFurnature).
genls(tTable, tFurnature).
genls(tTable, tHasSurface).
genls(tSofa, tLivingRoomFurnature).
genls(tEasyChair, tLivingRoomFurnature).
genls(tCoffeeTable, tLivingRoomFurnature).
genls(tBookcase, tWallFurnature).
genls(tDrawer, tContainer).
genls(tDrawer, tOpenCloseAble).
genls(tDrawer, tPartofFurnature).
genls(tTopDrawer, tPartofFurnature).
genls(tMiddleDrawer, tPartofFurnature).
genls(tBottomDrawer, tPartofFurnature). 
genls(tHousePlant, tPartofObj).
genls(tPlanter, tContainer). 
genls(tGueridon, tLivingRoomFurnature).
genls(tGardenPlant, tOutdoorFurnature).
genls(tSpatialThing,tLookAble).
genls(tNani,tTeddybear).
genls(tTeddybear,tTreasure).

genls(tBathTub,tBathRoomFurnature).
genls(tShower,tBathRoomFurnature).
genls(tToilet,tBathRoomFurnature).
genls(tSink,tBathRoomFurnature).
genls(tKitchenSink,tKitchenFurnature).
genls(tFridge,tKitchenFurnature).
genls(tStove,tKitchenFurnature).
genls(tKitchenCounter,tKitchenFurnature).


% ==================================================
% typeProps Descriptions
% ==================================================

typeProps(tCandle,[mudColor(vBlue),mudSize(vSmall),mudShape(vTriangular),mudMaterial(vWax),mudTexture(vSticky)]).
typeProps(tRedApple,[mudColor(vRed),mudSize(vSmall),mudShape(vRound),isa(tFruit),mudTexture(vSmooth)]).
typeProps(tGreenApple,[mudColor(isEach(vGreen,vPastel)),mudSize(vSmall),mudShape(vRound),isa(tFruit),mudTexture(vSmooth)]).
typeProps(tTable,[mudColor(isEach(vBlue,vWhite)),mudSize(vLarge),mudShape(vOval),mudMaterial(vWood),mudTexture(isEach(vBumpy,vIrregular)),mudWeight(50)]).
typeProps(tPillow,[mudColor(vWhite),mudSize(vMedium),mudShape(vRectangular),mudMaterial(isEach(vCotton,vFlannel)),mudTexture(isEach(vFluffy,vSoft))]).
typeProps(tBlanket,[mudColor(isEach(vGreen,vDark)),mudSize(isEach(vLarge,vBulky)),mudShape(vRectangular),mudMaterial(vRayon),mudTexture(isEach(vPlush,vSoft))]).                                                              
typeProps(tStandTable,[mudColor(isEach(vBlack,vShiney)),mudSize(vMedium),mudShape(isEach(vCubular,vRectangular)),mudMaterial(vWood),mudTexture(vSmooth),mudWeight(25)]).
typeProps(tPajams,[mudColor(isEach(vBlue,vPastel)),mudSize(isEach(vMedium,vFits)),mudShape(vUnique),mudMaterial(isEach(vCotton,vRayon)),mudTexture(vSoft)]).
typeProps(tShirt,[mudColor(vBlack),mudSize(isEach(vMedium,vFits)),mudShape(isLikeFn(mudShape,tTorso)),mudMaterial(vCotton),mudTexture(isEach(vSoft,vThreadbare))]).
typeProps(tFlashlight,[mudColor(vYellow),mudSize(isEach(vMedium,vSmall)),mudShape(vCylindrical),mudMaterial(vPlastic),mudTexture(vRibbed)]).
typeProps(tKey,[mudColor(vSilver),mudSize(isEach(vSmall,vTiny)),mudShape(vUnique),mudMaterial(vMetal),mudTexture(isEach(vRidged,vBumpy))]).
typeProps(tEnvelope,[mudColor(vWhite),mudSize(vSmall),mudShape(vRectangular),mudMaterial(vPaper),mudTexture(vSmooth)]).
typeProps(tDesk,[mudColor(isEach(vBrown,vShiney)),mudSize(vLarge),mudShape(isEach(vCubular,vRectangular)),mudTexture(isEach(vSmooth,vRidged)),mudWeight(175)]).
typeProps(tWashingMachine,[mudColor(vWhite),mudSize(vLarge),mudShape(isEach(vCubular,vSquare)),mudMaterial(vMetal),mudTexture(vSmooth),mudWeight(125)]).
typeProps(tBroccoli,[mudColor(vGreen),mudSize(vSmall),mudShape(isLikeFn(mudShape,tTree)),isa(tVegetable),mudTexture(isEach(vPorous,vBumpy))]).                                                                    
typeProps(tCrackers,[mudColor(vTan),isa(tBread),mudShape(isEach(vCircular,vFlat)),mudSize(vSmall),mudTexture(isEach(vDry,vCoarse))]).
typeProps(tComputer,[mudColor(vGrey),mudMaterial(vPlastic),mudShape(isEach(vCubular,vRectangular)),mudSize(vMedium),mudTexture(vSmooth)]).
typeProps(tStamp,[mudColor(vPolychromeatic),mudSize(isEach(vTiny,vThin)),mudShape(vSquare),mudMaterial(vPaper),mudTexture(isEach(vSmooth,vSticky))]).
typeProps(tCoat,[mudColor(vBlack),mudSize(isEach(vMedium,vFits)),mudShape(isLikeFn(mudShape,tTorso)),mudMaterial(isEach(vWool,vCotton,vRayon)),mudTexture(vCoarse)]).
typeProps(tPants,[mudColor(vBlack),mudSize(isEach(vMedium,vFits)),mudShape(isLikeFn(mudShape,tAssBodypart)),mudMaterial(vDenim),mudTexture(vCoarse)]).
typeProps(tNani,[mudColor(vBrown),mudColor(vWhite),mudSize(vMedium),mudShape(isLikeFn(mudShape,tTeddybear)),mudMaterial(vPlush),mudTexture(isEach(vFuzzy,vSoft))]).
typeProps(tLightSwitch,[mudColor(vCream),mudSize(vSmall),mudShape(vRectangular),mudMaterial(vPlastic),mudTexture(vSmooth)]).



typeProps(tBall,[mudColor(vRed),mudSize(vMedium),mudShape(vSpherical),mudMaterial(vRubber),mudTexture(vBumpy)]).
typeProps(tCoffee,[mudColor(isEach(vBlack,vBrown)),mudSize(vSmall),mudShape(vFluid),mudMaterial(tLiquid),mudTexture(vWet)]).
typeProps(tCoffeeCup,[mudColor(vBlack),mudColor(vBrown),mudSize(vSmall),mudShape(vCuplike),mudMaterial(vGlass),mudTexture(vSmooth)]).
typeProps(tSofa,[mudColor(isEach(vBlue,vDark)),mudSize(isEach(vLarge,vWide,vLong)),mudShape(vPolyhedral),mudMaterial(isEach(vPoplin,vWood)),mudTexture(vRibbed),mudWeight(125)]).
typeProps(tEasyChair,[mudColor(vBlue),mudSize(isEach(vLarge,vNarrow)),mudShape(vPolyhedral),mudMaterial(isEach(vPoplin,vWood)),mudTexture(vRibbed),mudWeight(75)]).
typeProps(tCoffeeTable,[mudColor(isEach(vBrown,vShiney)),mudSize(vMedium),mudShape(vCircular),mudMaterial(vWood),mudTexture(vSmooth),mudWeight(35)]).
typeProps(tGreenBook,[mudColor(vGreen),mudColor(vWhite),mudColor(vBlack),mudSize(vSmall),mudShape(isEach(vCubular,vRectangular)),mudMaterial(vPaper),mudTexture(vSmooth)]).
typeProps(tPinkBook,[mudColor(vPink),mudColor(vWhite),mudColor(vBlack),mudSize(vSmall),mudShape(isEach(vCubular,vRectangular)),mudMaterial(vPaper),mudTexture(vSmooth)]).
typeProps(tBookcase,[mudColor(isEach(vBrown,vDark,vShiney)),mudSize(vLarge),mudShape(isEach(vSquare,vConcavePolyhedron)),mudMaterial(vWood),mudTexture(vSmooth),mudWeight(60)]).
typeProps(tDresser,[mudColor(isEach(vBrown,vShiney)),mudSize(vLarge),mudShape(isEach(vRectangular,vPolyhedral)),mudMaterial(vWood),mudTexture(vSmooth),mudWeight(45)]).
typeProps(tTopDrawer,[mudColor(isEach(vBrown,vShiney)),mudSize(vMedium),mudShape(isEach(vRectangular,vConcavePolyhedron)),mudMaterial(vWood),mudTexture(vSmooth)]). 
typeProps(tMiddleDrawer,[mudColor(isEach(vBrown,vShiney)),mudSize(vMedium),mudShape(isEach(vRectangular,vConcavePolyhedron)),mudMaterial(vWood),mudTexture(vSmooth)]).
typeProps(tBottomDrawer,[mudColor(isEach(vBrown,vShiney)),mudSize(vMedium),mudShape(isEach(vRectangular,vConcavePolyhedron)),mudMaterial(vWood),mudTexture(vSmooth)]).
typeProps(tPlanter,[mudColor(isEach(vPastel,vBlue)),mudSize(vMedium),mudShape(isEach(vCylindrical,vTrapezohedron)),mudMaterial(vClay),mudTexture(vAbrasive),mudWeight(15)]).
typeProps(tHousePlant,[mudColor(vGreen),mudSize(vMedium),mudShape(vAnthuriumCrystallinum),mudMaterial(vPlantTissue),mudTexture(vSmooth)]).
typeProps(tGueridon,[mudColor(isEach(vBrown,vShiney)),mudSize(vMedium),mudShape(vCircular),mudMaterial(vWood),mudTexture(vSmooth),mudWeight(25)]).		 

typeProps(tTeddybear,[mudColor(vNatural),mudShape(vUnique)]).
typeProps(tTorso,[mudColor(isLikeFn(mudColor,tSkin)),isa(tBodypart),mudShape(vUnique)]).
typeProps(tSkin,[mudColor(vUnique),isa(tBodypart),mudShape(vUnique)]).
