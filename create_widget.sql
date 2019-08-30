EXEC [dbo].[client_pac_create_custom_widget_type]
	@WidgetName = 'Deep Dive Sample',
	@WidgetFile = N'DeepDiveWidget',
	@addUser = dzarn_pac,
	@formKey = 'aa0c2413-b416-4a04-bc64-4ba1ca3a0c75',
	@parentKey = '0c2413b4-164a-04bc-9b74-b47d1a6e7abb',
	@widgetHtmlText = N'Deep Dive Sample'
