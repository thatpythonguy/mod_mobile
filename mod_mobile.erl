%% @author Ahmed Al-Saadi <thaterlangguy@gmail.com>
%% @copyright 2011 Ahmed Al-Saadi
%% Date: 2011-09-20
%% @doc Mobile template rendering support module. 

%% Copyright 2011 Ahmed Al-Saadi
%% The re pattern is in the public domain (see http://detectmobilebrowsers.com/about)
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(mod_mobile).
-author("Ahmed Al-Saadi <thaterlangguy@gmail.com>").

-mod_title("Mobile").
-mod_description("Mobile (and other alternative devices) template rendering support module.").
-mod_prio(500).

%% interface functions
-export([
    observe_render_template/2
]).

-include_lib("zotonic.hrl").

observe_render_template({render_template, _Template, _Module}, Context) ->
    Agent = z_context:get_req_header("user-agent", Context),
    Pattern = "android.+mobile|avantgo|bada\\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|symbian|treo|up\\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino",
    {ok, RE_Pattern} = re:compile(Pattern, [caseless]),

    case re:run(Agent, RE_Pattern) of
         nomatch ->
             undefined;
         {match, _} ->
             z_context:get(template_mobile, Context)
    end.

