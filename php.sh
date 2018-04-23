#!/bin/sh

php_versions=("5.6" "7.0" "7.1" "7.2")

for version in ${php_versions[*]}; do
  formula="php@$version"

  # Install php version
  brew install "$formula"

  # Configure each PHP-FPM (FastCGI Process Manager) listening port
  www_conf_path="/usr/local/etc/php/$version/php-fpm.d/www.conf"
  fpm_conf_path="/usr/local/etc/php/$version/php-fpm.conf"
  conf_path="unknown file"
  port_suffix=${version/\./}

  if grep -q "listen = 127.0.0.1:90\d\d" "$www_conf_path" 2>/dev/null; then
    conf_path="$www_conf_path"
  elif grep -q "listen = 127.0.0.1:90\d\d" "$fpm_conf_path"; then
    conf_path="$fpm_conf_path"
  fi

  if [ -f "$conf_path" ]; then
    echo "Updating listen port to $port_suffix in $conf_path"
    sed -i.bak "s/listen = 127\.0\.0\.1\:90[[:digit:]][[:digit:]]/listen = 127.0.0.1:90$port_suffix/g" "$conf_path"
  else
    echo "Unable to locate fpm conf file for $version $conf_path"
  fi

  # Configure PHP-FPM to auto start using Homebrew services
  brew services start "$formula"
done

