# build.sh

bundle install
bundle exec jekyll build


./terraform init
./terraform validate main

if [[ $TRAVIS_BRANCH == 'master' ]]
then
    ./terraform workspace select prod
    ./terraform apply -auto-approve website
fi
