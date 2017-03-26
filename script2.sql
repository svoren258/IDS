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
    id_player integer,
    nickname varchar(50),
    age integer,
    PRIMARY KEY(nickname)
);

CREATE TABLE heroes (
	id_hero integer,
    classname varchar(10),
    race varchar(20),
    alive integer,
    levelnumber integer,
    hero_name varchar(20),
    player_nickname varchar(50),
    FOREIGN KEY(player_nickname) REFERENCES players(nickname),
    PRIMARY KEY(hero_name)
);

CREATE TABLE equipment (
    id_equipment integer,
    quantity integer,
    origin varchar(20),
    eq_type varchar(30),
    owner_name varchar(20),
    FOREIGN KEY(owner_name) REFERENCES heroes(hero_name),
    PRIMARY KEY(id_equipment)
);

CREATE TABLE game (
    id_game integer,
    game_type varchar(20),
    difficulty varchar(20),
    mission varchar(255),
    location varchar(255),
    continent varchar(255),
    author_name varchar(50),
    FOREIGN KEY (author_name) REFERENCES players(nickname),
    PRIMARY KEY(id_game)
);

CREATE TABLE meeting (
    id_meeting integer,
    place varchar(255),
    id_game integer,
    FOREIGN KEY(id_game) REFERENCES game(id_game),
    FOREIGN KEY(author_name) REFERENCES players(nickname),
    PRIMARY KEY(id_meeting)
);

CREATE TABLE hero_game (
	id integer,
	hero_name varchar(20) REFERENCES heroes(hero_name),
	id_game integer REFERENCES game(id_game),
	PRIMARY KEY(id)
);

CREATE TABLE player_on_meeting (
	id integer,
	nickname varchar(50) REFERENCES players(nickname),
	id_meeting integer REFERENCES meeting(id_meeting),
	PRIMARY KEY(id)
);

CREATE TABLE meeting_game (
	id integer,
	id_meeting integer REFERENCES meeting(id_meeting),
	id_game integer REFERENCES game(id_game),
	PRIMARY KEY (id)
);

CREATE TABLE hero_equipment (
	id integer,
	quantity integer,
	hero_name varchar(20) REFERENCES heroes(hero_name),
	id_equipment integer REFERENCES equipment(id_equipment),
	PRIMARY KEY (id)
);