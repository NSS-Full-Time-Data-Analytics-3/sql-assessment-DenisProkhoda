--Question 1

--1a)
select count(id),grade_id 
from author
group by grade_id
order by grade_id desc;
--1b)
select a.grade_id,count(a.gender_id),g.name
from author as a inner join gender as g on g.id = a.gender_id
where a.gender_id not in ('4','3')
group by grade_id,g.name
order by grade_id desc;

--1c) Each year the number of poets increasing. Also, in each year there are more females than males. 

--Question 2

select count(*)
from poem
where "title" ilike '%love%'

select count(*)
from poem
where "title" ilike '%death%'

--2) Love poems = 618, death poems = 18 

with t as (select title
		 from poem
		 where "title" ilike '%death%'
		group by title)
select avg (char_count) as avg_for_death
from poem inner join t using (title)

with p as (select title
		 from poem
		 where "title" ilike '%love%'
		group by title)
select avg (char_count) as avg_for_love
from poem inner join p using (title)

-- 2)Average for love 200 characters, which is shorter than average for death which equals to 256


--Question 3

select sum(p.char_count),avg(pe.intensity_percent) as av, e.name
from poem as p inner join poem_emotion as pe on p.id = pe.poem_id
inner join emotion as e on pe.emotion_id = e.id
group by e.name
order by av desc;

/* 3a) The longest emotion is joy with avg intensity 47
The shortest emotion is sadness with avg intensity 39*/

with avg_int as (select sum(p.char_count),avg(pe.intensity_percent) as av, e.name
from poem as p inner join poem_emotion as pe on p.id = pe.poem_id
inner join emotion as e on pe.emotion_id = e.id
group by e.name
order by av desc;)
-- 3b)

--Question 4

select pe.intensity_percent as av, e.name, g.name,gr.name
from poem as p inner join poem_emotion as pe on p.id = pe.poem_id 
inner join emotion as e on pe.emotion_id = e.id
inner join author as a on pe.id = a.id
inner join gender as g on a.gender_id = g.id
inner join grade as gr on a.grade_id = gr.id
where gr.name ='5th Grade'
and e.name ='Anger'
group by e.name, av,a.grade_id,a.gender_id,g.name,gr.name
order by av desc
limit 5;


select pe.intensity_percent as av, e.name, g.name,gr.name
from poem as p inner join poem_emotion as pe on p.id = pe.poem_id 
inner join emotion as e on pe.emotion_id = e.id
inner join author as a on pe.id = a.id
inner join gender as g on a.gender_id = g.id
inner join grade as gr on a.grade_id = gr.id
where gr.name ='1st Grade'
and e.name ='Anger'
group by e.name, av,a.grade_id,a.gender_id,g.name,gr.name
order by av desc
limit 5;
--4a) According to the intensity score 5th graders write the angriest poems then 1st graders

--4b) For the 1st grade there are two females and two males, for the 5th grade - three females and zero males



select *
from poem
where "title" ilike '%russia%'

--4c) My favourite poem :)

--Question 5

select pe.intensity_percent as ip,e.name, a.name,gr.name
from poem as p inner join poem_emotion as pe on p.id = pe.poem_id 
inner join emotion as e on pe.emotion_id = e.id
inner join author as a on pe.id = a.id
inner join grade as gr on a.grade_id = gr.id
where a.name = 'emily'
group by e.name,a.name,ip,gr.name
order by gr.name;

