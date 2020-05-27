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
