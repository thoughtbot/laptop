set -e

pushd /usr/local/bin
curl -L http://github.com/pivotal/git_scripts/tarball/master | gunzip | tar xvf - --strip=2
popd
