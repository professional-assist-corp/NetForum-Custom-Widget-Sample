-- =============================================
-- Author:		Drew Zarn
-- Create date: 29 August 2019
-- Description:	Add a widget type and widget so the new widget type can be used in the form designer
-- =============================================
ALTER PROCEDURE [dbo].[client_pac_create_custom_widget_type]
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

	INSERT INTO [dbo].[md_dynamic_form_mvcWidgetType]
		(mvt_key, mvt_add_user, mvt_add_date, mvt_path, mvt_filename)
	VALUES
		(@typeKey, @addUser, GETDATE(), @widgetPath, @WidgetFile)

	INSERT INTO [dbo].[md_dynamic_form_mvcWidget]
		(mvc_key, mvc_versionDate, mvc_add_user, mvc_add_date, mvc_dyn_key, mvc_parent_key, mvc_order, mvc_mvt_key, mvc_html_text)
	VALUES
		(@widgetKey, GETDATE(), @addUser, GETDATE(), @formKey, @parentKey, 1, @typeKey, @widgetHtmlText)

	PRINT 'Widget added' + @WidgetFile
	PRINT 'Clear cache before testing'
END
