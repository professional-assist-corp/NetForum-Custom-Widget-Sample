-- =============================================
-- Author:		Drew Zarn
-- Create date: 29 August 2019
-- Description:	Add a widget type and widget so the new widget type can be used in the form designer
-- =============================================
CREATE PROCEDURE [dbo].[client_pac_create_custom_widget_type]
	@WidgetName NVARCHAR(250),
	@WidgetFile NVARCHAR(250),
	@addUser av_user,
	@formKey UNIQUEIDENTIFIER,
	@parentKey UNIQUEIDENTIFIER,
	@widgetHtmlText NVARCHAR(MAX),
	@widgetPath NVARCHAR(250)='../Widgets/'
AS
BEGIN
	DECLARE @typeKey UNIQUEIDENTIFIER=NEWID()
	DECLARE @widgetKey UNIQUEIDENTIFIER=NEWID()
	DECLARE @structureKey UNIQUEIDENTIFIER=NEWID()
	DECLARE @structureGroupKey UNIQUEIDENTIFIER
	DECLARE @versionDate DATETIME=GETDATE()

	SELECT @structureGroupKey=mvg_key
		FROM md_dynamic_form_mvcWidgetStructureGroup
		WHERE mvg_name='Custom'

	INSERT INTO [dbo].[md_dynamic_form_mvcWidgetType]
		(mvt_key, mvt_add_user, mvt_add_date, mvt_path, mvt_filename)
	VALUES
		(@typeKey, @addUser, @versionDate, @widgetPath, @WidgetFile)

	INSERT INTO [dbo].[md_dynamic_form_mvcWidget]
		(mvc_key, mvc_versionDate, mvc_add_user, mvc_add_date, mvc_dyn_key, mvc_parent_key, mvc_order, mvc_mvt_key, mvc_html_text)
	VALUES
		(@widgetKey, @versionDate, @addUser, @versionDate, @formKey, @parentKey, 1, @typeKey, @widgetHtmlText)

		INSERT INTO [dbo].[md_dynamic_form_mvcWidgetStructure]
           (mvs_key, mvs_add_user, mvs_add_date, mvs_mvg_key, mvs_name, mvs_mvc_key, mvs_mvc_versionDate)
     VALUES
           (@structureKey, @addUser, @versionDate, @structureGroupKey, @WidgetName, @widgetKey, @versionDate)

	PRINT 'Widget added: ' + @WidgetFile
	PRINT 'Widget key: ' + CONVERT(NVARCHAR(36), @widgetKey)
	PRINT 'Widget type key: ' + CONVERT(NVARCHAR(36), @typeKey)
	PRINT 'Structure key: ' + CONVERT(NVARCHAR(36), @structureKey)
	PRINT 'Clear cache before testing'
END
