-- DDL (Data Definition Language) is a group of SQL commands used to manipulate the server structure and preventing those changes.
-- Common DML operations include the ON DATABASE and is fired on commands such as CREATE, ALTER, DELETE.
-- In this example, we are using create trigger command to create the trigger safety, which, won't allow altering or deleting a table, while able.
CREATE TRIGGER safety 
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE 
AS 
BEGIN
   PRINT 'You must disable trigger "safety" to drop or alter tables!';
   ROLLBACK;
END;
