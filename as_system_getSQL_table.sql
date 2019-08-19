IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = 
            OBJECT_ID(N'dbo.as_system_getSQL_table'))
	DROP PROCEDURE dbo.as_system_getSQL_table
GO

create proc dbo.as_system_getSQL_table  @code nvarchar(32), @overwrite bit = 1 as
select top 1 'declare @tableID int, @datatypeID int, @editableTypeID int, @filterTypeID int; set @tableID = null; ' + CHAR(13)+CHAR(10)
		+ 'select top 1 @tableID = t.id from as_crud_tables as t where t.code = ' + isnull('''' + t.code + '''', 'null') + ' order by t.id; ' + CHAR(13)+CHAR(10)
		+ 'begin try' + CHAR(13)+CHAR(10)
			+ 'if @tableID > 0 begin ' + CHAR(13)+CHAR(10) 
				+ (case @overwrite when 1 then
					+'update as_crud_tables set [title] = ' + isnull('''' + replace(t.title, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[titleTooltip] = ' + isnull('''' + replace(t.titleTooltip, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[code] = ' + isnull('''' + replace(t.code, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[addEditLink] = ' + isnull('''' + replace(t.addEditLink, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[commentsCode] = ' + isnull('''' + replace(t.commentsCode, '''', '''''') + '''', 'null')  + CHAR(13)+CHAR(10) 
						+ ',[immediatelyLoad] = ' + isnull(cast(t.immediatelyLoad as nvarchar), 'null') + CHAR(13)+CHAR(10) 
						+ ',[emptyText] = ' + isnull('''' + replace(t.emptyText, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[filterLinkTitle] = ' + isnull('''' + replace(t.filterLinkTitle, '''', '''''') + '''', 'null')  + CHAR(13)+CHAR(10) 
						+ ',[showChecksCol] = ' + isnull(cast(t.showChecksCol as nvarchar), 'null')
						+ ',[showNumsCol] = ' + isnull(cast(t.showNumsCol as nvarchar), 'null')
						+ ',[showToolbar] = ' + isnull(cast(t.showToolbar as nvarchar), 'null')
						+ ',[getItemsURLParameters] = ' + isnull('''' + replace(t.getItemsURLParameters, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[toolbarAdditional] = ' + isnull('''' + replace(t.toolbarAdditional, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[groupOperationsToolbar] = ' + isnull('''' + replace(t.groupOperationsToolbar, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[getFilterMakeupCallback] = '+ isnull('''' + replace(t.getFilterMakeupCallback, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[filterCallback] = ' + isnull('''' + replace(t.filterCallback, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[processRowCallback] = ' + isnull('''' + replace(t.processRowCallback, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[getItemsCallback] = ' + isnull('''' + replace(t.getItemsCallback, '''', '''''') + '''', 'null') + CHAR(13)+CHAR(10) 
						+ ',[remove] = ' + isnull(cast(t.remove as nvarchar), 'null')
						+ ',[comments] = ' + isnull(cast(t.comments as nvarchar), 'null')
						+ ',[ctrlClickShowComment] = ' + isnull(cast(t.ctrlClickShowComment as nvarchar), 'null') + CHAR(13)+CHAR(10) 
						+ ',[users] = ' + isnull('''' + replace(t.users, '''', '''''') + '''', 'null')
						+ ',[roles] = ' + isnull('''' + replace(t.roles, '''', '''''') + '''', 'null')
						+ ',[fastCreate] = ' + isnull(cast(t.fastCreate as nvarchar), 'null')
						+ ',[pageSize] = ' + isnull(cast(t.pageSize as nvarchar), 'null')
						+ ' where id = @tableID;' + CHAR(13)+CHAR(10)
					+ 'print N''������� ' + @code + ' ���������'''	+ CHAR(13)+CHAR(10)
				else 'print N''������� ' + @code + ' ���������� � �� ����� ������������'''	+ CHAR(13)+CHAR(10) end)
			+ 'end; else begin' + CHAR(13)+CHAR(10) 
				+ 'insert into as_crud_tables ([title],[titleTooltip],[code],[addEditLink],[commentsCode],[immediatelyLoad],[emptyText]'+ CHAR(13)+CHAR(10) 
					+ ',[filterLinkTitle],[showChecksCol],[showNumsCol],[showToolbar],[getItemsURLParameters],[toolbarAdditional]' + CHAR(13)+CHAR(10) 
					+ ',[groupOperationsToolbar],[getFilterMakeupCallback],[filterCallback],[processRowCallback],[getItemsCallback],[remove]' + CHAR(13)+CHAR(10) 
					+ ',[comments],[ctrlClickShowComment],[users],[roles],[fastCreate],[pageSize]) VALUES ( ' + CHAR(13)+CHAR(10) 
					+ stuff(COALESCE(', ''' + RTRIM(replace(t.title, '''', '''''')) + '''', ', null')
						+ COALESCE(', ''' + RTRIM(replace(t.titleTooltip, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(t.code, '''', '''''')) + '''', ', null')
						+ COALESCE(', ''' + RTRIM(replace(t.addEditLink, '''', '''''')) + '''', ', null')
						+ COALESCE(', ''' + RTRIM(replace(t.commentsCode, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ' + RTRIM(t.immediatelyLoad), ', null')
						+ COALESCE(', ''' + RTRIM(replace(t.emptyText, '''', '''''')) + '''', ', null')
						+ COALESCE(', ''' + RTRIM(replace(t.filterLinkTitle, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ' + RTRIM(t.showChecksCol), ', null')
						+ COALESCE(', ' + RTRIM(t.showNumsCol), ', null')
						+ COALESCE(', ' + RTRIM(t.showToolbar), ', null')
						+ COALESCE(', ''' + RTRIM(replace(t.getItemsURLParameters, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10)
						+ COALESCE(', ''' + RTRIM(replace(t.toolbarAdditional, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10)
						+ COALESCE(', ''' + RTRIM(replace(t.groupOperationsToolbar, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(t.getFilterMakeupCallback, '''', '''''')) + '''', ', null') 
						+ COALESCE(', ''' + RTRIM(replace(t.filterCallback, '''', '''''')) + '''', ', null')
						+ COALESCE(', ''' + RTRIM(replace(t.processRowCallback, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ''' + RTRIM(replace(t.getItemsCallback, '''', '''''')) + '''', ', null')
						+ COALESCE(', ' + RTRIM(t.remove), ', null') 
						+ COALESCE(', ' + RTRIM(t.comments), ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ' + RTRIM(t.ctrlClickShowComment), ', null') 
						+ COALESCE(', ''' + RTRIM(replace(t.users, '''', '''''')) + '''', ', null')
						+ COALESCE(', ''' + RTRIM(replace(t.roles, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10) 
						+ COALESCE(', ' + RTRIM(t.fastCreate), ', null')
						+ COALESCE(', ' + RTRIM(t.pageSize), ', null') +'); ' + CHAR(13)+CHAR(10) 
					, 1, 2, '')
				+ 'select @tableID = scope_identity();' + CHAR(13)+CHAR(10)
				+ 'print N''������� ' + @code + ' ���������''' + CHAR(13)+CHAR(10)
			+ 'end;' + CHAR(13)+CHAR(10)
		+ 'end try' + CHAR(13)+CHAR(10)
		+ 'begin catch' + CHAR(13)+CHAR(10)
			+ 'print N''��� ����������\���������� ������� ' + @code + ' �������� ������: '' + error_message()'	+ CHAR(13)+CHAR(10)
		+ 'end catch' + CHAR(13)+ CHAR(13)+CHAR(10)
		+ (case @overwrite when 1 then
			+ 'begin try' + CHAR(13)+CHAR(10)
				+ 'delete from as_crud_cols where as_crud_cols.tableID = @tableID;' + CHAR(13)+CHAR(10)
				+ 'print N''������� ������� ' + @code + ' �������'''	+ CHAR(13)+CHAR(10)
			+ 'end try' + CHAR(13)+CHAR(10)
			+ 'begin catch' + CHAR(13)+CHAR(10)	
				+ 'print N''��� �������� ������� ������� ' + @code + ' �������� ������: '' + error_message()'	+ CHAR(13)+CHAR(10)
			+ 'end catch' + CHAR(13)+ CHAR(13)+CHAR(10)
		else 'print N''��������� ������� �� ����� ��������''' + CHAR(13)+ CHAR(13)+CHAR(10) end)
		+ (select 'begin try' + CHAR(13)+CHAR(10)
			+ (case @overwrite when 0 then
				'if (not exists(select 1 from as_crud_cols where code =''' + c.code + '''))' + CHAR(13)+CHAR(10)
				+ 'begin' + CHAR(13)+CHAR(10)
				else '' end)
			+ 'set @datatypeID = null; set @editableTypeID = null; set @filterTypeID = null; ' + CHAR(13)+CHAR(10)
			+ 'select @datatypeID = d.id from as_crud_dataTypes as d where d.code = '
				 + isnull('''' + replace(
					(select d.code from as_crud_dataTypes as d where c.datatypeID = d.id),
					 '''', '''''') + '''', 'null') + '; ' + CHAR(13)+CHAR(10)
			+ 'select @editableTypeID = e.id from as_crud_editableTypes as e where e.code = '
				+ isnull('''' + replace(
					(select e.code from as_crud_editableTypes as e where c.editableTypeID = e.id),
					 '''', '''''') + '''', 'null') + '; ' + CHAR(13)+CHAR(10)
			+ 'select @filterTypeID = f.id from as_crud_filterTypes as f where f.code = '
				+ isnull('''' + replace(
					(select f.code from as_crud_filterTypes as f where c.filterTypeID = f.id)
					, '''', '''''') + '''', 'null') + '; ' + CHAR(13)+CHAR(10)
			+ ' insert into as_crud_cols ([tableID],[title],[tooltip],[ord],[datatypeID],[isSort],[isVisible]' + CHAR(13)
				+ ',[isPK],[editableTypeID],[editableCallback],[filterTypeID],[code],[filterNotSelected],[format]' + CHAR(13)+CHAR(10)
				+ ',[editableMin],[editableMax],[editableStep],[sqlGetListValues],[width]) VALUES ( @tableID, '			
				+ stuff(COALESCE(', ''' + RTRIM(replace(c.title, '''', '''''')) + '''', ', null')
					+ COALESCE(', ''' + RTRIM(replace(c.tooltip, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10)
					+ COALESCE(', ' + RTRIM(c.ord), ', null')
					+ COALESCE(', @datatypeID', ', null')
					+ COALESCE(', ' + RTRIM(c.isSort), ', null')
					+ COALESCE(', ' + RTRIM(c.isVisible), ', null')
					+ COALESCE(', ' + RTRIM(c.isPK), ', null')
					+ COALESCE(', @editableTypeID', ', null') + CHAR(13)+CHAR(10)
					+ COALESCE(', ''' + RTRIM(replace(c.editableCallback, '''', '''''')) + '''', ', null')
					+ COALESCE(', @filterTypeID', ', null') + CHAR(13)+CHAR(10)
					+ COALESCE(', ''' + RTRIM(replace(c.code, '''', '''''')) + '''', ', null')
					+ COALESCE(', ''' + RTRIM(replace(c.filterNotSelected, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10)
					+ COALESCE(', ''' + RTRIM( replace(c.format, '''', '''''')) + '''', ', null')
					+ COALESCE(', ' + RTRIM(c.editableMin), ', null')
					+ COALESCE(', ' + RTRIM(c.editableMax), ', null')
					+ COALESCE(', ' + RTRIM(c.editableStep), ', null') + CHAR(13)+CHAR(10)
					+ COALESCE(', ''' + RTRIM(replace(c.sqlGetListValues, '''', '''''')) + '''', ', null')
					+ COALESCE(', ''' + RTRIM(replace(c.width, '''', '''''')) + '''', ', null') + CHAR(13)+CHAR(10)
				, 1, 2, '')
			 + ');' + CHAR(13)+CHAR(10)
			 + 'print N''������� ' + c.code + ' ������� ���������''' + CHAR(13)+CHAR(10)
			 + (case @overwrite when 0 then
				+ 'end' + CHAR(13)+CHAR(10) 
				+ 'else ' + CHAR(13)+CHAR(10) 
				+ 'print N''������� ' + c.code + ' ������� ��� ���������� � �� ����� ������������''' + CHAR(13)+CHAR(10)
				else '' end)
		+ 'end try' + CHAR(13)+CHAR(10)
		+ 'begin catch' + CHAR(13)+CHAR(10)
			+ 'print N''��� ��������� ������� ' + c.code + ' ������� �������� ������: '' + error_message()'	+ CHAR(13)+CHAR(10)
		+ 'end catch'+ CHAR(13)+ CHAR(13)+CHAR(10) from as_crud_cols as c where t.id = c.tableID FOR XML PATH (''),TYPE).value('.','NVARCHAR(MAX)')
		+ dbo.as_system_getSQL_procs ('crud_' + @code + '[_]', @overwrite) + CHAR(13)+CHAR(10)
		+'--����� �������'
		as Result from as_crud_tables as t where t.code = @code order by t.id;			
