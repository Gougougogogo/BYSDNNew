USE [BYSDN]
GO
/****** Object:  Trigger [dbo].[TGR_UpdateUser]    Script Date: 5/9/2016 4:27:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [dbo].[TGR_UpdateUser]
   ON  [dbo].[Table_User]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @UserID UNIQUEIDENTIFIER,
		@OriginPhoto VARCHAR(511),
		@NewPhoto VARCHAR(511),
		@OperationTypeId UNIQUEIDENTIFIER,
		@ID UNIQUEIDENTIFIER

	SET @ID = NEWID()
    -- Insert statements for trigger here
	SELECT @OperationTypeId = ID FROM [dbo].[Table_OperationType] WHERE [Type] = 'Update User'

	SELECT @UserID = ID,@OriginPhoto = Photo FROM DELETED;

	SELECT @NewPhoto = Photo FROM INSERTED;

	IF @NewPhoto IS NULL
	BEGIN
		SET @NewPhoto = ''
	END

	-- Insert statements for trigger here
	INSERT INTO [dbo].[Table_LogEntity]
	VALUES (@ID,@OperationTypeId,'Update Photo',@OriginPhoto,@NewPhoto)

	INSERT INTO [dbo].[Table_OperationLog]
	VALUES(NEWID(),GETDATE(),@ID,@UserID)

END
