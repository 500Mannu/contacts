USE [master]
GO
/****** Object:  Database [Contact]    Script Date: 2019/05/07 09:04:43 ******/
CREATE DATABASE [Contact]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Contact', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Contact.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Contact_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Contact_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Contact] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Contact].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Contact] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Contact] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Contact] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Contact] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Contact] SET ARITHABORT OFF 
GO
ALTER DATABASE [Contact] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Contact] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Contact] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Contact] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Contact] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Contact] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Contact] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Contact] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Contact] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Contact] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Contact] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Contact] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Contact] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Contact] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Contact] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Contact] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Contact] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Contact] SET RECOVERY FULL 
GO
ALTER DATABASE [Contact] SET  MULTI_USER 
GO
ALTER DATABASE [Contact] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Contact] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Contact] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Contact] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Contact] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Contact', N'ON'
GO
USE [Contact]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[DoB] [varchar](50) NOT NULL,
	[Notes] [varchar](50) NOT NULL,
	[Photo] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactType]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactType](
	[ContactTypeCode] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](255) NOT NULL,
 CONSTRAINT [PK_ContactType] PRIMARY KEY CLUSTERED 
(
	[ContactTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailContact]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmailContact](
	[EmailContactId] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
	[EmailType] [int] NULL,
	[EmailAddress] [varchar](255) NOT NULL,
 CONSTRAINT [PK_EmailContact] PRIMARY KEY CLUSTERED 
(
	[EmailContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Favorite]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favorite](
	[FavoriteId] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
 CONSTRAINT [PK_Favorite] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhoneContact]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneContact](
	[PhoneContactId] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NULL,
	[PhoneType] [int] NULL,
	[Phone] [nchar](10) NULL,
 CONSTRAINT [PK_PhoneContact] PRIMARY KEY CLUSTERED 
(
	[PhoneContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[EmailAddress] [varchar](50) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_Users]
GO
ALTER TABLE [dbo].[EmailContact]  WITH CHECK ADD  CONSTRAINT [FK_EmailContact_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmailContact] CHECK CONSTRAINT [FK_EmailContact_Contact]
GO
ALTER TABLE [dbo].[EmailContact]  WITH CHECK ADD  CONSTRAINT [FK_EmailContact_ContactType] FOREIGN KEY([EmailType])
REFERENCES [dbo].[ContactType] ([ContactTypeCode])
GO
ALTER TABLE [dbo].[EmailContact] CHECK CONSTRAINT [FK_EmailContact_ContactType]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD  CONSTRAINT [FK_Favorite_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Favorite] CHECK CONSTRAINT [FK_Favorite_Contact]
GO
ALTER TABLE [dbo].[PhoneContact]  WITH CHECK ADD  CONSTRAINT [FK_PhoneContact_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PhoneContact] CHECK CONSTRAINT [FK_PhoneContact_Contact]
GO
ALTER TABLE [dbo].[PhoneContact]  WITH CHECK ADD  CONSTRAINT [FK_PhoneContact_ContactType] FOREIGN KEY([PhoneType])
REFERENCES [dbo].[ContactType] ([ContactTypeCode])
GO
ALTER TABLE [dbo].[PhoneContact] CHECK CONSTRAINT [FK_PhoneContact_ContactType]
GO
/****** Object:  StoredProcedure [dbo].[add_user]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[add_user]
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
/****** Object:  StoredProcedure [dbo].[create_contact]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[create_contact]
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
GO
/****** Object:  StoredProcedure [dbo].[create_email_address]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[create_email_address]
	@ContactId AS INT,
	@EmailType AS INT,
	@EmailAddress AS VARCHAR(255)
AS
BEGIN
	INSERT INTO EmailContact(ContactId, EmailType, EmailAddress)
	VALUES(@ContactId, @EmailType, @EmailAddress)
END
GO
/****** Object:  StoredProcedure [dbo].[create_phone_contact]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[create_phone_contact]
	@ContactId AS INT,
	@PhoneType AS INT,
	@Phone AS VARCHAR(15)
AS
BEGIN
	INSERT INTO PhoneContact(ContactId, PhoneType, Phone)
	VALUES(@ContactId, @PhoneType, @Phone)
END
GO
/****** Object:  StoredProcedure [dbo].[delete_contact]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[delete_contact]
	@ContactId AS INT
AS
BEGIN
	DELETE FROM Contact WHERE(ContactId = @ContactId)
END
GO
/****** Object:  StoredProcedure [dbo].[get_contact_details]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_contact_details]
	@ContactId AS INT
AS
BEGIN
	SELECT * FROM Contact WHERE(ContactId = @ContactId)
END
GO
/****** Object:  StoredProcedure [dbo].[get_contact_email]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_contact_email]
AS
BEGIN
	SELECT * FROM EmailContact
END
GO
/****** Object:  StoredProcedure [dbo].[get_contacts]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_contacts]
	@UserId AS INT
AS
BEGIN
	SELECT * FROM Contact WHERE(UserId = @UserId)
END
GO
/****** Object:  StoredProcedure [dbo].[get_phone_details]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_phone_details]
AS
BEGIN
	SELECT * FROM PhoneContact
END
GO
/****** Object:  StoredProcedure [dbo].[update_contact]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[update_contact]
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
GO
/****** Object:  StoredProcedure [dbo].[user_login]    Script Date: 2019/05/07 09:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[user_login]
	@Username AS VARCHAR(50),
	@Password AS VARCHAR(255)
AS
BEGIN
	SELECT * FROM Users WHERE(Username = @Username AND Password = @Password)
END


GO
USE [master]
GO
ALTER DATABASE [Contact] SET  READ_WRITE 
GO
