USE [BYSDN]
GO
/****** Object:  Trigger [dbo].[TGR_NewQuestion]    Script Date: 5/9/2016 4:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [dbo].[TGR_NewQuestion]
   ON  [dbo].[Table_Question]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @UserID UNIQUEIDENTIFIER,
		@QuestionID UNIQUEIDENTIFIER,
		@OperationTypeId UNIQUEIDENTIFIER,
		@ID UNIQUEIDENTIFIER

	SET @ID = NEWID()
    -- Insert statements for trigger here
	SELECT @OperationTypeId = ID FROM [dbo].[Table_OperationType] WHERE [Type] = 'New Question'

	SELECT @QuestionID = ID,@UserID = Publisher FROM INSERTED;

	INSERT INTO [dbo].[Table_LogEntity]
	VALUES (@ID,@OperationTypeId,'New Question',NULL,@QuestionID)

	INSERT INTO [dbo].[Table_OperationLog]
	VALUES(NEWID(),GETDATE(),@ID,@UserID)

END
