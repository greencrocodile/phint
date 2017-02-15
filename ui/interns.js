Ext.Loader.setPath('Ext.ux', 'ux');
Ext.Loader.setConfig({
    enabled: true
});
Ext.require([
    'Ext.data.*',
    'Ext.form.*',
    'Ext.grid.*',
    'Ext.toolbar.*'
]);

Ext.onReady(function () {
	console.log('interns onReady');
	initDataModels();
    var panelN = Ext.create('Ext.panel.Panel', {
        region: 'north',
        border: false,
        bodyCls: 'alt-background',
        items: [menuPanel]
    });

    if (checkUserRole('INTERNS_R')) {

        //**********variables**********
        var selectedInternId = -1;
      

        var internsStore = Ext.create('Ext.data.Store', {
            model: 'InternsModel',
			proxy: {
				type: 'jsonp',
				url: 'interns_list.php',
				extraParams: {active_only: 1},
				simpleSortMode: true,
				reader: {
					root: 'list',
					totalProperty: 'total'
				}
			},
			pageSize: 1000000000,
            remoteSort: true,
            sorters: [{
				property: 'lastname',
				direction: 'DESC'
			}]
        });

        
        var internsGrid = Ext.create('Ext.grid.Panel', {
            store: internsStore,
			region: 'center',
            disableSelection: false,
            rowLines: true,
            columnLines: true,
            columns: [{
                    dataIndex: 'lastname',
                    text: 'Фамилия',
                    width: 100,
                    sortable: true
                }, {
                    dataIndex: 'firstname',
                    text: 'Имя',
                    width: 100,
                    sortable: true
                }, {
                    dataIndex: 'middlename',
                    text: 'Отчество',
                    width: 100,
                    sortable: true
                }, {
                    dataIndex: 'birth_date',
                    text: 'дата рождения',
                    renderer: Ext.util.Format.dateRenderer('d.m.Y'),
                    width: 70,
                    sortable: true
                }
            ],
            bbar: Ext.create('Ext.PagingToolbar', {
                store: internsStore,
                displayInfo: true,
                displayMsg: '{0} - {1} из {2}',
                emptyMsg: 'Список пуст'
            }),
            listeners: {
                itemclick: function (view, record) {
                    if (record) {
                        selectedInternId = record.data.id;
                    }
                },
                itemdblclick: function (view, record) {
                    if (record) {
                        selectedInternId = record.data.id;
						editIntern(selectedInternId, 0, function(){
							internsStore.reload();
						})
                    }
                }
            }
        });

       
        var editInternPanel = Ext.create('Ext.panel.Panel', {
            border: false,
			region: 'north',
            bodyCls: 'alt-background',
            items: [
                {
                    xtype: 'button',
					iconCls: 'add-img',
                    margin: '3 3 3 3',
                    listeners: {
                        click: function () {
                            addIntern(
								function (id) {
									editIntern(id, 1,
										function () {
											internsStore.reload();
										})
								}
                            )
                        }
                    }
                },
                {
                    xtype: 'button',
					iconCls: 'delete-img',
                    margin: '3 3 3 3',
					listeners: {
						click: function () {
                            deleteIntern(selectedInternId, function () {
                                internsStore.reload();
                            })
                        }
					}
                }
            ]
        });

        var panelG = Ext.create('Ext.panel.Panel', {
            region: 'north',
            border: false,
            bodyCls: 'alt-background',
            items: [
                {
                    xtype: 'label',
                    html: '<span style="font-size: 180%; font-weight: bold">&nbsp;Учебные группы&nbsp;</span>'
                }
            ]
        });

		var numberField = Ext.create('Ext.form.field.Text', {
            fieldLabel: '№ группы',
			region: 'north',
            allowBlank: true,
            margin: '3 3 3 3'
        });
		
		var startDateFromField = Ext.create('Ext.form.field.Date', {
            fieldLabel: 'с',
			region: 'north',
			startDay: 1,
            labelAlign: 'right',
			labelWidth: 30,
            format: 'd.m.Y',
            margin: '3 3 3 3'
        });
		
		var startDateTillField = Ext.create('Ext.form.field.Date', {
            fieldLabel: 'по',
			region: 'north',
			startDay: 1,
            labelAlign: 'right',
			labelWidth: 30,
            format: 'd.m.Y',
            margin: '3 3 3 3'
        });
		
		var endDateFromField = Ext.create('Ext.form.field.Date', {
            fieldLabel: 'с',
			region: 'north',
			startDay: 1,
            labelAlign: 'right',
			labelWidth: 30,
            format: 'd.m.Y',
            margin: '3 3 3 3'
        });
		
		var endDateTillField = Ext.create('Ext.form.field.Date', {
            fieldLabel: 'по',
			region: 'north',
			startDay: 1,
            labelAlign: 'right',
			labelWidth: 30,
            format: 'd.m.Y',
            margin: '3 3 3 3'
        });

		var theoryDateFromField = Ext.create('Ext.form.field.Date', {
            fieldLabel: 'с',
			region: 'north',
			startDay: 1,
            labelAlign: 'right',
			labelWidth: 30,
            format: 'd.m.Y',
            margin: '3 3 3 3'
        });
		
		var theoryDateTillField = Ext.create('Ext.form.field.Date', {
            fieldLabel: 'по',
			region: 'north',
			startDay: 1,
            labelAlign: 'right',
			labelWidth: 30,
            format: 'd.m.Y',
            margin: '3 3 3 3'
        });
		
		var practiceDateFromField = Ext.create('Ext.form.field.Date', {
            fieldLabel: 'с',
			region: 'north',
			startDay: 1,
            labelAlign: 'right',
			labelWidth: 30,
            format: 'd.m.Y',
            margin: '3 3 3 3'
        });
		
		var practiceDateTillField = Ext.create('Ext.form.field.Date', {
            fieldLabel: 'по',
			region: 'north',
			startDay: 1,
            labelAlign: 'right',
			labelWidth: 30,
            format: 'd.m.Y',
            margin: '3 3 3 3'
        });
		
		var gibddDateFromField = Ext.create('Ext.form.field.Date', {
            fieldLabel: 'с',
			region: 'north',
			startDay: 1,
            labelAlign: 'right',
			labelWidth: 30,
            format: 'd.m.Y',
            margin: '3 3 3 3'
        });
		
		var gibddDateTillField = Ext.create('Ext.form.field.Date', {
            fieldLabel: 'по',
			region: 'north',
			startDay: 1,
            labelAlign: 'right',
			labelWidth: 30,
            format: 'd.m.Y',
            margin: '3 3 3 3'
        });
		
		var schoolUnitsCombo = Ext.create('Ext.form.ComboBox', {
            fieldLabel: 'Подразделение',
			region: 'north',
            store: schoolUnitsStore,
            queryMode: 'local',
            displayField: 'name_full',
            valueField: 'id',
            margin: '3 3 3 3',
            labelWidth: 100,
            width: 500,
			matchFieldWidth: false,
			listConfig: {
				width: 500
			},
            editable: true,
            allowBlank: true
		});
		
		var lProgramsCombo = Ext.create('Ext.form.ComboBox', {
            fieldLabel: 'Программа обучения',
			region: 'north',
            store: lProgramsStore,
            queryMode: 'local',
            displayField: 'name_full',
            valueField: 'id',
            margin: '3 3 3 3',
            labelWidth: 100,
            width: 500,
			matchFieldWidth: false,
			listConfig: {
				width: 500
			},
            editable: true,
            allowBlank: true
		});

		
		var bSearch = Ext.create('Ext.Button', {
			text: 'Применить',
			margin: '0 5 5 5',
			disabled: !checkUserRole('INTERNS_R'),
			listeners: {
				click: function () {

						internsStore.getProxy().extraParams = {
							start_id: 0, 
							active_only: 1, 
							group_number : numberField.getValue(),
							date_start_from: startDateFromField.getValue(),
							date_start_till: startDateTillField.getValue(),
							date_end_from: endDateFromField.getValue(),
							date_end_till: endDateTillField.getValue(),
							theory_exam_date_from: theoryDateFromField.getValue(),
							theory_exam_date_till: theoryDateTillField.getValue(),
							practice_exam_date_from: practiceDateFromField.getValue(),
							practice_exam_date_till: practiceDateTillField.getValue(),
							gibdd_exam_date_from: gibddDateFromField.getValue(),
							gibdd_exam_date_till: gibddDateTillField.getValue(),
						};
						internsStore.load();
					
				}
			}
		});
		
		var bFilterReset = Ext.create('Ext.Button', {
			text: 'Сбросить фильтр',
			margin: '0 5 5 5',
			disabled: !checkUserRole('INTERNS_R'),
			listeners: {
				click: function () {
					numberField.setValue('');
					startDateFromField.setValue('');
					startDateTillField.setValue('');
					endDateFromField.setValue('');
					endDateTillField.setValue('');
					theoryDateFromField.setValue('');
					theoryDateTillField.setValue('');
					practiceDateFromField.setValue('');
					practiceDateTillField.setValue('');
					gibddDateFromField.setValue('');
					gibddDateTillField.setValue('');
					internsStore.getProxy().extraParams = {start_id: 0, active_only: 1};
					internsStore.load();
				}
			}
		});
		
		var filterPanel = Ext.create('Ext.panel.Panel', {
            border: false,
            bodyCls: 'alt-background',
            id: 'filterPanel',
			layout: 'border',
			region: 'east',
			width: 400,
			collapsible: true,
			collapsed: true,
			resizable: true,
			title: 'Фильтр',
            items: [
                numberField,
			    lProgramsCombo,
				{
					xtype: 'fieldset',
					title: 'Начало обучения',
					region: 'north',
					layout: 'hbox',
					items: [
						startDateFromField,
						startDateTillField
					]
				},
				{
					xtype: 'fieldset',
					title: 'Окончание обучения',
					region: 'north',
					layout: 'hbox',
					items: [
						endDateFromField,
						endDateTillField
					]
				},
				{
					xtype: 'fieldset',
					title: 'Дата сдачи теории',
					region: 'north',
					layout: 'hbox',
					items: [
						theoryDateFromField,
						theoryDateTillField
					]
				},
				{
					xtype: 'fieldset',
					title: 'Дата сдачи вождения',
					region: 'north',
					layout: 'hbox',
					items: [
						practiceDateFromField,
						practiceDateTillField
					]
				},
				{
					xtype: 'fieldset',
					title: 'Дата экзамена ГИБДД',
					region: 'north',
					layout: 'hbox',
					items: [
						gibddDateFromField,
						gibddDateTillField
					]
				},
				schoolUnitsCombo,
				{
					xtype: 'fieldcontainer',
					region: 'north',
					layout: 'hbox',
					items:[
						bSearch,
						bFilterReset
					]
				}
            ]
        });

        var internsListPanel = Ext.create('Ext.panel.Panel', {
            border: false,
            bodyCls: 'alt-background',
            id: 'internsListPanel',
			layout: 'border',
			region: 'center',
            items: [
                editLGroupsPanel,
				Ext.create('Ext.panel.Panel', {
					border: false,
					bodyCls: 'alt-background',
					layout: 'border',
					region: 'center',
					items: [
						filterPanel,
						internsGrid
					]
				})
            ]
        });

       


        lGroupsStore.getProxy().extraParams = {start_id: 0, active_only: 1};
        lGroupsStore.load();


        
		function addIntern(callback) {
            function done(result, request) {
                if (result.responseText.substr(0, 2) == 'ok') {
                    if (callback) {
                        callback(parseInt(result.responseText.substr(3)))
                    }
                } else {
                    Ext.Msg.alert('Ошибка', 'При сохранении данных произошла ошибка:</br>' + ((result.responseText == '') ? 'невозможно выполнить запрос к БД' : result.responseText) + '<br/>Попробуйте повторить операцию.');
                }
            }
            function fail(result, request) {
                Ext.Msg.alert('Ошибка', 'При сохранении данных произошла ошибка:</br>' + ((result.responseText == '') ? 'невозможно выполнить запрос к БД' : result.responseText) + '<br/>Попробуйте повторить операцию.');
            }

            function save() {

               Ext.Ajax.request({
					url: 'intern_edit.php',
					success: done,
					failure: fail,
					params: {
						id: -1,
						user_id: sessvars.userId
					}
				});
            }

            save();

        }
        Ext.create('Ext.container.Viewport', {
            layout: 'border',
            items: [
                panelN,
                panelG,
                internsListPanel
            ]
        });

    } else {
        var noPrivilegesPanel = Ext.create('Ext.panel.Panel', {
            region: 'north',
            border: false,
            bodyCls: 'alt-background',
            items: [
                {
                    xtype: 'label',
                    html: '<span style="font-size: 180%; font-weight: bold">У вас нет доступа к просмотру данных этой страницы</span>'
                }
            ]
        });

        Ext.create('Ext.container.Viewport', {
            layout: 'border',
            items: [
                panelN,
                noPrivilegesPanel
            ]
        });
    }
});
