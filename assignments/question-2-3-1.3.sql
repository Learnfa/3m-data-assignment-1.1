DESC lesson.teachers;

/* 3m-1.1 Coaching - Question 2 
 * write the SQL statement to alter the teachers table in the lesson schema to add a new column subject of type VARCHAR.
 */
ALTER TABLE lesson.teachers ADD COLUMN subject VARCHAR;

/* 3m-1.1 Coaching - Question 3 
 * write the SQL statement to update the `email` of the teacher with the name 'John Doe' 
   to 'john.doe@school.com' in the teachers table of the `lesson` schema.
*/

-- check
SELECT * from lesson.teachers where name = 'John Doe';
-- do
UPDATE lesson.teachers SET email = 'john.doe@school.com' where name = 'John Doe';

