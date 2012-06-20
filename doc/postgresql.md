Homebrew will install to /usr/local/Cellar/postgresql, providing linked
binaries in /usr/local/bin.


Lion has a built-in PostgreSQL server, and therefore provides a built-in
_postgres user and group. We are going to make use of that.

You may read more about user management on Mac OS X:
  http://www.smilingsouls.net/Blog/20111105010130.html
  http://www.oreillynet.com/mac/blog/2006/04/deleting_mac_os_x_users_remote.html
  http://serverfault.com/questions/20702/how-do-i-create-user-accounts-from-the-terminal-in-mac-os-x-10-5


If you do in fact have the _postgres user already, you can make it useable:

  1. Make it possible to use the name 'postgres'

    sudo dscl . -append /Groups/_postgres RecordName postgres
    sudo dscl . -append /Users/_postgres RecordName postgres

  1. Give the user a shell

    sudo dscl . -create /Users/_postgres UserShell /bin/bash


If you do not have this user, you will need to create the user account and
group from the Terminal application

  1. Find an unused group ID and user ID. To see the IDs that are currently in use, type

    sudo dscl . -list /Groups PrimaryGroupID
    sudo dscl . -list /Users UniqueID

    For a sorted list of IDs, type

    sudo dscl . -list /Users UniqueID |awk '{print $2 "\t" $1}' |sort -b -g
    sudo dscl . -list /Groups PrimaryGroupID |awk '{print $2 "\t" $1}' |sort -b -g

  1. Given an unused group ID 50 and user ID 100, create the group _postgres:

    sudo dscl . -create /Groups/_postgres
    sudo dscl . -create /Groups/_postgres PrimaryGroupID 50
    sudo dscl . -append /Groups/_postgres RecordName postgres

  1. Create the user account _postgres:

    sudo dscl . -create /Users/_postgres
    sudo dscl . -create /Users/_postgres UniqueID 100
    sudo dscl . -create /Users/_postgres PrimaryGroupID 50
    sudo dscl . -create /Users/_postgres UserShell /bin/bash
    sudo dscl . -create /Users/_postgres RealName "PostgreSQL Server"
    sudo dscl . -append /Users/_postgres RecordName postgres


You can check the user variables with this command:

  sudo dscl . -read /Users/_postgres

The account does not have a password. This prevents anyone but root from
logging in as postgres. To use the postgres user account:

  sudo su - postgres


You may run into an issue with shared memory limits. Add this to /etc/sysctl.conf:

  kern.sysv.shmmax=4194304
  kern.sysv.shmmin=1
  kern.sysv.shmmni=32
  kern.sysv.shmseg=8
  kern.sysv.shmall=1024

More information:
  https://github.com/mxcl/homebrew/issues/3162
  http://www.postgresql.org/docs/current/static/kernel-resources.html#SYSVIPC


Initialize the data file:

  initdb /usr/local/var/postgres

When the database cluster is initialised, you want the cluster to not only be
owned by the postgres user, but also by the postgres group.

  sudo chown postgres:postgres /usr/local/var/postgres

We're going to have this run as postgres user.

  launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  sudo mv ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist /Library/LaunchDaemons/
  sudo chown root:wheel /Library/LaunchDaemons/homebrew.mxcl.postgresql.plist
  sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.postgresql.plist

Test it by running 'psql'. If you see something like 'could not connect to
server', open Console.app and view the system.log. Once all is well, running
'ps aux | grep postgres' will show you that _postgres owns the processes.


Now you can create the role in the database:

  createuser postgres -s

This works because you ran initdb as your own user account, which created a
role for you with permissions to do things like createuser. If you find that
you cannot createuser, you will have to login as postgres user.
