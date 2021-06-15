module filelock

[unsafe]
pub fn (mut l FileLock) unlink() {
}

pub fn (mut l FileLock) acquire() ?bool {
	return error('not implemented')
}

pub fn (mut l FileLock) release() bool {
	return false
}

pub fn (mut l FileLock) wait_acquire(s int) ?bool {
	return false
}

pub fn (mut l FileLock) try_acquire() bool {
	return false
}
