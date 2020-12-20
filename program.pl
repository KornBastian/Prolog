% Prädikat pokemon mit 5 Parametern dynamisch machen. Die Wissensbasis von pokemon/5 kann während der Laufzeit verändert werden
:- dynamic(pokemon/5).


/* Fakten */

% typ(name).
% 'name' ist ein typ.
typ(feuer).
typ(pflanze).
typ(wasser).

% vorteilTyp(typ1, typ2, schadensmultiplikator).
% 'typ1' ist im Vorteil gegenüber 'typ2' und fügt 'schadensmultiplikator'-fachen schaden zu.
vorteilTyp(feuer, pflanze, 2).
vorteilTyp(pflanze, wasser, 2).
vorteilTyp(wasser, feuer, 2).

% pokemon(name, typ, level, kraftpunkte, entwicklungsstufe).
% 'name' ist ein Pokemon der Entwicklungsstufe 'entwicklungsstufe' vom Typ 'typ' auf dem Level 'level'.
pokemon(glumanda, feuer, 10, 100, 1).
pokemon(feurigel, feuer, 17, 155, 1).
pokemon(bisasam, pflanze, 6, 142, 1).
pokemon(endivie, pflanze, 5, 140, 1).
pokemon(schiggy, wasser, 20, 170, 1).
pokemon(enton, wasser, 33, 178, 1).

% entwickeltSich(pokemon1, pokemon2, level).
% 'pokemon1' entwickelt sich zu 'pokemon2' auf Level 'level'.
entwickeltSich(glumanda, glutexo, 16).
entwickeltSich(glutexo, glurak, 36).
entwickeltSich(feurigel, igelavar, 14).
entwickeltSich(igelavar, tornupto, 36).
entwickeltSich(bisasam, bisaknosp, 16).
entwickeltSich(bisaknosp, bisaflor, 32).
entwickeltSich(endivie, lorblatt, 16).
entwickeltSich(lorblatt, meganie, 32).
entwickeltSich(schiggy, schillok, 16).
entwickeltSich(schillok, turtok, 36).
entwickeltSich(enton, entoron, 33).

% attacken(pokemon, level, attacke, typ, stärke, genauigkeit, angriffspunkte)
% 'pokemon' beherrscht ab Level 'level' die Attacke 'attacke' vom Typ 'typ' ...
attacke(glumanda, 1, kratzer, normal, 40, 100, 35).
attacke(glumanda, 1, heuler, normal, 0, 100, 40).
attacke(glumanda, 7, glut, feuer, 40, 100, 25).
attacke(glumanda, 13, rauchwolke, normal, 0, 100, 20).
attacke(glumanda, 19, raserei, normal, 20, 100, 20).
attacke(glumanda, 25, grimasse, normal, 0, 90, 10).
attacke(glumanda, 31, flammenwurf, feuer, 95, 100, 15).
attacke(glumanda, 37, schlitzer, normal, 70, 100, 20).
attacke(glumanda, 49, feuerwirbel, feuer, 15, 70, 15). 
attacke(schiggy, 1, tackle, normal, 35, 95, 35).
attacke(schiggy, 4, rutenschlag, normal, 0, 100, 30).
attacke(schiggy, 7, blubber, wasser, 20, 100, 30).
attacke(schiggy, 10, panzerschutz, wasser, 0, 0, 40).
attacke(schiggy, 13, aquaknarre, wasser, 40, 100, 25).
attacke(schiggy, 23, turbodreher, normal, 20, 100, 40).
attacke(schiggy, 28, schutzschild, normal, 0, 0, 10).
attacke(schiggy, 33, regentanz, wasser, 0, 0, 5).
attacke(schiggy, 40, schädelwumme, normal, 100, 100, 15).
attacke(schiggy, 47, hydropumpe, wasser, 120, 80, 5).


/* Regeln */

