:- module(econnect_home, []).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_path)).
:- use_module(library(http/html_write)).
:- use_module(library(http/html_head)).
:- use_module(library(semweb/rdf_library)).
:- use_module(skin(cliopatria)).
:- use_module(components(simple_search)).

/** <module> Configure Econnect demo home Page
*/

:- use_module(applications(startpage)).

% load the RDF Manifest files to enable the datacloud generation

:- initialization
	rdf_attach_library(ecdemo(rdf)),
	forall(rdf_library_source('ec-all', _), true).

:- html_resource(cliopatria,
                 [ virtual(true),
                   requires([ css('econnect.css'),
			      css('ecdemo.css')
                            ])
		 ]).

:- http_handler(cliopatria(home), home, []).

%%	home(+Request) is det.
%
%	Override default ClioPatria homepage .

home(_Request) :-
	http_absolute_location(icons('econnect-logo-big.jpg'), LogoImg, []),
	format(atom(HomeStyle), 'div.ag_search { background-image: url(~w);',[LogoImg]),
	reply_html_page(ecdemo(search),
			[title('Amalgame: home'),
			 style(HomeStyle)
			],
			[\html_schemes_only,
			 style('.yui3-accordion-item-trigger { display: none;}')
			]).

cliopatria:server_address -->
	html_requires(css('cliopatria.css')),
	html([	\logo,
		\server_address(amalgame)
	     ]).

logo -->
	{
	 http_absolute_location(icons('econnect-banner.jpg'), LogoImg, [])
	},
	html(a([class(logo),
		id(econnectlink),
		target(new),
		href('http://www.europeanaconnect.eu/')
	       ],
	       img([src(LogoImg),
		    alt('EuropeanaConnect project logo')
		   ],[])
	      )
	    ).

user:body(ecdemo(search), Body) -->
        {
         http_link_to_id(http_amalgame_main_page, [], BackOfficeLink)
        },
        html_requires(cliopatria),
        html(body(class(['yui-skin-sam', ag_search, cliopatria]),
                  [
                    div(class(ag_search),
                        [
                         \simple_search_form,
                         div(class(content), Body)
                        ]),
                        br(clear(all)),
                        div(class(footer),
                            \(cliopatria:server_address)
                        ),
                        div([class(backoffice)],
                            [a(href(BackOfficeLink), 'back office')
                            ])
                  ])).
