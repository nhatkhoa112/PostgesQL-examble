-- Proj 2: Create Tables Batch
-- @author Gajjan Jasani
-- @version 20 March 2017

\echo 'Creating "sailors" table'
create table sailors
	(sid integer,
	sname varchar(20),
	rating integer,
	age real,
	primary key(sid));
	
	
\echo 'Creating "boats" table'
create table boats
	(bid integer,
	bname varchar(20),
	color varchar(20),
	primary key(bid));


\echo 'Creating "reserves" table'
create table reserves
	(sid integer,
	bid integer,
	day date,
	foreign key(sid) references sailors,
	foreign key(bid) references boats);


\echo 'All the tables are created'