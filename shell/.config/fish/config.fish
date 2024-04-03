bass source ~/.profile

set -x DONT_PROMPT_WSL_INSTALL true

set -x XDEB_PKGROOT ~/.config/xdeb

set sponge_delay 100

set -x spring_profiles_active local

if status is-interactive
    # Commands to run in interactive sessions can go here

    # set -gx FZF_DEFAULT_OPTS '--hidden --preview "bat --style=numbers --color=always --line-range :500 {}"'

    function cd
        builtin cd $argv && eza -a -F --icons
    end

    # Enable VI Mode
    fish_vi_key_bindings
end

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

function ...
  ../..
end
function ....
  ../../..
end
function .....
  ../../../..
end

function connect_to_rds
    set secret_id $argv[1]
    set rds_endpoint $argv[2]
    set database_name $argv[3]

    set -l username
    set -l secret_string (aws secretsmanager get-secret-value --secret-id $secret_id --query 'SecretString' --output text)
    set -l username (echo $secret_string | jq -r '.username')

    set -l password

    set -l password (echo $secret_string | jq -r '.password')

    set -l encoded_password (echo $password | jq "@uri" -jRr)

    set -x -g DBUI_URL "postgres://$username:$password@$rds_endpoint:5432/$database_name"
    set -x -g DBUI_URL_ENCODED "postgres://$username:$encoded_password@$rds_endpoint:5432/$database_name"
end

function dev_t
    set -l account_number (aws sts get-caller-identity | jq -r ".Account")
    set -g -x FINIX_USERNAME 'USpxq2PKaCnagfZbq9gjeWGj'
    set -g -x FINIX_PASSWORD '61bf02c4-a947-4324-8731-65c708b68498'
    set -g -x FINIX_BASE_URL 'https://finix.sandbox-payments-api.com'
    if echo $account_number | string match -q "165569969323"
        set -l database_name "postgres"
		echo "Gamma"
        set -x -g DATASOURCE_URL jdbc-secretsmanager:postgresql://transformity-dev-cluster.cluster-cu3q2lrqndpl.us-east-1.rds.amazonaws.com:5432/postgres
        set -x -g DATASOURCE_USERNAME rds!cluster-78f774c9-e002-47c7-b4b8-7aab85a98f99
        connect_to_rds $DATASOURCE_USERNAME "transformity-dev-cluster.cluster-cu3q2lrqndpl.us-east-1.rds.amazonaws.com" $database_name
    else if echo $account_number | string match -q "928004597368"
		echo "Prod"
        set -x -g DATASOURCE_URL jdbc-secretsmanager:postgresql://transformity-production.cluster-c7q0uw4ubo4n.us-east-1.rds.amazonaws.com:5432/postgres
        set -x -g DATASOURCE_USERNAME rds!cluster-ed2fdf32-bf0a-420b-af63-0aafc8364dd7
        echo $DATASOURCE_USERNAME
        connect_to_rds $DATASOURCE_USERNAME "transformity-production.cluster-c7q0uw4ubo4n.us-east-1.rds.amazonaws.com" "postgres"
    end
end

complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
[ -f ~/.config/fish/conf.d/tokyonight_storm.fish ]; and . ~/.config/fish/conf.d/tokyonight_storm.fish; or true
