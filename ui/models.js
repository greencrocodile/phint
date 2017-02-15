function initDataModels() {
	Ext.define('InternsModel', {
		extend: 'Ext.data.Model',
		// proxy: {
			// type: 'jsonp',
			// url: 'interns-list.php',
			// extraParams: {active_only: 1},
			// simpleSortMode: true,
			// reader: {
				// root: 'list',
				// totalProperty: 'total'
			// }
		// },
		fields: [
			{name: 'id', type: 'int'},
			'',
			{name: 'date_start', type: 'date'},
		],
		idProperty: 'id'
	});
}