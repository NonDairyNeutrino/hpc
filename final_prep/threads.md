- Each thread has its own set of registers and stack, while sharing code, data, and files.
- There are both user threads and kernel threads.  Kernel threads are always taken care of with higher priority than user threads
- There are several multithreading models
	- Many-to-One: Many user-level threads mapped to single kernel thread
	- One-to-One: Each user-level thread maps to kernel thread
	- Many-to-Many: Allows many user level threads to be mapped to many kernel threads; OS creates sufficient number of kernel threads
	- Two-Level: Like M:M but allows a single user thread to be bound to a single kernel thread e.g. a controlling thread
- Pthreads
	- Threading API
	- Common in UNIX-based operating systems
	- Available in C
	- Create a pthread with
	```C
	  pthread_t thread;
	  pthread_create(&thread, ATTRIBUTES, FUNCTION, ARGUMENT);
	```
	- Can pass multiple arguments by creating a struct whose fields hold the different arguments
	- Can ensure threads synchronize when finished using `pthread_join(THREAD_ID, ATTRIBUTES`
	- When compiling (e.g using gcc) a program that uses pthreads, must pass the `-pthread` flag
	- Thread Pools
		- Create a number of threads in a pool where they await work
		- Advantages:
			- Since the program doesn't have to create a thread, there are fewer operations and thus executes in less time
			- Allows the number of threads in the execution to be bound to the size of the thread pool