# ACM : Awk Contact Manager
acm.sh is an interface for a set of awk scripts to handle contacts.

## Storing contacts
acm search for contact files in this order :
 - `$ACM_ADDRESSBOOK`
 - `$XDG_DATA_HOME/acm/`
 - `$HOME/.acm/`
 - `$HOME/.abook/addressbook`

If any of these is a directory, acm will concatenate all the non-hidden regular
files found within this directory, allowing to split contact storage in
multiples files.

An entry has the format `key=value` or `key=value1,value2...`. Any non empty
line which does not contact a `=` is considered a separator, thus indicating
a new contact.

A contact example :
```
-----
name=Boss
email=boss@company.org,boss@mailoo.org
city=Somewhere
phone=0000666000
tag=work,master
-----
```

## Commands
Each subcommand correspond to an awk script. Each script can accomplish a
different task.

There is only one subcommand for now : `get`.

### Get
This script accept two arguments and an optionnal third. The first argument
designate a key, and the second a regex. Each contact having the key will have
its value matched against the regex. If it validates, the contact is printed.
In case of a key with multiple values, the regex is matched against every
value.

The third argument designate how the contact is printed. It is a string in
which every `{key}` will be replaced by the value for this contact.

## Examples
 - `acm.sh get email ".*@gmail.com" "{name}"` shows the name of all the
    contacts with a gamil address.

