--CREATE NEW USER
IF OBJECT_ID('add_user') IS NOT NULL
BEGIN
	DROP PROC add_user
END

GO

CREATE PROCEDURE add_user
	@FirstName AS VARCHAR(50),
	@LastName AS VARCHAR(50),
	@EmailAddress AS VARCHAR(50),
	@Username AS VARCHAR(50),
	@Password AS TEXT
AS
BEGIN
	INSERT INTO Users(FirstName, LastName, EmailAddress, Username, Password)
	VALUES(@FirstName, @LastName, @EmailAddress, @Username, @Password)
END

GO
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

--USER LOGIN
IF OBJECT_ID('user_login') IS NOT NULL
BEGIN
	DROP PROC user_login
END
	
GO

CREATE PROCEDURE user_login
	@Username AS VARCHAR(50),
	@Password AS VARCHAR(255)
AS
BEGIN
	SELECT * FROM Users WHERE(Username = @Username AND Password = @Password)
END

GO
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

--CREATE CONTACT
IF OBJECT_ID('create_contact') IS NOT NULL
BEGIN
	DROP PROC create_contact
END

GO

CREATE PROCEDURE create_contact
	@UserId AS INT,
	@FirstName AS VARCHAR(50),
	@LastName AS VARCHAR(50),
	@DoB AS VARCHAR(50),
	@Photo AS VARCHAR(255),
	@Notes AS VARCHAR(50)
AS
BEGIN
	INSERT INTO Contact(UserId, FirstName, LastName, DoB, Notes, Photo)
	VALUES(@UserId, @FirstName, @LastName, @DoB, @Notes, @Photo)

	SELECT TOP 1 ContactId FROM Contact ORDER BY ContactId DESC
END

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

--CREATE EMAIL ADDRESS CONTACT
IF OBJECT_ID('create_email_address') IS NOT NULL
BEGIN
	DROP PROC create_email_address
END

GO
CREATE PROCEDURE create_email_address
	@ContactId AS INT,
	@EmailType AS INT,
	@EmailAddress AS VARCHAR(255)
AS
BEGIN
	INSERT INTO EmailContact(ContactId, EmailType, EmailAddress)
	VALUES(@ContactId, @EmailType, @EmailAddress)
END

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
IF OBJECT_ID('create_phone_contact') IS NOT NULL
BEGIN
	DROP PROC create_phone_contact
END

GO
CREATE PROCEDURE create_phone_contact
	@ContactId AS INT,
	@PhoneType AS INT,
	@Phone AS VARCHAR(15)
AS
BEGIN
	INSERT INTO PhoneContact(ContactId, PhoneType, Phone)
	VALUES(@ContactId, @PhoneType, @Phone)
END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

--GET USER CONTACTS
IF OBJECT_ID('get_contacts') IS NOT NULL
BEGIN
	DROP PROC get_contacts
END

GO

CREATE PROCEDURE get_contacts
	@UserId AS INT
AS
BEGIN
	SELECT * FROM Contact WHERE(UserId = @UserId)
END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

--GET CONTACT DETAILS
IF OBJECT_ID('get_contact_details') IS NOT NULL
BEGIN
	DROP PROC get_contact_details
END

GO

CREATE PROCEDURE get_contact_details
	@ContactId AS INT
AS
BEGIN
	SELECT * FROM Contact WHERE(ContactId = @ContactId)
END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

--GET EMAIL DETAILS
IF OBJECT_ID('get_contact_email') IS NOT NULL
BEGIN
	DROP PROC get_contact_email
END

GO

CREATE PROCEDURE get_contact_email
AS
BEGIN
	SELECT * FROM EmailContact
END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

--GET PHONE DETAILS
IF OBJECT_ID('get_phone_details') IS NOT NULL
BEGIN
	DROP PROC get_phone_details
END

GO

CREATE PROCEDURE get_phone_details
AS
BEGIN
	SELECT * FROM PhoneContact
END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

--GET PHONE DETAILS
IF OBJECT_ID('update_contact') IS NOT NULL
BEGIN
	DROP PROC update_contact
END

GO

CREATE PROCEDURE update_contact
	@ContactId AS INT,
	@FirstName AS VARCHAR(50) NULL,
	@LastName AS VARCHAR(50) NULL,
	@DoB AS VARCHAR(50) NULL,
	@EmailAddress AS VARCHAR(50) NULL,
	@Phone AS VARCHAR(50) NULL,
	@Notes AS TEXT NULL
AS
BEGIN
	UPDATE Contact SET FirstName=@FirstName, LastName=@LastName, DoB=@DoB, Notes=@Notes WHERE(ContactId=@ContactId)
	UPDATE EmailContact SET EmailAddress=@EmailAddress WHERE(ContactId=@ContactId)
	UPDATE PhoneContact SET Phone=@Phone WHERE(ContactId=@ContactId)
END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

--DELETE CONTACT
IF OBJECT_ID('delete_contact') IS NOT NULL
BEGIN
	DROP PROC delete_contact
END

GO

CREATE PROCEDURE delete_contact
	@ContactId AS INT
AS
BEGIN
	DELETE FROM Contact WHERE(ContactId = @ContactId)
END
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
