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
                    dataIndex: 'birthdate',
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

		var firstnameField = Ext.create('Ext.form.field.Text', {
            fieldLabel: 'Имя',
			region: 'north',
            allowBlank: true,
            margin: '3 3 3 3'
        });		
		
		var middlenameField = Ext.create('Ext.form.field.Text', {
            fieldLabel: 'Отчество',
			region: 'north',
            allowBlank: true,
            margin: '3 3 3 3'
        });		
		
		var lastnameField = Ext.create('Ext.form.field.Text', {
            fieldLabel: 'Фамилия',
			region: 'north',
            allowBlank: true,
            margin: '3 3 3 3'
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
							firstname : firstnameField.getValue(),
							middlename : middlenameField.getValue(),
							lastname : lastnameField.getValue()
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
					firstnameField.setValue('');
					middlenameField.setValue('');
					lastnameField.setValue('');
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
                lastnameField,
                firstnameField,
                middlenameField,
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
                editInternPanel,
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

       


        internsStore.getProxy().extraParams = {start_id: 0, active_only: 1};
        internsStore.load();


        
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
