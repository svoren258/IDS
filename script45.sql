DROP TABLE players CASCADE CONSTRAINTS ;
DROP TABLE heroes  CASCADE CONSTRAINTS;
DROP TABLE equipment  CASCADE CONSTRAINTS;
DROP TABLE meeting  CASCADE CONSTRAINTS;
DROP TABLE game  CASCADE CONSTRAINTS;
DROP TABLE hero_game CASCADE CONSTRAINTS;
DROP TABLE player_on_meeting CASCADE CONSTRAINTS;
DROP TABLE meeting_game CASCADE CONSTRAINTS;
DROP TABLE hero_equipment CASCADE CONSTRAINTS;
DROP SEQUENCE lastID;


CREATE TABLE players (
    id_player integer UNIQUE,
    nickname varchar(50) NOT NULL,
    age integer,
    personal_id integer CHECK (personal_id between 1000000000 and  9999999999) UNIQUE,
    PRIMARY KEY(nickname)
);

CREATE TABLE heroes (
	id_hero integer UNIQUE,
    classname varchar(10) NOT NULL,
    race varchar(20) NOT NULL,
    alive integer NOT NULL,
    levelnumber integer NOT NULL,
    hero_name varchar(20) NOT NULL,
    player_nickname varchar(50) NOT NULL ,
    FOREIGN KEY(player_nickname) REFERENCES players(nickname),
    PRIMARY KEY(hero_name)
);

CREATE TABLE equipment (
    id_equipment integer NOT NULL,
    eq_name varchar(50) NOT NULL,
    quantity integer NOT NULL,
    origin varchar(20) NOT NULL,
    eq_type varchar(30) NOT NULL,
    PRIMARY KEY(id_equipment)
);

CREATE TABLE game (
    id_game integer NOT NULL,
    game_type varchar(20) NOT NULL,
    difficulty varchar(20) NOT NULL,
    mission varchar(255) NOT NULL,
    game_location varchar(255),
    continent varchar(255),
    author_name varchar(50) NOT NULL,
    FOREIGN KEY (author_name) REFERENCES players(nickname),
    PRIMARY KEY(id_game)
);

CREATE TABLE meeting (
    id_meeting integer NOT NULL,
    place varchar(255) NOT NULL,
    id_game integer NOT NULL,
    FOREIGN KEY(id_game) REFERENCES game(id_game),
    PRIMARY KEY(id_meeting)
);

CREATE TABLE hero_game (
	id_hg integer,
	hero_name varchar(20) REFERENCES heroes(hero_name),
	id_game integer REFERENCES game(id_game),
	PRIMARY KEY(id_hg)
);

CREATE TABLE player_on_meeting (
	id_pm integer,
	nickname varchar(50) REFERENCES players(nickname),
	id_meeting integer REFERENCES meeting(id_meeting),
	PRIMARY KEY(id_pm)
);

CREATE TABLE meeting_game (
	id_mg integer,
	id_meeting integer REFERENCES meeting(id_meeting),
	id_game integer REFERENCES game(id_game),
	PRIMARY KEY (id_mg)
);

CREATE TABLE hero_equipment (
	id_he integer,
	quantity integer NOT NULL,
	hero_name varchar(20) REFERENCES heroes(hero_name),
	id_equipment integer REFERENCES equipment(id_equipment),
	PRIMARY KEY (id_he)
);

--------database triggers implementation and examples of using---------

----trigger for automatical generating of primary key using sequence
----if new player is inserted, sequence variable is incremented and
----it's value is going to be value of the new player's primary key
CREATE SEQUENCE lastID;
CREATE OR REPLACE TRIGGER incrTrigger
  BEFORE INSERT ON players
  FOR EACH ROW
BEGIN
  :new.id_player := lastID.nextval;
END incrTrigger;
/
show errors
ALTER session SET nls_date_format='dd.mm.yyyy';

INSERT INTO players VALUES(NULL, 'Miro', 22, 9401234438);
INSERT INTO players VALUES(NULL, 'Peto', 22, 9432423567);

SELECT * FROM players

