svpb
====

Some simple Django webapps for the member area of our sailing club "Segler-Verein Paderborn e.V." (SVPB).

Features
--------
* Manage tasks for obligatory working hours
  * Define tasks
  * Assign club members
  * Remind of upcoming tasks by e-mail
  * Report working hours
  * Accept reports
* Booking system for boats and boat crane
* Management of club members

Getting started
---------------
There are settings for three different environments.
The active settings module is selected via the environment variable `DJANGO_SETTINGS_MODULE`.
If it is not set, `manage.py` falls back to `settings.local` and `svpb/wsgi.py` to `settings.production`.
No source file has to be edited to switch between the environments.
1. **Local development** (`settings.local`):
   * If you want to develop in a local environment, you should know what you are doing.
   * Create your venv with Python 3.9.
   * Ensure xelatex is available to generate welcome letters for new members.
   * Run `python manage.py runserver`; `manage.py` uses `settings.local` by default.
2. **Development VM (recommended)** (`settings.vm`):
   * There's a vagrant file to automatically provision a VM with ansible.
   Head over to [svpb-ansible](https://github.com/svpbde/svpb-ansible).
   * Execute `load_fixtures.sh` in `scripts` to populate the database with some test data.
   There are four users - "Vorstand", "Mitglied", "Auch-Mitglied" and "Superuser", each with password "Test".
   * The playbook sets `DJANGO_SETTINGS_MODULE=settings.vm` for uWSGI, the cron jobs and your shell
   and links `wsgi/svpb_nginx.local.conf` (HTTP only) as nginx configuration.
3. **Production**:
   * Install the production server according to the playbook in [svpb-ansible](https://github.com/svpbde/svpb-ansible).
   * Copy `settings/production.py.template` to `settings/production.py` and fill in the credentials.
   * Set `DJANGO_SETTINGS_MODULE=settings.production` in the environment of the uWSGI service, the cron jobs and your shell.
   The playbook does this if you run it with `-e django_settings_module=settings.production`.
   * nginx uses `wsgi/svpb_nginx.conf` (selected by the playbook); it enforces the production HTTPS and host rules.
   * Test email settings with `python manage.py sendtestemail <your-email-address>` using the production settings.

The development settings accept any Host header; do not use them in production.

Python dependencies are managed with [pip-tools](https://pip-tools.readthedocs.io/en/latest/).

Contributing
------------
Feel free to open issues or pull requests.
We are pleased about any kind of contribution!
Please adhere to [PEP8](https://peps.python.org/pep-0008/) and [commit.style](https://commit.style).
