:- module(conf_cloud, []).

/** <module> Visualize loaded datacloud
*/

:- use_module(applications(app_cloud)).
:- use_module(cliopatria(hooks)).

cliopatria:menu_item(1000=places/cloud_page, 'Data Cloud').
