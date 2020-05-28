create database pokemon;
use pokemon;

CREATE TABLE type (
    type_name varchar(15) PRIMARY KEY,
    weak_against varchar(15) NOT NULL,
    strong_against varchar(15) NOT NULL,
    CONSTRAINT fk_type_weak_against FOREIGN KEY (weak_against) REFERENCES type(type_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_type_strong_against FOREIGN KEY (strong_against) REFERENCES type(type_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE pokemon_type (
    type_id int PRIMARY KEY AUTO_INCREMENT,
    type_1 varchar(15),
    type_2 varchar(15),
    CONSTRAINT fk_pokemon_type_type_1 FOREIGN KEY (type_1) REFERENCES type(type_name)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    CONSTRAINT fk_pokemon_type_type_2 FOREIGN KEY (type_2) REFERENCES type(type_name)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE pokemon (
    pokedex_id int PRIMARY KEY,
    pkmn_name varchar(20) NOT NULL,
    type_id int,
    trainer_lic_no bigint NOT NULL,
    has_predecessor int,
    CONSTRAINT fk_pokemon_type_id FOREIGN KEY (type_id) REFERENCES pokemon_type(type_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    CONSTRAINT fk_pokemon_has_predecessor FOREIGN KEY (has_predecessor) REFERENCES pokemon(pokedex_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE trainer (
    license_no bigint PRIMARY KEY
);

CREATE TABLE location (
    location_name varchar(30) PRIMARY KEY
);

CREATE TABLE trainer_class (
    class_name varchar(30) PRIMARY KEY,
    type varchar(15),
    CONSTRAINT fk_trainer_class_type FOREIGN KEY (type) REFERENCES type(type_name)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE move (
    move_name varchar(30) PRIMARY KEY,
    power int NOT NULL,
    accuracy int NOT NULL,
    contact_format varchar(15) NOT NULL,
    type varchar(15),
    CONSTRAINT fk_move_type FOREIGN KEY (type) REFERENCES type(type_name)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE can_learn (
    pokedex_id int,
    move_name varchar(30),
    at_level int NOT NULL,
    CONSTRAINT pk_can_learn PRIMARY KEY (pokedex_id,move_name),
    CONSTRAINT fk_can_learn_pokedex_id FOREIGN KEY (pokedex_id) REFERENCES pokemon(pokedex_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_can_learn_move_name FOREIGN KEY (move_name) REFERENCES move(move_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE pokemon_is_of_type (
    pokedex_id int,
    type_name varchar(15),
    CONSTRAINT pk_pokemon_is_of_type PRIMARY KEY (pokedex_id,type_name),
    CONSTRAINT fk_pokemon_is_of_type_pokedex_id FOREIGN KEY (pokedex_id) REFERENCES pokemon(pokedex_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_pokemon_is_of_type_type_name FOREIGN KEY (type_name) REFERENCES type(type_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE can_be_found_at (
    pokedex_id int NOT NULL,
    location_name varchar(30) NOT NULL,
    CONSTRAINT pk_can_be_found_at PRIMARY KEY (pokedex_id,location_name),
    CONSTRAINT fk_can_be_found_at_pokedex_id FOREIGN KEY (pokedex_id) REFERENCES pokemon(pokedex_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_can_be_found_at_location_name FOREIGN KEY (location_name) REFERENCES location(location_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE captured (
    pokedex_id int,
    license_no bigint,
    location_name varchar(30),
    at_datetime DATETIME,
    CONSTRAINT pk_captured PRIMARY KEY (pokedex_id,license_no,location_name),
    CONSTRAINT fk_captured_pokedex_id FOREIGN KEY (pokedex_id) REFERENCES pokemon(pokedex_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_captured_license_no FOREIGN KEY (license_no) REFERENCES trainer(license_no)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_captured_location_name FOREIGN KEY (location_name) REFERENCES location(location_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE audit_logs(
    id int NOT NULL AUTO_INCREMENT,
    table_altered VARCHAR(255) NOT NULL,
    operation VARCHAR(255) NOT NULL,
    by_user VARCHAR(255) NOT NULL,
    at_time DATETIME NOT NULL,
    PRIMARY KEY (id)
);


delimiter $$

CREATE TRIGGER cascade_trainer_lic_no
AFTER
INSERT
ON
pokemon.pokemon
FOR EACH ROW
BEGIN
    INSERT INTO trainer
        (license_no)
    values(new.trainer_lic_no);
    END$$

CREATE TRIGGER pokemon.update_pokemon_i
AFTER INSERT
ON pokemon.pokemon
FOR EACH ROW
BEGIN
    DECLARE tablenme VARCHAR(255);
    DECLARE operation VARCHAR(255);
    DECLARE username VARCHAR(255);
    DECLARE at_time DATETIME;

    SET username = USER();
    SET at_time = NOW();
    SET tablenme = 'Pokemon';
    SET operation = 'INSERT';
    
    INSERT INTO audit_logs(table_altered,operation,by_user,at_time) 
        VALUES(tablenme, operation,username,at_time);
END$$

CREATE TRIGGER pokemon.audit_pokemon_u
AFTER INSERT
ON pokemon.pokemon
FOR EACH ROW
BEGIN
    DECLARE tablenme VARCHAR(255);
    DECLARE operation VARCHAR(255);
    DECLARE username VARCHAR(255);
    DECLARE at_time DATETIME;

    SET username = USER();
    SET at_time = NOW();
    SET tablenme = 'Pokemon';
    SET operation = 'UPDATE';
    
    INSERT INTO audit_logs(table_altered,operation,by_user,at_time) 
        VALUES(tablenme, operation,username,at_time);
END$$

CREATE TRIGGER pokemon.audit_pokemon_d
AFTER DELETE
ON pokemon.pokemon
FOR EACH ROW
BEGIN
    DECLARE tablenme VARCHAR(255);
    DECLARE operation VARCHAR(255);
    DECLARE username VARCHAR(255);
    DECLARE at_time DATETIME;

    SET username = USER();
    SET at_time = NOW();
    SET tablenme = 'Pokemon';
    SET operation = 'DELETE';
    
    INSERT INTO audit_logs(table_altered,operation,by_user,at_time) 
        VALUES(tablenme, operation,username,at_time);
END$$


CREATE TRIGGER pokemon.update_move_i
AFTER INSERT
ON pokemon.move
FOR EACH ROW
BEGIN
    DECLARE tablenme VARCHAR(255);
    DECLARE operation VARCHAR(255);
    DECLARE username VARCHAR(255);
    DECLARE at_time DATETIME;

    SET username = USER();
    SET at_time = NOW();
    SET tablenme = 'Move';
    SET operation = 'INSERT';
    
    INSERT INTO audit_logs(table_altered,operation,by_user,at_time) 
        VALUES(tablenme, operation,username,at_time);
END$$

CREATE TRIGGER pokemon.audit_move_u
AFTER INSERT
ON pokemon.move
FOR EACH ROW
BEGIN
    DECLARE tablenme VARCHAR(255);
    DECLARE operation VARCHAR(255);
    DECLARE username VARCHAR(255);
    DECLARE at_time DATETIME;

    SET username = USER();
    SET at_time = NOW();
    SET tablenme = 'Move';
    SET operation = 'UPDATE';
    
    INSERT INTO audit_logs(table_altered,operation,by_user,at_time) 
        VALUES(tablenme, operation,username,at_time);
END$$

CREATE TRIGGER pokemon.audit_move_d
AFTER DELETE
ON pokemon.move
FOR EACH ROW
BEGIN
    DECLARE tablenme VARCHAR(255);
    DECLARE operation VARCHAR(255);
    DECLARE username VARCHAR(255);
    DECLARE at_time DATETIME;

    SET username = USER();
    SET at_time = NOW();
    SET tablenme = 'Move';
    SET operation = 'DELETE';
    
    INSERT INTO audit_logs(table_altered,operation,by_user,at_time) 
        VALUES(tablenme, operation,username,at_time);
END$$

CREATE TRIGGER pokemon.audit_type_i
AFTER INSERT
ON pokemon.type
FOR EACH ROW
BEGIN
    DECLARE tablenme VARCHAR(255);
    DECLARE operation VARCHAR(255);
    DECLARE username VARCHAR(255);
    DECLARE at_time DATETIME;

    SET username = USER();
    SET at_time = NOW();
    SET tablenme = 'Type';
    SET operation = 'INSERT';
    
    INSERT INTO audit_logs(table_altered,operation,by_user,at_time) 
        VALUES(tablenme, operation,username,at_time);
END$$

CREATE TRIGGER pokemon.audit_type_u
AFTER INSERT
ON pokemon.type
FOR EACH ROW
BEGIN
    DECLARE tablenme VARCHAR(255);
    DECLARE operation VARCHAR(255);
    DECLARE username VARCHAR(255);
    DECLARE at_time DATETIME;

    SET username = USER();
    SET at_time = NOW();
    SET tablenme = 'type';
    SET operation = 'UPDATE';
    
    INSERT INTO audit_logs(table_altered,operation,by_user,at_time) 
        VALUES(tablenme, operation,username,at_time);
END$$

CREATE TRIGGER pokemon.audit_type_d
AFTER DELETE
ON pokemon.type
FOR EACH ROW
BEGIN
    DECLARE tablenme VARCHAR(255);
    DECLARE operation VARCHAR(255);
    DECLARE username VARCHAR(255);
    DECLARE at_time DATETIME;

    SET username = USER();
    SET at_time = NOW();
    SET tablenme = 'Type';
    SET operation = 'DELETE';
    
    INSERT INTO audit_logs(table_altered,operation,by_user,at_time) 
        VALUES(tablenme, operation,username,at_time);
END$$



delimiter ;
 


INSERT INTO type VALUES('none', 'none', 'none');
INSERT INTO type VALUES('fire', 'none', 'none');
INSERT INTO type VALUES('water', 'none', 'none');
INSERT INTO type VALUES('grass', 'none', 'none');
INSERT INTO type VALUES('electric', 'none', 'none');
INSERT INTO type VALUES('flying', 'none', 'none');
INSERT INTO type VALUES('poison', 'none', 'none');


UPDATE type
SET weak_against = 'water', strong_against= 'grass'
WHERE type_name='fire';

UPDATE type
SET weak_against = 'fire', strong_against= 'water'
WHERE type_name='grass';

UPDATE type
SET weak_against = 'grass', strong_against= 'fire'
WHERE type_name='water';

UPDATE type
SET weak_against = 'none', strong_against= 'flying'
WHERE type_name='electric';

UPDATE type
SET weak_against = 'electric', strong_against= 'grass'
WHERE type_name='flying';



INSERT INTO pokemon_type(type_1,type_2) VALUES('fire', 'none');
INSERT INTO pokemon_type(type_1,type_2) VALUES('fire', 'flying');
INSERT INTO pokemon_type(type_1,type_2) VALUES('grass', 'none');
INSERT INTO pokemon_type(type_1,type_2) VALUES('grass', 'poison');
INSERT INTO pokemon_type(type_1,type_2) VALUES('water', 'none');
INSERT INTO pokemon_type(type_1,type_2) VALUES('electric', 'none');


INSERT INTO pokemon VALUES(1, 'bulbasaur', 4, 1, 1);
INSERT INTO pokemon VALUES(2, 'ivysaur', 4, 2, 1);
INSERT INTO pokemon VALUES(3, 'venusaur', 4, 3, 1);


INSERT INTO pokemon VALUES(4, 'charmader', 1, 4, 4);
INSERT INTO pokemon VALUES(5, 'charmeleon', 1, 5, 4);
INSERT INTO pokemon VALUES(6, 'charizard', 2, 6, 4);

INSERT INTO pokemon VALUES(7, 'squirtle', 5, 7, 7);
INSERT INTO pokemon VALUES(8, 'wartortle', 5, 8, 7);
INSERT INTO pokemon VALUES(9, 'blastoise', 5, 9, 7);


INSERT INTO pokemon VALUES(172, 'pichu', 6, 172, 172);
INSERT INTO pokemon VALUES(25, 'pikachu', 6, 25, 172);
INSERT INTO pokemon VALUES(26, 'raichu', 6, 26, 172);


INSERT INTO move VALUES('flamethrower', 100 , 100, 'special', 'fire');
INSERT INTO move VALUES('flare blitz', 120 , 100, 'physical', 'fire');
INSERT INTO move VALUES('hydro pump', 120 , 90, 'special', 'water');
INSERT INTO move VALUES('aqua jet', 90 , 100, 'special', 'water');
INSERT INTO move VALUES('razor leaf', 60 , 100, 'special', 'grass');
INSERT INTO move VALUES('vine whip', 50 , 100, 'physical', 'grass');
INSERT INTO move VALUES('thunderbolt', 100 , 100, 'special', 'electric');
INSERT INTO move VALUES('volt tackle', 120 , 100, 'physical', 'electric');
INSERT INTO move VALUES('wind cutter', 100 , 100, 'special', 'flying');
INSERT INTO move VALUES('acrobatics', 100 , 100, 'physcial', 'flying');

INSERT INTO location VALUES('pallet town');
INSERT INTO location VALUES('route 1');
INSERT INTO location VALUES('route 2');
INSERT INTO location VALUES('route 3');
INSERT INTO location VALUES('route 4');
INSERT INTO location VALUES('goldenrod city');
INSERT INTO location VALUES('pokemon league');

INSERT INTO trainer VALUES(2201800462);

INSERT INTO trainer_class VALUES('fire bender','fire');
INSERT INTO trainer_class VALUES('swimmer','water');
INSERT INTO trainer_class VALUES('gardener','grass');
INSERT INTO trainer_class VALUES('bird keeper','flying');
INSERT INTO trainer_class VALUES('electrician','electric');

INSERT INTO can_learn VALUES(1,'vine whip', 20);
INSERT INTO can_learn VALUES(8,'aqua jet', 30);
INSERT INTO can_learn VALUES(9,'aqua jet', 35);
INSERT INTO can_learn VALUES(9,'hydro pump', 49);
INSERT INTO can_learn VALUES(6,'flamethrower', 27);
INSERT INTO can_learn VALUES(6,'flare blitz', 55);
INSERT INTO can_learn VALUES(25,'thunderbolt', 26);
INSERT INTO can_learn VALUES(25,'volt tackle', 66);


INSERT INTO pokemon_is_of_type VALUES(1,'grass');
INSERT INTO pokemon_is_of_type VALUES(2,'grass');
INSERT INTO pokemon_is_of_type VALUES(3,'grass');
INSERT INTO pokemon_is_of_type VALUES(4,'fire');
INSERT INTO pokemon_is_of_type VALUES(5,'fire');
INSERT INTO pokemon_is_of_type VALUES(6,'fire');
INSERT INTO pokemon_is_of_type VALUES(7,'water');
INSERT INTO pokemon_is_of_type VALUES(8,'water');
INSERT INTO pokemon_is_of_type VALUES(9,'water');
INSERT INTO pokemon_is_of_type VALUES(172,'electric');
INSERT INTO pokemon_is_of_type VALUES(25,'electric');
INSERT INTO pokemon_is_of_type VALUES(26,'electric');

INSERT INTO can_be_found_at VALUES(25,'pallet town');
INSERT INTO can_be_found_at VALUES(1,'pallet town');
INSERT INTO can_be_found_at VALUES(4,'pallet town');
INSERT INTO can_be_found_at VALUES(7,'pallet town');
INSERT INTO can_be_found_at VALUES(26,'goldenrod city');
INSERT INTO can_be_found_at VALUES(172,'route 1');
INSERT INTO can_be_found_at VALUES(25,'route 2');
INSERT INTO can_be_found_at VALUES(26,'route 3');
INSERT INTO can_be_found_at VALUES(3,'route 3');
INSERT INTO can_be_found_at VALUES(6,'route 3');
INSERT INTO can_be_found_at VALUES(9,'route 3');

INSERT INTO captured VALUES(25,2201800462,'pallet town',CURDATE());
INSERT INTO captured VALUES(6,2201800462,'route 3',CURDATE());
INSERT INTO captured VALUES(25,2201800462,'route 2',CURDATE());
INSERT INTO captured VALUES(9,2201800462,'route 3',CURDATE());


#list all fire type moves with above average power.

select *
from move 
having power > (select avg(power) from move);


#list pokemon names and the moves they learn with  levels and order by level

select p.pkmn_name, cl.move_name, cl.at_level 
from pokemon as p right join can_learn as cl
on p.pokedex_id=cl.pokedex_id
order by cl.at_level;


#list all pokemon and their moves along with move stats

select p.pkmn_name, m.move_name, cl.at_level, m.power, m.accuracy, m.contact_format 
from pokemon as p right join can_learn as cl
on p.pokedex_id=cl.pokedex_id
inner join move as m
on m.move_name=cl.move_name
order by m.contact_format asc;


#list all the pokemon that a trainer class can have

select tc.class_name, p.pkmn_name
from trainer_class as tc left join pokemon_type as pt
on tc.type=pt.type_1 or tc.type=pt.type_2
inner join pokemon as p
on pt.type_id=p.type_id;


#list the max power move for every type

select max(power), move_name from move group by type; 


#list the second stage pokemon captured and their capture details

select c.pokedex_id,c.license_no,c.location_name,c.at_datetime
from captured as c
where pokedex_id IN
        (select pokedex_id
        from pokemon
        where has_predecessor=pokedex_id-2);


#list pokemon that appear in locations that a capture has not occoured yet IN

select p.pkmn_name, p.pokedex_id
from can_be_found_at as cbfa join pokemon as p
on cbfa.pokedex_id=p.pokedex_id
where cbfa.location_name IN
        (select l.location_name
        from location as l left join captured as c
        on c.location_name=l.location_name
        where at_datetime is null);
        
        
#list the pokemon that dont learn any moves at level 66

select p.pokedex_id,p.pkmn_name,cl.move_name, cl.at_level as LEVEL
from pokemon as p left join can_learn as cl
on p.pokedex_id = cl.pokedex_id
where cl.at_level !=66
union
select p.pokedex_id,p.pkmn_name,cl.move_name, cl.at_level as LEVEL
from pokemon as p right join can_learn as cl
on p.pokedex_id = cl.pokedex_id
where cl.at_level !=66;
