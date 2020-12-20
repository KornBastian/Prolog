:- dynamic pokemon/5.

% pokemon(Name, Typ, Level, Kraftpunkte, Entwicklungsstufe).
pokemon(glumanda, feuer, 10, 100, 1).
pokemon(feurigel, feuer, 17, 155, 1).
pokemon(bisasam, pflanze, 6, 142, 1).
pokemon(endivie, pflanze, 5, 140, 1).
pokemon(schiggy, wasser, 20, 170, 1).
pokemon(enton, wasser, 33, 178, 1).

% vorteilTyp(Typ1, Typ2, Schadensmultiplikator).
vorteilTyp(feuer, pflanze, 2).
vorteilTyp(pflanze, wasser, 2).
vorteilTyp(wasser, feuer, 2).


% PROJEKTION
/* SQL
	SELECT Name, Typ
	FROM Pokemon;
*/
/* Prolog
	pokemon(Name, Typ, _, _, _).
*/

% SELEKTION
/* SQL
	SELECT *
	FROM Pokemon
	WHERE Typ = 'pflanze';
*/
/* Prolog
	pokemon(Name, pflanze, Level, Kraftpunkte, Entwicklungsstufe).
	oder
	pokemon(Name, Typ, Level, Kraftpunkte, Entwicklungsstufe), Typ = pflanze.
*/

% PROJEKTION MIT SELEKTION
/* SQL
	SELECT Name, Typ
	FROM Pokemon
	WHERE Typ = 'pflanze';
*/
/* Prolog
	pokemon(Name, Typ, _, _, _), Typ = pflanze.
*/

% UND-Verknüpfung
/* SQL
	SELECT Name, Typ, Level, Kraftpunkte, Entwicklungsstufe
	FROM Pokemon
	WHERE typ = 'wasser'
	AND Kraftpunkte > 175;
*/
/* Prolog
	pokemon(Name, Typ, Level, Kraftpunkte, Entwicklungsstufe), Typ = wasser, Kraftpunkte > 175.
*/

% ODER-Verknüpfung
/* SQL
	SELECT Name, Typ, Level, Kraftpunkte, Entwicklungsstufe
	FROM Pokemon
	WHERE typ = 'wasser'
	OR typ = 'feuer';
*/
/* Prolog
	pokemon(Name, Typ, Level, Kraftpunkte, Entwicklungsstufe), (Typ=wasser; Typ=feuer).
*/

% JOIN
/* SQL
	SELECT Name, Typ, Typ2, Schadensmultiplikator
	FROM Pokemon
	INNER JOIN VorteilTyp ON Pokemon.Typ = VorteilTyp.Typ1;
*/
/* PROLOG
	pokemon(Name, Typ, _, _, _), vorteilTyp(Typ, Typ2, Schadensmultiplikator).
*/

% INSERT
/* SQL
	INSERT INTO Pokemon(Name, Typ, Level, Kraftpunkte, Entwicklungsstufe)
	VALUES ('Pikachu', 'Elektro', 20, 178, 1).
*/
/* Prolog
	assertz(pokemon(pikachu, elektro, 20, 178, 1)).
*/

% DELETE
/* SQL
	DELETE FROM Pokemon
	WHERE Name = 'pikachu';
*/
/* Prolog
	retract(pokemon(pikachu, _, _, _, _)).
*/

% DELETE ALL
/* SQL
	DELETE FROM Pokemon;
*/
/* Prolog
	retractall(pokemon(_,_,_,_,_)).
*/

% UPDATE
/* SQL
	UPDATE Pokemon
	SET Level = 11
	WHERE Name = 'glumanda';
*/
/* Prolog
	retract(pokemon(glumanda, Typ, Level, Kraftpunkte, Entwicklungsstufe)),
	assertz(pokemon(glumanda, Typ, 11, Kraftpunkte, Entwicklungsstufe)).
*/
