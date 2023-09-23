-- use the psql command
-- \i proj2_tester.sql
-- to load and run this batch file

-- Proj 2: Tester 
-- Use the sail database
-- @author Gajjan Jasani
-- @version 24 March 2017

\echo '\nProblem 1: Find the names of sailors who have reserved boat 103.\n'

\echo '\nResult should be:\nsname\nDustin\nLubber\nHoratio\n'

select	sname
from	sailors
where	sid in 
		(select	sid
		from	reserves
		where	bid = '103');
		

\echo 'Problem 2: Find the name of sailors who have reserved a red boat.\n'

\echo 'Result should be:\nsname\nDustin\nLubber\nHoratio\n'

select	sname
from	sailors
where	sid in 
		(select distinct sid
		from 	boats join reserves using (bid)
		where	color = 'red');
		

\echo 'Problem 3: Find the names of sailors who have not reserved a red boat.\n'

\echo 'Result should be:\nsname\nBrutus\nAndy\nRusty\nZorba\nHoratio\nArt\nBob\n'

select	sname
from	sailors
where	sid not in 
		(select distinct sid
		from 	boats join reserves using (bid)
		where	color = 'red');


\echo 'Problem 4:Find the names of sailors who have reserved boat number 103.' 
\echo 'Yes, this is the same query as Problem 1 above but your answer '
\echo 'must be substantially different with respect to the form of '
\echo 'the nested subquery and the connective that you use.\n'

\echo '\nResult should be:\nsname\nDustin\nLubber\nHoratio\n'

\echo 'This is CORRELATED SUBQUERY #1\n'

select	sname
from	sailors as s
where	exists (select	*
				from	reserves as r
				where	s.sid = r.sid and r.bid = '103');
		
		
\echo 'Problem 5: Find the sailors whose rating is better than some sailor called Horatio.\n'

\echo 'Result should be:\nsname\nLubber\nAndy\nRusty\nZorba\nHoratio\n'

\echo 'Result should be:\nsid\n31\n32\n58\n71\n74\n'

select	sname, sid
from	sailors as s1
where	rating > some (select rating
						from sailors as s2
						where s2.sname = 'Horatio');


\echo 'Problem 6: Find the sailors whose rating is better than all the sailors called Horatio.\n'

\echo 'Result should be:\nsname\nRusty\nZorba\n'

\echo 'Result should be:\nsid\n58\n71\n'

select	sname, sid
from	sailors as s1
where	rating > all (select rating
						from sailors as s2
						where s2.sname = 'Horatio');

\echo 'Problem 7: Find sailors with the highest rating.\n'

\echo 'Result should be:\nsname\nRusty\nZorba\n'

\echo 'Result should be:\nsid\n58\n71\n'

select	sname, sid
from	sailors
where	rating = (select max(rating)
					from sailors);


\echo 'Problem 8: Find the names of sailors who have reserved both a red and a green boat.\n'

\echo 'Result should be:\nsname\nDustin\nLubber\n'

select	sname
from	sailors
where	sid in ((select sid
				from boats natural join reserves
				where color = 'red')
				intersect
				(select sid
				from boats natural join reserves
				where color = 'green'));

\echo 'Problem 9: Find the names of sailors who have reserved both a red and a green boat.'
\echo 'Yes, this is the same query as the previous query above but your answer '
\echo 'must be substantially different with respect to the form of '
\echo 'the nested subquery that you use.\n'

\echo 'Result should be:\nsname\nDustin\nLubber\n'

\echo 'This is CORRELATED SUBQUERY #2\n'

select	distinct sname
from	sailors as s
where	exists (select	*
				from	(boats natural join reserves) as br
				where	s.sid = br.sid and br.color = 'red')
		and exists (select	*
					from	(boats natural join reserves) as br
					where	s.sid = br.sid and br.color = 'green');


\echo 'Problem 10: Find the names of sailors who have reserved all boats.\n'

\echo 'Result should be:\nsname\nDustin\n'

select	sname
from	sailors
where	sid in ((select sid
				from reserves
				where bid = '101')
				intersect
				(select sid
				from reserves
				where bid = '102')
				intersect
				(select sid
				from reserves
				where bid = '103')
				intersect
				(select sid
				from reserves
				where bid = '104'));

\echo 'Problem 11: Find the names of sailors who have reserved all boats. '
\echo 'Same query as the previous one but your answer must be a '
\echo 'substantively different nested subquery.\n'

\echo 'Result should be:\nsname\nDustin\n'

\echo 'This is CORRELATED SUBQUERY #3\n'

select	sname
from	sailors as s
where	exists (select *
				from reserves
				where s.sid = reserves.sid and reserves.bid = '101')
		and exists (select *
					from reserves
					where s.sid = reserves.sid and reserves.bid = '102')
		and exists (select *
					from reserves
					where s.sid = reserves.sid and reserves.bid = '103')
		and exists (select *
					from reserves
					where s.sid = reserves.sid and reserves.bid = '104');