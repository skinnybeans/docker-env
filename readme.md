# Inconsistent ENV file treatment with docker compose and docker-compose

I was having trouble passing environment variables into containers on my M1 mac.

The variables were being set to weird values unexpectedly.

Finally found out where the behaviour came from.

## The test

firstly:

```bash
export TEST_VAR=somevalue
```

Then run:

```bash
make test-1
```

expected output if you are NOT on an M1 mac:

```text
TEST_VAR=something
HOSTNAME=58be7cbbe206
SHLVL=1
HOME=/root
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
```

Then run:

```bash
make test-2
```

Expected output:

```text
TEST_VAR=ANOTHER_TEST_VAR
HOSTNAME=5e1fb2c66eb9
SHLVL=1
HOME=/root
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
```

No idea why these outputs are different however..

## Running on an M1 Mac

Both `test-1` and `test-2`

give:

```text
TEST_VAR=ANOTHER_TEST_VAR
HOSTNAME=5e1fb2c66eb9
SHLVL=1
HOME=/root
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
```

This is really bad if you want to leverage patterns like 3musketeers, or any time you have optional ENV vars that need to get passed into a container.
