#
# Do not change content here, image automatically built
#
FROM httpd:alpine

ENV \
	GENERAL_KEYS_TRUE="True" \
	GENERAL_KEYS_FALSE="False" \
	GENERAL_KEYS_DEV="dev" \
	GENERAL_KEYS_PRD="prd" \
	BUILD_NAME="apache-alpine" \
	BUILD_BRANCH="latest" \
	BUILD_COMMIT="668e412" \
	BUILD_VERSION="latest" \
	BUILD_ENV="prd" \
	BUILD_HTTPD_PORT_DEV="80" \
	BUILD_HTTPD_PORT_PRD="443" \
	BUILD_DOCKERFILE_IMAGE="httpd:alpine" \
	BUILD_DOCKERFILE_PORTS_MAIN="443" \
	BUILD_DOCKERFILE_CMD="httpd-foreground" \
	SETUP_HTTPD_CONF_PATH="/usr/local/apache2/conf" \
	SETUP_HTTPD_CONF_MAIN="/usr/local/apache2/conf/httpd.conf" \
	SETUP_HTTPD_CONF_CONFD="/usr/local/apache2/conf/conf.d" \
	SETUP_HTTPD_CONF_VHOSTD="/usr/local/apache2/conf/vhost.d" \
	SETUP_PHP_FPM="True" \
	CONFIG_HTTPD_SERVERNAME="apache-alpine" \
	CONFIG_HTTPD_ALIAS="apache-alpine" \
	CONFIG_HTTPD_TIMEOUT="1000" \
	CONFIG_HTTPD_DOCUMENT_ROOT="/var/www/html" \
	CONFIG_HTTPD_DOCUMENT_INDEX="index.php" \
	CONFIG_HTTPD_DOCUMENT_OPTIONS="FollowSymLinks" \
	CONFIG_PHP_PROXY_TIMEOUT="100" \
	CONFIG_PHP_PROXY_REGEX=".+\.ph(p[3457]?|t|tml)$" \
	CONFIG_PHP_FPM_HOST="php-fpm.service" \
	CONFIG_PHP_FPM_PORT="9000" \
	CONFIG_PATHS_TEMPLATES_HTTPD_SERVER="/usr/local/templates/10-server.conf" \
	CONFIG_PATHS_TEMPLATES_HTTPD_SSL="/usr/local/templates/10-ssl.conf" \
	CONFIG_PATHS_TEMPLATES_HTTPD_FASTCGI="/usr/local/templates/20-fastcgi.conf" \
	CONFIG_PATHS_TEMPLATES_HTTPD_VHOST_DEV="/usr/local/templates/dev_vhost.conf" \
	CONFIG_PATHS_TEMPLATES_HTTPD_VHOST_PRD="/usr/local/templates/prd_vhost.conf" \
	CONFIG_PATHS_CONF_HTTPD_SERVER="/usr/local/apache2/conf/conf.d/10-server.conf" \
	CONFIG_PATHS_CONF_HTTPD_SSL="/usr/local/apache2/conf/conf.d/10-ssl.conf" \
	CONFIG_PATHS_CONF_HTTPD_FASTCGI="/usr/local/apache2/conf/conf.d/20-fastcgi.conf" \
	CONFIG_PATHS_CONF_HTTPD_VHOST="/usr/local/apache2/conf/vhost.d/main.conf"

ADD envvars /usr/local/envvars
ADD bin/setup /usr/local/bin/setup
ADD bin/config /usr/local/bin/config
ADD templates /usr/local/templates

RUN chmod +rx /usr/local/bin/setup && \
    chmod +rx /usr/local/bin/config && \
    sync && \
    #. /usr/local/envvars && \
    /usr/local/bin/setup 

EXPOSE 443 

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/usr/local/bin/config && httpd-foreground"]