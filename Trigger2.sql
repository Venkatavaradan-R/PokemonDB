delimiter $$

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