----trigger for deleting of killed hero's relations
----if hero is deleted, he is not able to own any equipment etc.
----in this case are deleted all his relations with another tables
CREATE OR REPLACE TRIGGER deleteHeroRelations
  BEFORE DELETE ON heroes
  FOR EACH ROW
BEGIN
  DELETE FROM hero_equipment WHERE hero_name= :old.hero_name;
END;
/
show errors
ALTER session SET nls_date_format='dd.mm.yyyy';

SELECT * FROM heroes
SELECT * FROM hero_equipment

DELETE FROM heroes WHERE hero_name='Bilbo';

SELECT * FROM heroes
SELECT * FROM hero_equipment

------------------------------------------
INSERT INTO players VALUES(0001, 'Seki', 22, 9408094738);
INSERT INTO players VALUES(0002, 'Ondrej', 21, 1349408094);
    
INSERT INTO heroes VALUES(0001, 'rogue', 'hobbit', 1, 1, 'Bilbo', 'Seki');
INSERT INTO heroes VALUES(0002, 'warrior', 'human', 1, 1, 'Sauron', 'Ondrej');
INSERT INTO heroes VALUES(0003, 'mage', 'human', 0, 1, 'Saruman', 'Ondrej');
INSERT INTO heroes VALUES(0004, 'rogue', 'hobbit', 1, 1, 'Chicho', 'Ondrej');
INSERT INTO heroes VALUES(0005, 'warrior', 'dwarf', 1, 1, 'Gimli', 'Seki');

INSERT INTO equipment VALUES(0001, 'Enormously huge axe of eternal pain', 1, 'Crusade', 'weapon');
INSERT INTO equipment VALUES(0002, 'Sneaky Little Dagger', 1, 'Adventure', 'weapon');
INSERT INTO equipment VALUES(0003, 'One Ring', 1, 'Market', 'ring');
INSERT INTO equipment VALUES(0004, 'Sneaky Little Dagger', 1, 'Crusade', 'weapon');


INSERT INTO game VALUES(0001, 'crusade', 'hard', 'Destroy the One Ring', 'Mordor', NULL, 'Seki');
INSERT INTO game VALUES(0002, 'adventure', 'medium', 'Steal the treasure from the forgotten mine', NULL, 'The middle earth', 'Ondrej');
INSERT INTO game VALUES(0003, 'adventure', 'easy', 'Propose a dance to Rose', 'Shire', NULL, 'Seki');

INSERT INTO meeting VALUES(0001, 'D105', 0001);
INSERT INTO meeting VALUES(0002, 'Herna 3', 0002);
INSERT INTO meeting VALUES(0003, 'Divci hrad', 0003);

INSERT INTO hero_game VALUES(0001, 'Chicho', 0001);
INSERT INTO hero_game VALUES(0002, 'Sauron', 0001);
INSERT INTO hero_game VALUES(0003, 'Saruman', 0002);
INSERT INTO hero_game VALUES(0004, 'Sauron', 0002);
INSERT INTO hero_game VALUES(0005, 'Gimli', 0003);

INSERT INTO player_on_meeting VALUES(0001, 'Seki', 0001);
INSERT INTO player_on_meeting VALUES(0002, 'Ondrej', 0001);
INSERT INTO player_on_meeting VALUES(0003, 'Ondrej', 0002);

INSERT INTO meeting_game VALUES(0001, 0001, 0001);
INSERT INTO meeting_game VALUES(0002, 0002, 0002);

INSERT INTO hero_equipment VALUES(0001, 3, 'Chicho', 0001);
INSERT INTO hero_equipment VALUES(0002, 2, 'Saruman', 0002);
INSERT INTO hero_equipment VALUES(0003, 2, 'Bilbo', 0004);
INSERT INTO hero_equipment VALUES(0004, 1, 'Sauron', 0003);
---------------------END OF PART 2-----------------------


--PART 4--
--DROP INDEX idx;


