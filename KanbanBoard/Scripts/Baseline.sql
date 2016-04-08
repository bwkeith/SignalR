------------------------------------------------------------------------------------------------------------------------------------
--	Script		:	Baseline.sql
--	Description	:	
--	Developer	:	Keith Telle
--	Created		:	March 19, 2015
--	Modified	:	
------------------------------------------------------------------------------------------------------------------------------------

SET NOCOUNT ON;

BEGIN TRY
	
	BEGIN TRANSACTION;

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cards]') AND type in (N'U'))
		DROP TABLE Cards;

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Boards]') AND type in (N'U'))
		DROP TABLE Boards;

	CREATE TABLE Boards (
		Id BIGINT IDENTITY(1000,1) NOT NULL
		,[Description] NVARCHAR(MAX)
		,[Next] BIGINT NOT NULL
		,Previous BIGINT NOT NULL
		,Title NVARCHAR(64) NOT NULL
	);
	ALTER TABLE Boards ADD CONSTRAINT PK_Boards PRIMARY KEY CLUSTERED (Id);
	ALTER TABLE Boards ADD CONSTRAINT DF_Next DEFAULT 0 FOR [Next];
	ALTER TABLE Boards ADD CONSTRAINT DF_Previous DEFAULT 0 FOR Previous;

	INSERT INTO Boards ([Next], Previous, Title) VALUES (1001, 0, 'Backlog');
	INSERT INTO Boards ([Next], Previous, Title) VALUES (1002, 1000, 'Ready');
	INSERT INTO Boards ([Next], Previous, Title) VALUES (1003, 1001, 'Coding');
	INSERT INTO Boards ([Next], Previous, Title) VALUES (1004, 1002, 'Testing');
	INSERT INTO Boards ([Next], Previous, Title) VALUES (1005, 1003, 'Approval');
	INSERT INTO Boards ([Next], Previous, Title) VALUES (0, 1004, 'Done');

	CREATE TABLE Cards (
		Id BIGINT IDENTITY(1000,1) NOT NULL
		,BoardId BIGINT NOT NULL
		,Created DATETIME2(7) NOT NULL 
		,CreatedBy BIGINT NOT NULL
		,[Description] NVARCHAR(MAX)
		,Modified DATETIME2(7) NOT NULL
		,ModifiedBy BIGINT NOT NULL
		,Title NVARCHAR(64) NOT NULL
	);
	ALTER TABLE Cards ADD CONSTRAINT PK_Cards PRIMARY KEY CLUSTERED (Id);
	ALTER TABLE Cards ADD CONSTRAINT DF_Created DEFAULT GETUTCDATE() FOR Created;
	ALTER TABLE Cards ADD CONSTRAINT DF_Modified DEFAULT GETUTCDATE() FOR Modified;
	ALTER TABLE Cards ADD CONSTRAINT FK_Cards_Boards FOREIGN KEY (BoardId) REFERENCES Boards (Id);

	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1000, 0, 'This is a placeholder card.', 0, 'Placeholder 01');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1000, 0, 'This is a placeholder card.', 0, 'Placeholder 02');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1001, 0, 'This is a placeholder card.', 0, 'Placeholder 03');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1001, 0, 'This is a placeholder card.', 0, 'Placeholder 04');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1002, 0, 'This is a placeholder card.', 0, 'Placeholder 05');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1002, 0, 'This is a placeholder card.', 0, 'Placeholder 06');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1003, 0, 'This is a placeholder card.', 0, 'Placeholder 07');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1003, 0, 'This is a placeholder card.', 0, 'Placeholder 08');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1004, 0, 'This is a placeholder card.', 0, 'Placeholder 09');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1004, 0, 'This is a placeholder card.', 0, 'Placeholder 10');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1005, 0, 'This is a placeholder card.', 0, 'Placeholder 11');
	INSERT INTO Cards (BoardId, CreatedBy, [Description], ModifiedBy, Title) VALUES (1005, 0, 'This is a placeholder card.', 0, 'Placeholder 12');

	COMMIT TRANSACTION;

END TRY

BEGIN CATCH

    SELECT ERROR_NUMBER() AS ErrorNumber
		,ERROR_SEVERITY() AS ErrorSeverity
		,ERROR_STATE() as ErrorState
		,ERROR_PROCEDURE() as ErrorProcedure
		,ERROR_LINE() as ErrorLine
		,ERROR_MESSAGE() as ErrorMessage;
	
	IF @@TRANCOUNT > 0 
		ROLLBACK TRANSACTION;	

END CATCH

SET NOCOUNT OFF;
