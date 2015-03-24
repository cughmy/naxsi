#vi:filetype=perl


# A AJOUTER :
# TEST CASE AVEC UNE REGLE SUR UN HEADER GENERIQUE
# La même sur des arguments :)

use lib 'lib';
use Test::Nginx::Socket;

repeat_each(3);

plan tests => repeat_each(1) * blocks();
no_root_location();
no_long_string();
$ENV{TEST_NGINX_SERVROOT} = server_root();
run_tests();


__DATA__
=== TEST 1: very long url (exception in url)
--- http_config
include /etc/nginx/naxsi_core.rules;
--- config
location / {
	 SecRulesEnabled;
	 DeniedUrl "/RequestDenied";
	 CheckRule "$SQL >= 8" BLOCK;
	 CheckRule "$RFI >= 8" BLOCK;
	 CheckRule "$TRAVERSAL >= 4" BLOCK;
	 CheckRule "$XSS >= 8" BLOCK;
  	 root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
}
location /RequestDenied {
	 return 412;
	# return 412;
}
--- request
GET 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<>IOavZfK?a=buib
--- error_code: 412

=== TEST 1.1: very long get varname (exception in content)
--- http_config
include /etc/nginx/naxsi_core.rules;
--- config
location / {
	 SecRulesEnabled;
	 DeniedUrl "/RequestDenied";
	 CheckRule "$SQL >= 8" BLOCK;
	 CheckRule "$RFI >= 8" BLOCK;
	 CheckRule "$TRAVERSAL >= 4" BLOCK;
	 CheckRule "$XSS >= 8" BLOCK;
  	 root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
}
location /RequestDenied {
	 return 412;
	# return 412;
}
--- request
GET /x?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b<>
--- error_code: 412

=== TEST 1.2: very long get varname (exception in varname)
--- http_config
include /etc/nginx/naxsi_core.rules;
--- config
location / {
	 SecRulesEnabled;
	 DeniedUrl "/RequestDenied";
	 CheckRule "$SQL >= 8" BLOCK;
	 CheckRule "$RFI >= 8" BLOCK;
	 CheckRule "$TRAVERSAL >= 4" BLOCK;
	 CheckRule "$XSS >= 8" BLOCK;
  	 root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
}
location /RequestDenied {
	 return 412;
	# return 412;
}
--- request
GET /x?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<>vZfK=b
--- error_code: 412

=== TEST 1.3: very long content get varname (exception in content)
--- http_config
include /etc/nginx/naxsi_core.rules;
--- config
location / {
	 SecRulesEnabled;
	 DeniedUrl "/RequestDenied";
	 CheckRule "$SQL >= 8" BLOCK;
	 CheckRule "$RFI >= 8" BLOCK;
	 CheckRule "$TRAVERSAL >= 4" BLOCK;
	 CheckRule "$XSS >= 8" BLOCK;
  	 root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
}
location /RequestDenied {
	 return 412;
	# return 412;
}
--- request
GET /x?lol=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<>vZfK
--- error_code: 412



