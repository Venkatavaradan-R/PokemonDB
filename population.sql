
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
