CREATE DATABASE demo;

CREATE ROLE demo_admin WITH SUPERUSER LOGIN;

ALTER ROLE demo_admin WITH ENCRYPTED PASSWORD 'postgres';

CREATE TABLE jsonb_test (
       id   integer PRIMARY KEY,
       doc  jsonb,
)

INSERT INTO public.jsonb_test VALUES (
       1, '{"id": 1 "profileName": "admin", "hobbies": ["the great outdoors", "music", "sandwiches"], "location": {"state": "OR", "zip": 97206}}'
),(
	2, '{"id": 2, "profileName": "dude", "hobbies": ["fishing", "ironing"], "location": {"state": "OR", "zip": 97206}}'
),(
	3, '{"id": 3, "profileName": "the colonel", "hobbies": ["cows", "ganster rap"], "location": {"state": "OR", "zip": 97206}}'
);

