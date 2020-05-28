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
