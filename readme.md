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

The results seem to be the same when running either `test-1` or `test-2`, but different to the results on an Intel mac.

```text
TEST_VAR=somevalue
HOSTNAME=2ee17fc3fd8c
SHLVL=1
HOME=/root
ANOTHER_TEST_VAR=
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
```

When I do:

```bash
unset TEST_VAR
export ANOTHER_TEST_VAR=hello
```

the output from both make targets is:

```text
TEST_VAR=ANOTHER_TEST_VAR
HOSTNAME=02f7131a653e
SHLVL=1
HOME=/root
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
```

The only way I've seen to get consistent behaviour on the M1 is making sure all ENV vars that are getting passed through to the container are set in the parent.

```bash
export TEST_VAR=somevalue
export ANOTHER_TEST_VAR=hello
```

```text
TEST_VAR=somevalue
HOSTNAME=298c56d786dc
SHLVL=1
HOME=/root
ANOTHER_TEST_VAR=hello
TERM=xterm
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
```