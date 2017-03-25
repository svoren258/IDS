DROP TABLE players CASCADE CONSTRAINTS ;
DROP TABLE  heroes  CASCADE CONSTRAINTS;
DROP TABLE  equipment  CASCADE CONSTRAINTS;
DROP TABLE  meeting  CASCADE CONSTRAINTS;
DROP TABLE  game  CASCADE CONSTRAINTS;


CREATE TABLE players (
    id_player integer,
    nickname varchar(50),
    age integer,
    PRIMARY KEY(nickname)
);

CREATE TABLE heroes
(
	id_hero integer,
    classname varchar(10),
    race varchar(20),
    alive integer,
    levelnumber integer,
    player_nickname varchar(50),
    FOREIGN KEY(player_nickname) REFERENCES players(nickname),
    PRIMARY KEY(id_hero)
);

CREATE TABLE equipment
(
    id_equipment integer,
    quantity integer,
    origin varchar(20),
    eq_type varchar(30),
    id_hero integer,
    FOREIGN KEY(id_hero) REFERENCES heroes(id_hero),
    PRIMARY KEY(id_equipment)
);



CREATE TABLE game (
    id_game integer,
    game_type varchar(20),
    difficulty varchar(20),
    mission varchar(255),
    game_location varchar(255),
    PRIMARY KEY(id_game)
);


CREATE TABLE meeting (
    id_meeting integer,
    place varchar(255),
    player_nickname varchar(50),
    id_game integer,
    typ_sedenia varchar(255),
    FOREIGN KEY(id_game) REFERENCES game(id_game),
    FOREIGN KEY(player_nickname) REFERENCES players(nickname),
    PRIMARY KEY(id_meeting)
);