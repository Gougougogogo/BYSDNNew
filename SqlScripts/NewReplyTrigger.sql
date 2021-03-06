USE [BYSDN]
GO
/****** Object:  Trigger [dbo].[TGR_NewReply]    Script Date: 5/9/2016 3:56:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [dbo].[TGR_NewReply]
   ON  [dbo].[Table_Answer]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @UserID UNIQUEIDENTIFIER,
		@AnswerID UNIQUEIDENTIFIER,
		@OperationTypeId UNIQUEIDENTIFIER,
		@ID UNIQUEIDENTIFIER

	SET @ID = NEWID()
    -- Insert statements for trigger here
	SELECT @OperationTypeId = ID FROM [dbo].[Table_OperationType] WHERE [Type] = 'New Reply'

	SELECT @AnswerID = ID,@UserID = Publisher FROM INSERTED;

	INSERT INTO [dbo].[Table_LogEntity]
	VALUES (@ID,@OperationTypeId,'New Reply',NULL,@AnswerID)

	INSERT INTO [dbo].[Table_OperationLog]
	VALUES(NEWID(),GETDATE(),@ID,@UserID)

END
