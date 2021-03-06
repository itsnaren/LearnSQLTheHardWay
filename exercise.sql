
CREATE TABLE Person (
	id INTEGER PRIMARY KEY,
	firstName TEXT,
	lastName TEXT,
	age INTEGER
);

CREATE TABLE Pet (
	id INTEGER PRIMARY KEY,
	name TEXT,
	breed TEXT,
	age INTEGER,
	dead INTEGER
);

CREATE TABLE PersonPet (
	personID INTEGER,
	petID INTEGER
);

INSERT INTO Person (id, firstName, lastName, age)
	VALUES	(0, "Zed", "Shaw", 37);

INSERT INTO Person VALUES (1, "TED", "Bean", 38);

INSERT INTO Pet VALUES (0, "Fluffy", "Unicorn", 1000, 0);

INSERT INTO Pet VALUES (1, "Gigantor", "Robot", 1, 1);

INSERT INTO Pet VALUES (2, "Bean", "Robochicken", 1, 0);

INSERT INTO PersonPet VALUES (0, 1);

INSERT INTO PersonPet VALUES (0, 2);

SELECT * FROM Person;

SELECT name, age FROM Pet;

SELECT name, age FROM Pet where dead = 0;

SELECT * FROM Person WHERE firstName != "Zed";

SELECT name FROM Pet WHERE age > 10;

SELECT firstName, age FROM Person WHERE age > 19;

SELECT firstName, age FROM Person WHERE firstName != "zed" AND age > 19;

SELECT firstName, age FROM Person WHERE firstName != "Zed" OR age > 19 AND lastName != NULL;

SELECT Pet.id, Pet.name, Pet.age, Pet.dead
	FROM Pet, PersonPet, Person
	WHERE
	Pet.id = PersonPet.petID AND
	PersonPet.personID = Person.id AND
	Person.firstName = "Zed";

/* Make sure there's dead pets */
SELECT name, age FROM pet WHERE dead = 1;

/* aww poor robot */
DELETE FROM Pet WHERE dead = 1;

/* robot should be gone by now */
SELECT * FROM Pet;

/* let's resurrect the robot */
INSERT INTO Pet VALUES (1, "Gigantor", "Robot", 1, 0);

/* The robot lives! */
SELECT * FROM Pet;

/* Name change */
UPDATE Person SET firstName = "Hilarious Guy"
	WHERE firstName = "Zed";

/* Another name change */
UPDATE Pet SET name = "Fancy Pants"
	WHERE id = 0;

SELECT * FROM Person;

SELECT * FROM Pet;

/* Revert the name change */
UPDATE Person SET firstName = "Zed" 
	WHERE id = 0;

SELECT * FROM Person;

INSERT INTO Pet VALUES (50, "Chigg", "chong", 1, 1);
INSERT INTO Pet VALUES (51, "zhigg", "choeg", 2, 1);
INSERT INTO Pet VALUES (52, "ahigg", "whong", 2, 1);

/* Rename all dead animals to DECEASED */
UPDATE Pet SET name = "DECEASED"
	WHERE dead = 1;

SELECT * FROM Pet;

UPDATE Pet SET name = "Zed's Pet" WHERE id IN (

	SELECT Pet.id 
		FROM Pet, PersonPet, Person
		WHERE
		Person.id = PersonPet.personID AND
		Pet.id = PersonPet.petID AND
		Person.firstName = "Zed"
);

SELECT * FROM Pet;

INSERT INTO PersonPet VALUES (0, 50);
INSERT INTO PersonPet VALUES (0, 51);
INSERT INTO PersonPet VALUES (0, 52);

/* Update dead pets owned by Zed to Zed's dead pet */
UPDATE Pet SET name = "Zed's Dead pet" WHERE id IN (
	
	SELECT Pet.id 
		FROM Pet, PersonPet, Person 
		WHERE 
		Person.id = PersonPet.personID AND
		Pet.id = PersonPet.petID AND
		Person.firstName = "Zed" AND
		pet.dead = 1
);

SELECT * FROM Pet;

DELETE FROM Pet WHERE id IN (
	SELECT Pet.id
	FROM Pet, PersonPet, Person 
	WHERE
	Person.id = PersonPet.personID AND
	Pet.id = PersonPet.petID AND
	Person.firstName = "Zed"
);

SELECT * FROM Pet;

SELECT * FROM PersonPet;

DELETE FROM PersonPet
	WHERE petID NOT IN (
		SELECT id FROM Pet 
	);

SELECT * FROM PersonPet;

/* Remove all tables if they exist */
DROP TABLE IF EXISTS Person;

/* Recreate it to work with it. */
CREATE TABLE Person (
	id INTEGER PRIMARY KEY,
	firstName TEXT,
	lastName TEXT,
	age INTEGER
);

BEGIN;
/* Rename the table to peoples */
ALTER TABLE Person RENAME TO Peoples;

/* Add a hatred column to peoples */
ALTER TABLE Peoples ADD COLUMN hatred INTEGER;

/* Rename peoples back to person */
ALTER TABLE Peoples RENAME TO Person;

.schema Person

ROLLBACK;
DROP TABLE IF EXISTS Person;

DROP TABLE IF EXISTS PersonPet;


DROP TABLE IF EXISTS Pet;

