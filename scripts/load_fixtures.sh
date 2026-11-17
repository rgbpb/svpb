#!/bin/sh
# Re-create the database of the development VM and fill it with test data.
# WARNING: This DROPS the database "svpbdata"! Only to be used with settings.vm.
if [ "${DJANGO_SETTINGS_MODULE:-}" != "settings.vm" ]; then
    echo "Error: This script deletes the database and must only be run in the development VM." >&2
    echo "Expected DJANGO_SETTINGS_MODULE=settings.vm, but it is '${DJANGO_SETTINGS_MODULE:-<unset>}'." >&2
    exit 1
fi

cd ..
# Delete and recreate database
sudo -u postgres dropdb --force --interactive svpbdata
sudo -u postgres createdb svpbdata
sudo -u postgres psql -c "grant all privileges on database svpbdata to svpbdb;"
sudo -u postgres psql -c "\connect svpbdata" -c "grant usage, create on schema public to svpbdb;"
# Init database with fixtures
python manage.py migrate
python manage.py loaddata mitglieder/fixtures/*.json
python manage.py loaddata arbeitsplan/fixtures/*.json
python manage.py loaddata boote/fixtures/*.json
