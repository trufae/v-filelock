[![CI](https://github.com/trufae/v-filelock/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/trufae/v-filelock/actions/workflows/ci.yml)

filelock
========

FileSystem level exclusive locks.

Usage
-----

```v
import filelock

fn main() {
	println('Hello lock!')
	mut l := filelock.new('test.lock')
	l.acquire() or { panic(err) }
	// do stuff
	l.release()
}
```

TODO
----

* Merge into the main vlib

Inspiration
-----------

* https://github.com/juju/fslock
* https://www.npmjs.com/package/lockfile
* https://linux.die.net/man/2/flock
