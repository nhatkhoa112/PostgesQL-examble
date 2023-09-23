-- Proj 2: Copy Tables Batch
-- @author Gajjan Jasani
-- @version 20 March 2017

\echo 'Copying "sailors" table.....'

\copy sailors from 'data/sailors_data.txt'	
	
\echo 'Copying "boats" table.....'

\copy boats from 'data/boats_data.txt'

\echo 'Copying "reserves" table.....'

\copy reserves from 'data/reserves_data.txt'


\echo 'All the tables are populated.....'