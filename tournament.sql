-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
SELECT pid, pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = current_database() AND pid <> pg_backend_pid(); -- Code recovered from Stack Overflow https://stackoverflow.com/questions/17449420/postgresql-unable-to-drop-database-because-of-some-auto-connections-to-db Author: Craig Ringer

\c forum

DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;

\c tournament

CREATE TABLE players(id serial, name text);

CREATE TABLE matches(id serial, winner integer, loser integer);

CREATE VIEW standings AS SELECT players.id, players.name, (SELECT count(*) FROM matches WHERE winner = players.id) AS wins, (SELECT count(*) FROM matches WHERE winner = players.id OR loser = players.id) AS matches FROM players LEFT JOIN matches ON players.id = matches.winner ORDER BY wins DESC;