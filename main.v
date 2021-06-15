import filelock

fn main() {
	println('Hello lock!')
	mut l := filelock.new('test.lock')
	/*
	unsafe {
		l.unlink()
	}
	res := l.acquire_retries(10, 10) or { panic(err) }
	if !res {
		println('cannot acquire')
		exit(1)
	}
	*/
	l.acquire() or { panic(err) }
	for i := 0; i < 10; i++ {
		eprintln('wait')
		C.sleep(1)
	}
	// do blocking stuff
	l.release()
}
