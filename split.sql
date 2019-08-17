IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = 
            OBJECT_ID(N'dbo.split'))
	DROP FUNCTION dbo.split
GO

CREATE FUNCTION dbo.split ( @stringToSplit NVARCHAR(MAX), @char NCHAR )
RETURNS
 @returnList TABLE ([value] [nvarchar] (500))
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT

 WHILE CHARINDEX(@char, @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(@char, @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  INSERT INTO @returnList 
  SELECT @name

  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END

 INSERT INTO @returnList
 SELECT @stringToSplit

 RETURN
END
go