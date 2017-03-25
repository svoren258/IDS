DROP TABLE IF EXISTS players  ;
DROP TABLE IF EXISTS charracters  ;
DROP TABLE IF EXISTS equipment  ;
DROP TABLE IF EXISTS meeting  ;
DROP TABLE IF EXISTS game  ;


CREATE TABLE players (
    id_player integer,
    name varchar(50),
    age integer,
    PRIMARY KEY(name)
);

CREATE TABLE charracters(
	id_charracter integer,
    class varchar(10),
    race varchar(20),
    alive boolean,
    level integer,
    id_player integer,
    FOREIGN KEY(id_player) REFERENCES players(id_player),
    PRIMARY KEY(id_charracter)
);

CREATE TABLE equipment
(
    id_equipment integer,
    quantity integer,
    origin varchar(20),
    type varchar(30),
    id_charracter integer,
    FOREIGN KEY(id_charracter) REFERENCES charracters(id_charracter),
    PRIMARY KEY(id_equipment)
);

CREATE TABLE meeting (
    id_meeting integer,
    place varchar(255),
    id_player integer,
    id_game integer,
    typ_sedenia varchar(255),
    FOREIGN KEY(id_game) REFERENCES game(id_game),
    FOREIGN KEY(id_player) REFERENCES players(id_player)
);

CREATE TABLE game (
    id_game integer,
    type varchar(20),
    difficulty varchar(20),
    mission varchar(255),
    location varchar(255),
    id_game integer,
    PRIMARY KEY(id_game)
);