EXPLAIN PLAN FOR
SELECT players.nickname, heroes.race, count(heroes.race)
FROM players
NATURAL JOIN heroes
WHERE players.nickname LIKE '%dre%' AND players.nickname = heroes.player_nickname
GROUP BY (heroes.race, players.nickname);
SELECT * FROM TABLE(DBMS_XPLAN.display);

CREATE INDEX idx1 ON heroes(race, player_nickname);

EXPLAIN PLAN FOR
SELECT players.nickname, heroes.race, count(heroes.race)
FROM players
NATURAL JOIN heroes
WHERE players.nickname LIKE '%dre%' AND players.nickname = heroes.player_nickname
GROUP BY (heroes.race, players.nickname);
SELECT * FROM TABLE(DBMS_XPLAN.display);

-------access rights definition-------
GRANT ALL ON players TO xkisel02;
GRANT ALL ON equipment TO xkisel02;
GRANT ALL ON game TO xkisel02;
GRANT ALL ON hero_equipment TO xkisel02;
GRANT ALL ON hero_game TO xkisel02;
GRANT ALL ON meeting TO xkisel02;
GRANT ALL ON heroes TO xkisel02;
GRANT ALL ON meeting_game TO xkisel02;
GRANT ALL ON player_on_meeting TO xkisel02;


----------materialized view----------
DROP VIEW Hheroes;

CREATE MATERIALIZED VIEW Hheroes AS
  CACHE
  BUILD IMMEDIATE
  REFRESH FAST ON COMMIT
  ENABLE QUERY REWRITE
  SELECT h.*
  FROM heroes h;
   
GRANT ALL ON Hheroes TO xkisel02;


SELECT * FROM Hheroes;

DELETE FROM Hheroes WHERE hero_name='Gimli';

SELECT * FROM Hheroes;

--server output on
set serveroutput on
------------------------
--PROCEDURE FINDS PERCENTAGE OF HERO RACES GIVEN IN THE ARG FROM TOTAL
------------------------
CREATE OR REPLACE PROCEDURE racePercent(race IN VARCHAR2) AS
  CURSOR emp_cursor IS SELECT * FROM heroes;
  e_c heroes%ROWTYPE;
  allraces NUMBER;
  thisrace NUMBER;
  BEGIN
    allraces := 0;
    thisrace := 0;
   OPEN emp_cursor;
      loop
        fetch emp_cursor into e_c;
          allraces := allraces + 1;
          exit when emp_cursor%NOTFOUND;
          if (e_c.race = race) then thisrace := thisrace + 1;
          end if;
      end loop;
      DBMS_OUTPUT.PUT_LINE(thisrace / allraces * 100||'%');
    CLOSE emp_cursor;
    
    EXCEPTION
  WHEN ZERO_DIVIDE THEN --ak ziadne rasy neboli vytvorene
    dbms_output.put_line('Ziadne rasy neexistuju');
  WHEN OTHERS THEN --ina vynimka
Raise_Application_Error (-555, 'Else exception!');
    
 END racePercent;
/
-----------------------
---PROCEDURE WHICH FINDS IF A HERO IS TOTAL NOOB
------------------------
CREATE OR REPLACE PROCEDURE absolutelyNew(hname IN VARCHAR2) AS
  CURSOR h_cursor IS SELECT * FROM heroes
  NATURAL JOIN hero_equipment
  NATURAL JOIN equipment;
  e_c h_cursor%ROWTYPE;
  hlevel NUMBER;
  heqs NUMBER;
  BEGIN
    heqs := 0;
    hlevel := 0;
   OPEN h_cursor;
      loop
        fetch h_cursor into e_c;
          exit when h_cursor%NOTFOUND;
          heqs := heqs + 1;
      end loop;
      if(hlevel = 0 AND heqs = 0) then 
      DBMS_OUTPUT.PUT_LINE('the hero is total noob');
      else
            DBMS_OUTPUT.PUT_LINE('the hero is level '||hlevel||' and has '|| heqs||' equipments');
end if;
    CLOSE h_cursor;
    
 END absolutelyNew;
/


exec racePercent('hobbit');
exec absolutelyNew('Bilbo');
