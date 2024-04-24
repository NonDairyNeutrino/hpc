#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>

#define ITERATIONS 10
#define NUM_THREADS 2

int a = 0;

// initialize mutex lock
// used later to prevent data race
pthread_mutex_t myMutex = PTHREAD_MUTEX_INITIALIZER;

// inc thread function
void * inc(void * arg){
	int id = (int)(long)(arg);
	printf("Started inc thread[%d]\n", id);
	for(int i = 0; i < ITERATIONS; i++){
		pthread_mutex_lock(&myMutex);
		a++;
		pthread_mutex_unlock(&myMutex);
	}
	printf("Stopping inc thread[%d]\n", id);

}

// dec thread function
void * dec(void * arg){
	int id = (int)(long)(arg);
	printf("Started dec thread[%d]\n", id);
	for(int i = 0; i < ITERATIONS; i++){
		pthread_mutex_lock(&myMutex);
		a--;
		pthread_mutex_unlock(&myMutex);
	}
	printf("Stopping dec thread[%d]\n", id);

}

// thread function
void * myFunction(void * arg) {
	while(1){
		printf("I am still in the threads ...\n");
		sleep(5);
	}
}

int main(){
	pthread_t IncThreads[NUM_THREADS];
	pthread_t DecThreads[NUM_THREADS];

	// pthread_create
	for(int i = 0; i < NUM_THREADS; i++){
		pthread_create(&IncThreads[i], NULL, inc, (void *)i);
		pthread_create(&DecThreads[i], NULL, dec, (void *)i);
	}

	// pthread_join
	for(int i = 0; i < NUM_THREADS; i++){
		pthread_join(IncThreads[i],NULL);
		pthread_join(DecThreads[i],NULL);
	}

	printf("The final value of a is:%d\n",a); fflush(stdout);

	return 0;
}
