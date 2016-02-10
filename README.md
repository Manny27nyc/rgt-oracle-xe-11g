# rgt-oracle-xe-11g [![](https://badge.imagelayers.io/carloscastillo/rgt-oracle-xe-11g:latest.svg)](https://imagelayers.io/?images=carloscastillo/rgt-oracle-xe-11g:latest 'Get your own badge on imagelayers.io')
This is a simple image based on sath89/oracle-xe-11g but forked from webdizz/docker-oracle-xe-11g-sa for sieze my custom needs: simple schema creation with a few privilegies.

## Usage

You can specify several schemas to be created after database initialization setting
environment variable `SCHEMAS`.

In adition you can put inside batch folder any `sql` scripts and all them
will be executed after schema creation (or after database initialization if
no schemas are specified). You can parametrize those scripts by specify environment
variable `BATCH_PARAMS`.

Here is an example that, after build, creates a container with an Oracle XE
instance with a schema called PRU and executes the sample sql file in batch
folder parametrized with "World", wich says "Hello World":

```
docker build -t rgt-ora .
docker run -d -p 1521:1521 -p 8080:8080 --env SCHEMAS=PRU --env BATCH_PARAMS=World --name ora rgt-ora  && docker logs --follow ora
```

You can run from docker hub instead of create your own image like this:

```
docker run -d -p 1521:1521 -p 8080:8080 --env SCHEMAS=PRU --env BATCH_PARAMS="World" -v /your/host/batch/scripts/folder:/u01/scripts/batch --name ora carloscastillo/rgt-oracle-xe-11g  && docker logs --follow ora
```

This should be the output:

```
40b65f2cea2c88b7e87d1457f8e0a02f5c9645b1cf04d63e57d56bbf65546bc6
ls: cannot access /u01/app/oracle/oradata: No such file or directory
Database not initialized. Initializing database.
Setting up:
processes=500
sessions=555
transactions=610
If you want to use different parameters set processes, sessions, transactions env variables and consider this formula:
processes=x
sessions=x*1.1+5
transactions=sessions*1.1

Oracle Database 11g Express Edition Configuration
-------------------------------------------------
This will configure on-boot properties of Oracle Database 11g Express
Edition.  The following questions will determine whether the database should
be starting upon system boot, the ports it will use, and the passwords that
will be used for database accounts.  Press <Enter> to accept the defaults.
Ctrl-C will abort.

Specify the HTTP port that will be used for Oracle Application Express [8080]:
Specify a port that will be used for the database listener [1521]:
Specify a password to be used for database accounts.  Note that the same
password will be used for SYS and SYSTEM.  Oracle recommends the use of
different passwords for each database account.  This can be done after
initial configuration:
Confirm the password:

Do you want Oracle Database 11g Express Edition to be started on boot (y/n) [y]:
Starting Oracle Net Listener...Done
Configuring database...Done
Starting Oracle Database 11g Express Edition instance...Done
Installation completed successfully.
Database initialized. Please visit http://#containeer:8080/apex to proceed with configuration
Oracle Database 11g Express Edition instance is already started

Database ready to use. Enjoy! ;)
Is about to create schema: PRU

User created.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.

Executing scripts in batch folder with parameters: [ World ] ...
Hello World
```
Be aware that database has to be created before the execution of all scripts
so between "Starting Oracle Net Listener..." and the execution may take some
minutes.
