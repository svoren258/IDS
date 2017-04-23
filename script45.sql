DROP TABLE players CASCADE CONSTRAINTS ;
DROP TABLE heroes  CASCADE CONSTRAINTS;
DROP TABLE equipment  CASCADE CONSTRAINTS;
DROP TABLE meeting  CASCADE CONSTRAINTS;
DROP TABLE game  CASCADE CONSTRAINTS;
DROP TABLE hero_game CASCADE CONSTRAINTS;
DROP TABLE player_on_meeting CASCADE CONSTRAINTS;
DROP TABLE meeting_game CASCADE CONSTRAINTS;
DROP TABLE hero_equipment CASCADE CONSTRAINTS;

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


INSERT INTO players VALUES(0001, 'Seki', 22, 9408094738);
INSERT INTO players VALUES(0002, 'Ondrej', 21, 1349408094);
INSERT INTO players VALUES(0003, 'Andrej', 21, 9349408095);
    
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
SELECT players.age, avg(players.personal_id)
FROM players
NATURAL JOIN heroes
WHERE players.nickname LIKE '%dre%'
GROUP BY (players.age);
SELECT * FROM TABLE(DBMS_XPLAN.display);

CREATE INDEX idx ON players(age,personal_id);

EXPLAIN PLAN FOR
SELECT players.age, avg(players.personal_id)
FROM players
NATURAL JOIN heroes
WHERE players.nickname LIKE '%dre%' AND players.age = '21'
GROUP BY (players.age);
SELECT * FROM TABLE(DBMS_XPLAN.display);



SELECT * FROM players;






