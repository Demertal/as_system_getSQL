IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = 
            OBJECT_ID(N'dbo.as_system_getSQL_page'))
	DROP PROCEDURE dbo.as_system_getSQL_page
GO

create proc dbo.as_system_getSQL_page  @code nvarchar(100), @overwrite bit = 1 as
select top 1 'declare @pageID int; set @pageID = null; ' + CHAR(13)+CHAR(10)
		+ 'select top 1 @pageID = p.id from pg_pages as p where p.code = ' + isnull('''' + p.code + '''', 'null') + ' order by p.id; ' + CHAR(13)+CHAR(10)
		+ 'begin try' + CHAR(13)+CHAR(10)
			+ 'if @pageID > 0 begin ' + CHAR(13)+CHAR(10) 
				+ (case @overwrite when 1 then
					+'update pg_pages set [title] = ' + isnull('''' + replace(p.title, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[description] = ' + isnull('''' + replace(p.description, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[html] = ' + isnull('''' + replace(cast(p.html as nvarchar), '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[seo_robots] = ' + isnull('''' + replace(p.seo_robots, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[seo_desc] = ' + isnull('''' + replace(p.seo_desc, '''', '''''') + '''', 'null')  + CHAR(13)+CHAR(10) 
						+ ',[seo_keywords] = ' + isnull('''' + replace(p.seo_keywords, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[seo_title] = ' + isnull('''' + replace(p.seo_title, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[code] = ' + isnull('''' + replace(p.code, '''', '''''') + '''', 'null')  + CHAR(13)+CHAR(10) 
						+ ',[isInMenu] = ' + isnull(cast(p.isInMenu as nvarchar), 'null') + CHAR(13)+CHAR(10) 
						+ ',[role] = ' + isnull('''' + replace(p.role, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[colHtml] = ' + isnull('''' + replace(cast(p.colHtml as nvarchar), '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[ord] = ' + isnull(cast(p.ord as nvarchar), 'null') + CHAR(13)+CHAR(10) 
						+ ',[modified] = ' + isnull('try_cast(''' + FORMAT (p.modified, 'dd.MM.yy HH:mm')  + ''' AS datetime)', 'null') + CHAR(13)+CHAR(10) 
						+ ',[menuIcon] = ' + isnull('''' + replace(p.menuIcon, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[hideTitle] = '+ isnull(cast(p.hideTitle as nvarchar), 'null') + CHAR(13)+CHAR(10) 
						+ ',[parentID] = null' + CHAR(13)+CHAR(10) 
						+ ',[isStartPanel] = ' + isnull(cast(p.isStartPanel as nvarchar), 'null') + CHAR(13)+CHAR(10) 
						+ ',[jsRenderMode] = ' + isnull(cast(p.jsRenderMode as nvarchar), 'null') + CHAR(13)+CHAR(10) 
						+ ',[layoutCode] = ' + isnull('''' + replace(p.layoutCode, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[css] = ' + isnull('''' + replace(p.css, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[js] = ' + isnull('''' + replace(p.js, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[menuPreTitle] = ' + isnull('''' + replace(p.menuPreTitle, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ' where id = @pageID;' + CHAR(13)+CHAR(10)
					+ 'print N''�������� ' + @code + ' ���������'''	+ CHAR(13)+CHAR(10)
				else 'print N''�������� ' + @code + ' ���������� � �� ����� ������������'''	+ CHAR(13)+CHAR(10) end)
			+ 'end; else begin' + CHAR(13)+CHAR(10) 
				+ 'insert into dbo.pg_pages	( [title], [description], [html], [seo_robots], [seo_desc], [seo_keywords], [seo_title]' + CHAR(13) + CHAR(10)
				+ ', [code], [isInMenu], [role], [colHtml], [ord], [modified], [menuIcon], [hideTitle], [parentID], [isStartPanel]' + CHAR(13) + CHAR(10)
				+ ', [jsRenderMode], [layoutCode], [css], [js], [menuPreTitle]) VALUES ( ' + CHAR(13)+CHAR(10) 
					+ stuff(COALESCE(', ''' + RTRIM(replace(p.title, '''', '''''')) + '''', ', null')
						+ COALESCE(', ''' + RTRIM(replace(p.description, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(cast(p.html as nvarchar), '''', '''''')) + '''', ', null')
						+ COALESCE(', ''' + RTRIM(replace(p.seo_robots, '''', '''''')) + '''', ', null')
						+ COALESCE(', ''' + RTRIM(replace(p.seo_desc, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(p.seo_title, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(p.seo_keywords, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(p.code, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ' + RTRIM(p.isInMenu), ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(p.role, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(cast(p.colHtml as nvarchar), '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ' + RTRIM(p.ord), ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', try_cast(''' + FORMAT(p.modified, 'dd.MM.yy HH:mm')  + ''' AS datetime)', ', null') + CHAR(13)+CHAR(10)
						+ COALESCE(', ''' + RTRIM(replace(p.menuIcon, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10)
						+ COALESCE(', ' + RTRIM(p.hideTitle), ', null') + CHAR(13)+CHAR(10) 
						+ ', null' + CHAR(13)+CHAR(10) 
						+ COALESCE(', ' + RTRIM(p.isStartPanel), ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ' + RTRIM(p.jsRenderMode), ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(p.layoutCode, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(p.css, '''', '''''')) + '''', ', null')  + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(p.js, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(p.menuPreTitle, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
					+'); ' + CHAR(13)+CHAR(10) 
					, 1, 2, '')
				+ 'select @pageID = scope_identity();' + CHAR(13)+CHAR(10)
				+ 'print N''�������� ' + @code + ' ���������''' + CHAR(13)+CHAR(10)
			+ 'end;' + CHAR(13)+CHAR(10)
		+ 'end try' + CHAR(13)+CHAR(10)
		+ 'begin catch' + CHAR(13)+CHAR(10)
			+ 'print N''��� ����������\���������� �������� ' + @code + ' �������� ������: '' + error_message()'	+ CHAR(13)+CHAR(10)
		+ 'end catch' + CHAR(13)+ CHAR(13)+CHAR(10)		
		+ dbo.as_system_getSQL_procs ('pg_crumbs_' + @code, @overwrite) + CHAR(13)+CHAR(10)
		+'--����� �������'
		as Result from pg_pages as p where p.code = @code order by p.id;			