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

delimiter ;