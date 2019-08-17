IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = 
            OBJECT_ID(N'dbo.as_system_getSQL_procs'))
	DROP FUNCTION dbo.as_system_getSQL_procs
GO

create function  dbo.as_system_getSQL_procs (@part nvarchar(32), @code nvarchar(32))
returns nvarchar(max)
begin
	return (select 'declare @name nvarchar(256), @sqlExpec nvarchar(max);' + CHAR(13)+CHAR(10)
	 + 'declare cur CURSOR LOCAL for '
		+ 'select o.name from sys.objects as o where o.name like ''' + @part + '_' + @code + '[_]%'' AND type in (N''P'', N''PC'')' + CHAR(13)+CHAR(10)
	 + 'open cur fetch next from cur into @name' + CHAR(13)+CHAR(10)
	 + 'while @@FETCH_STATUS = 0 BEGIN' + CHAR(13)+CHAR(10)
		+ 'begin try'  + CHAR(13)+CHAR(10)
			+ 'set @sqlExpec = ''drop procedure '' + @name' + CHAR(13)+CHAR(10)
			+ 'exec sp_executesql @sqlExpec' + CHAR(13)+CHAR(10)
			+ 'print N''Удалена хранимая процедура '' + @name'	+ CHAR(13)+CHAR(10)
		+ 'end try' + CHAR(13)+CHAR(10)
		+ 'begin catch' + CHAR(13)+CHAR(10)
			+ 'print N''Ошибка при удалени хранимой процедуры '' + @name + '': '' + error_message()'  + CHAR(13)+CHAR(10)			
		+ 'end catch' + CHAR(13)+CHAR(10)
		+ 'fetch next from cur into @name END' + CHAR(13)+CHAR(10)
	+ 'close cur deallocate cur' + CHAR(13)+CHAR(10)
	+ (select COALESCE(cast('' as nvarchar(max)) + 'begin try' + CHAR(13)+CHAR(10)
		+ 'exec sp_executesql N' + dbo.as_system_getStringFromCode ((select OBJECT_DEFINITION (OBJECT_ID(o.name)))) + CHAR(13)+CHAR(10)
		+ 'print N''Добавлена хранимая процедура ' + o.name + '''' + CHAR(13)+CHAR(10)
	+ 'end try' + CHAR(13)+CHAR(10)
	+ 'begin catch' + CHAR(13)+CHAR(10)
		+ 'print N''Ошибка при добавлении хранимой процедуры ' + o.name + ':'' + error_message()'  + CHAR(13)+CHAR(10)
	+ 'end catch' + CHAR(13)+CHAR(10), '') AS [text()]
		 from  sys.objects as o where o.name like @part + '_' + @code +'[_]%' FOR XML PATH (''),TYPE).value('.','NVARCHAR(MAX)'))
end
go
