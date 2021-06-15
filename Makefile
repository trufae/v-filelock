all:
	v run main.v

fmt:
	v fmt -w main.v filelock/*.v
