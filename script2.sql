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


INSERT INTO players VALUES(0001, 'Seki', 22);
INSERT INTO players VALUES(0002, 'Ondrej', 21);
    
INSERT INTO heroes VALUES(0001, 'rogue', 'hobbit', 1, 1, 'Bilbo', 'Seki');
INSERT INTO heroes VALUES(0002, 'warrior', 'hobbit', 1, 1, 'Sauron', 'Ondrej');
INSERT INTO heroes VALUES(0003, 'mage', 'hobbit', 0, 1, 'Saruman', 'Ondrej');
INSERT INTO heroes VALUES(0004, 'rogue', 'hobbit', 1, 1, 'Chicho', 'Ondrej');

INSERT INTO equipment VALUES(0001, 'Enormously huge axe of eternal pain', 1, 'Raid', 'helmet');
INSERT INTO equipment VALUES(0002, 'Sneaky Little Dagger', 1, 'Adventure', 'dagger');
INSERT INTO equipment VALUES(0003, 'One Ring', 1, 'Market', 'ring');

INSERT INTO game VALUES(0001, 'crusade', 'hard', 'Destroy the One Ring', 'Mordor', NULL, 'Seki');
INSERT INTO game VALUES(0002, 'adveture', 'medium', 'Steal the treasure from the forgotten mine', NULL, 'The middle earth', 'Ondrej');

INSERT INTO meeting VALUES(0001, 'D105', 0001);
INSERT INTO meeting VALUES(0002, 'Herna 3', 0002);

INSERT INTO hero_game VALUES(0001, 'Chicho', 0001);
INSERT INTO hero_game VALUES(0002, 'Sauron', 0001);
INSERT INTO hero_game VALUES(0003, 'Saruman', 0002);
INSERT INTO hero_game VALUES(0004, 'Sauron', 0002);

INSERT INTO player_on_meeting VALUES(0001, 'Seki', 0001);
INSERT INTO player_on_meeting VALUES(0002, 'Ondrej', 0001);
INSERT INTO player_on_meeting VALUES(0003, 'Ondrej', 0002);

INSERT INTO meeting_game VALUES(0001, 0001, 0001);
INSERT INTO meeting_game VALUES(0002, 0002, 0002);

INSERT INTO hero_equipment VALUES(0001, 3, 'Chicho', 0001);
INSERT INTO hero_equipment VALUES(0002, 2, 'Saruman', 0002);
INSERT INTO hero_equipment VALUES(0003, 1, 'Sauron', 0003);