module filelock

#include <sys/file.h>

fn C.unlink(&char) int
fn C.open(&char, int, int) int
fn C.flock(int, int) int

pub struct FileLock {
	name string
mut:
	fd int
}

pub fn new(fileName string) FileLock {
	return FileLock{
		name: fileName
		fd: -1
	}
}

[autofree]
pub fn (mut l FileLock) unlink() {
	C.unlink(l.name.str)
}

pub fn (mut l FileLock) acquire() ?bool {
	if l.fd != -1 {
		// lock already acquired by this instance
		return false
	}
	// nothing
	mut fd := C.open('$l.name'.str, C.O_CREAT, 644)
	if fd == -1 {
		// if stat is too old delete lockfile
		fd = C.open('$l.name'.str, C.O_RDONLY, 0)
	}
	if fd == -1 {
		return error('cannot create lock file $l.name')
	}
	if C.flock(fd, C.LOCK_EX) == -1 {
		return error('cannot lock')
	}
	l.fd = fd
	return true
}

pub fn (mut l FileLock) acquire_retries(retries int, s int) ?bool {
	for i := 0; i < retries; i++ {
		if l.acquire() or {
			// do nothing
		}
		{
			return true
		}
		C.usleep(s * 1000)
	}
	return false
}

pub fn (mut l FileLock) release() bool {
	if l.fd != -1 {
		C.close(l.fd)
		l.fd = -1
		C.unlink(l.name.str)
		return true
	}
	return false
}

pub fn (mut l FileLock) is_available() bool {
	fd := C.open('$l.name'.str, C.O_CREAT, 644)
	defer {
		C.close(fd)
	}
	if l.fd != -1 {
		err := C.flock(fd, C.LOCK_EX | C.LOCK_NB)
		if err == -1 {
			return true
		}
	}
	return false
}
