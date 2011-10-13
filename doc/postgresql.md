Add the ```postgres``` user:

  1. In Users and Groups, add an account ```postgres```. Be sure to have a password.
  1. ```sudo dscl . -create /Users/postgres UserShell /usr/bin/false```
  1. ```createuser postgres -s```
