 -- 1. Selezionare tutte le nazioni il cui nome inizia con la P e la cui 
 -- area è maggiore di 1000 kmq 
 
 select * 
 from `countries` c 
 where name like 'P%' and area > 1000; 
 
 -- 2. Selezionare le nazioni il cui national day è avvenuto più di 
 -- 100 anni fa 

select *
from `countries` c 
where timestampdiff(year, national_day, curdate()) > 100;

 -- 3. Selezionare il nome delle regioni del continente europeo, in 
 -- ordine alfabetico 

select *
from regions r 
inner join continents c2
on r.continent_id = c2.continent_id 
where c2.name = 'Europe'
order by r.name;

-- 4. Contare quante lingue sono parlate in Italia 
-- versione semplificata
select count(*) 
from country_languages cl
where cl.country_id = 107;

-- versione inner join
select count(*)
from `languages` l 
inner join `country_languages` cl 
on l.language_id = cl.language_id 
inner join `countries` c 
on c.country_id = cl.country_id 
where c.name = 'Italy';

 -- 5. Selezionare quali nazioni non hanno un national day 

select *
from countries c 
where c.national_day is null;

 -- 6. Per ogni nazione selezionare il nome, la regione e il 
 -- continente 

select c.name, r.name, c2.name
from regions r  
inner join continents c2 
on r.continent_id = c2.continent_id 
inner join countries c 
on r.region_id = c.region_id 
group by c.name;

 -- 7. Modificare la nazione Italy, inserendo come national day il 2 
 -- giugno 1946 

update countries 
set national_day = '1946-06-02'
where name = 'Italy'

 -- 8. Per ogni regione mostrare il valore dell'area totale 

select r.name as region_name, sum(area)
from countries c 
inner join regions r 
on c.region_id = r.region_id 
group by r.name;


 -- 9. Selezionare le lingue ufficiali dell'Albania 

select *
from countries c 
inner join country_languages cl 
on c.country_id = cl.country_id 
inner join languages l 
on l.language_id = cl.language_id 
where c.name = 'Albania' and cl.official = 1;

 -- 10. Selezionare il Gross domestic product (GDP) medio dello 
 -- United Kingdom tra il 2000 e il 2010 

select avg(gdp)
from countries c 
inner join country_stats cs 
on c.country_id = cs.country_id 
where c.name = 'United Kingdom' and cs.`year` between 2000 and 2010;

 -- 11. Selezionare tutte le nazioni in cui si parla hindi, ordinate 
 -- dalla più estesa alla meno estesa 

select *
from countries c 
inner join country_languages cl 
on c.country_id = cl.country_id 
inner join languages l 
on l.language_id = cl.language_id 
where l.`language` like 'Hindi'
order by c.area desc;


 -- 12. Per ogni continente, selezionare il numero di nazioni con 
 -- area superiore ai 10.000 kmq ordinando i risultati a partire dal 
 -- continente che ne ha di più

select c2.name, count(c.country_id) as nazioni_con_area_mag10000
from continents c2
inner join regions r 
on r.continent_id = c2.continent_id 
inner join countries c 
on c.region_id = r.region_id 
where c.area > 10000
group by c2.name 
order by nazioni_con_area_mag10000 desc;




