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

This module runs only on unix systems, windows port will be done soon.