% Gebe alle Pokemon aus. (Mit Parametern zum filtern)
pokemonListe(Name, Typ, Level, Kraftpunkte, Entwicklungsstufe) :-
	write('Name - Typ - Level - Kraftpunkte - Entwicklungsstufe'), % Ausgabe von Text auf die Konsole.
	nl, % new line / Zeilenumbruch.
	pokemon(Name,Typ,Level, Kraftpunkte, Entwicklungsstufe), % Geforderte Informationen der Parameterliste holen.
	write(Name), write(' - '),
	write(Typ), write(' - '),
	write(Level), write(' - '),
	write(Kraftpunkte), write(' - '),
	write(Entwicklungsstufe),
	nl,
	fail; true. % Wird verwendet, um automatisch durch die Liste zu gehen ohne Manuell ';' einzugeben und am Ende true zu bekommen.

% Gebe alle pokemon aus.
pokemonListe() :-
	write('Name - Typ - Level - Kraftpunkte - Entwicklungsstufe'),
	nl,
	pokemon(Name,Typ,Level, Kraftpunkte, Entwicklungsstufe),
	write(Name), write(' - '),
	write(Typ), write(' - '),
	write(Level), write(' - '),
	write(Kraftpunkte), write(' - '),
	write(Entwicklungsstufe),
	nl,
	fail; true.

% Gebe alle freigeschalteten Angriffe für das Pokemon "PokemonName" aus.
angriffsListe(PokemonName) :-
	pokemon(PokemonName,_,PokemonLevel,_,_), % Hole das Level vom geforderten Pokemon.
	write('Attacke - Typ - Stärke - Genauigkeit - Angriffspunkte'),
	nl,
	attacke(PokemonName, AttackeLevel, Attacke, Typ, Staerke, Genauigkeit, Angriffspunkte), % Hole Informationen über die Attacken vom geforderten Pokemon.
	PokemonLevel >= AttackeLevel, % Prüfe ob das PokemonLevel größer oder gleich das AttackeLevel ist bzw. ob das Pokemon die Attacke bereits freigeschaltet hat.
	write(Attacke), write(' - '),
	write(Typ), write(' - '),
	write(Staerke), write(' - '),
	write(Genauigkeit), write(' - '),
	write(Angriffspunkte),
	nl,
	fail; true.

% "PokemonName" kann sich entwickeln, wenn "EntwicklungLevel" aus entwickeltSich kleiner oder gleich "PokemonLevel" ist.
entwicklungMoeglich(PokemonName) :-
	pokemon(PokemonName, _, PokemonLevel, _, _), % Hole das Level vom geforderten Pokemon.
	entwickeltSich(PokemonName, _, EntwicklungLevel), % Hole das Entwicklungslevel vom geforderten Pokemon.
	EntwicklungLevel =< PokemonLevel. % Wenn das Entwicklungslevel kleiner oder gleich das Pokemonlevel ist, dann true (Pokemon kann sich entwickeln).

% Pokemon entwickeln
entwickeln(PokemonName) :-
	pokemon(PokemonName, Typ, Level, Kraftpunkte, Entwicklungsstufe), % Informationen von Pokemon holen.
	entwicklungMoeglich(PokemonName), % Prüfen ob die Entwicklung möglich ist.
	entwickeltSich(PokemonName, Entwicklung, _), % Information über neue Entwicklungsform holen.
	NeueEntwicklungsstufe is Entwicklungsstufe+1, % Neue Entwicklungsstufe berechnen.
	NeueKraftpunkte is Kraftpunkte * 1.15, % Neue Kraftpunkte berechnen.
	retract(pokemon(PokemonName, Typ, Level, Kraftpunkte, Entwicklungsstufe)), % Pokemon mit alten Werten löschen.
	assertz(pokemon(Entwicklung, Typ, Level, NeueKraftpunkte, NeueEntwicklungsstufe)). % Pokemon mit neuen Werten hinzufügen.
	
% "PokemonName1" ist im Vorteil gegenüber "PokemonName2", wenn "Typ1" im Vorteil gegenüber "Typ2" ist.
vorteilPokemon(PokemonName1, PokemonName2) :-
	pokemon(PokemonName1, Typ1, _, _, _), % Typ von Pokemon1 holen.
	pokemon(PokemonName2, Typ2, _, _, _), % Typ von Pokemon2 holen.
	vorteilTyp(Typ1, Typ2, _). % true, wenn der Typ von Pokemon1 im Vorteil gegenüber den Typ von Pokemon2 ist.

