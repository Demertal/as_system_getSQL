IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = 
            OBJECT_ID(N'dbo.as_system_getStringFromCode'))
	DROP FUNCTION dbo.as_system_getStringFromCode
GO


create function  dbo.as_system_getStringFromCode (@code nvarchar(max))
returns nvarchar(max)
begin
	declare @result nvarchar(max)
	select @result = cast('' as nvarchar(max)) + (select 
		(case 
			when LTRIM(RTRIM(value)) like '_--%' 
				then '/* ' + substring(LTRIM(RTRIM(value)), 4, len(LTRIM(RTRIM(value)))) + '*/'
			else LTRIM(RTRIM(value))
		end)
		+ CHAR(10)
		from dbo.splitstring(@code, CHAR(10)) FOR XML PATH (''),TYPE).value('.','NVARCHAR(MAX)')
	return cast('' as nvarchar(max)) + '''' + replace((select @result), '''', '''''') + ''''
end
go