% "PokemonName1" greift "PokemonName2" mit "Attacke" an.
angriff(PokemonName1, PokemonName2, Attacke) :-
	pokemon(PokemonName1, Typ1, Level1, Kraftpunkte1, Entwicklungsstufe1), % Informationen von Pokemon1 holen
	pokemon(PokemonName2, Typ2, Level2, Kraftpunkte2, Entwicklungsstufe2), % Informationen von Pokemon2 holen
	attacke(PokemonName1, AttackeLevel, Attacke, Typ, _, _, Angriffspunkte), % Informationen der Attacke holen
	AttackeLevel =< Level1, % Prüfen ob Pokemon1 die gewünschte Attacke bereits freigeschaltet hat
	(vorteilTyp(Typ,Typ2,Multiplikator);Multiplikator is 1), % Schadensmultiplikator holen. Wenn kein Vorteil, Schadensmultiplikator auf 1 setzen.
	NeueAngriffspunkte is Angriffspunkte*Multiplikator, % Schadensmultiplikator anwenden
	NeueKraftpunkte2 is Kraftpunkte2-NeueAngriffspunkte, % Neue Kraftpunkte von Pokemon2 berechnen
	retract(pokemon(PokemonName2, Typ2, Level2, Kraftpunkte2, Entwicklungsstufe2)), % Pokemon2 aus Datenbasis entfernen
	(
		% Wenn Pokemon2 noch lebt, mit neuen Kraftpunkten neu erstellen.
		(NeueKraftpunkte2 > 0, 
		assertz(pokemon(PokemonName2, Typ2, Level2, NeueKraftpunkte2, Entwicklungsstufe2)));
		
		% Wenn Pokemon2 gestorben ist, Pokemon1 Level und Kraftpunkte erhöhen, Pokemon2 bleibt gelöscht.
		(NeueKraftpunkte2 =< 0,
		NeuesLevel is Level1+1, % Level erhöhen
		NeueKraftpunkte1 is Kraftpunkte1 * 1.05, % Kraftpunkte berechnen
		retract(pokemon(PokemonName1, Typ1, Level1, Kraftpunkte1, Entwicklungsstufe1)), % Pokemon1 mit alten Werten entfernen
		assertz(pokemon(PokemonName1, Typ1, NeuesLevel, NeueKraftpunkte1, Entwicklungsstufe1))) % Pokemon1 mit neuen Werten erstellen.
	).

/* Rekursive Regeln */

% "Pokemon1" ist in der selben Evolutionsreihe mit Pokemon2, wenn sich Pokemon1 direkt zu Pokemon2 entwickeln kann, oder sich Pokemon1 indirekt über mehrere Entwicklungen zu Pokemon2 entwickeln kann.
evolutionsreihe(PokemonName1, PokemonName2) :-
	entwickeltSich(PokemonName1, PokemonName2, Level); % Prüfen, ob sich Pokemon1 direkt zu Pokemon2 entwickeln kann.
	(entwickeltSich(PokemonName1, PokemonName3, Level), % Information über das Pokemon (Pokemon3) holen zu dem sich Pokemon1 entwickeln kann.
	evolutionsreihe(PokemonName3, PokemonName2)), % Regel evolutionsreihe neu aufrufen mit Pokemon3 statt Pokemon1.
	fail; true.

/*Diese Implementierung von evolutionsreihe ist semantisch identisch mit der Definition oben
evolutionsreihe(Pokemon1, Pokemon2) :-
	entwickeltSich(Pokemon1, Pokemon2,_).

revolutionsreihe(Pokemon1, Pokemon2) :-
	entwickeltSich(Pokemon1, Pokemon3, _),
	evolutionsreihe(Pokemon3, Pokemon2).
*/

durchsucheListe(Element,Liste) :-
	Liste = [Head | Tail], % Teile die Liste in Head und Tail auf.
	(Element = Head; % Prüfen, ob das gesuchte Element der Head ist.
	durchsucheListe(Element,Tail)). % Wenn nicht, durchsucheListe mit dem Rest der Liste (Tail) aufrufen.
