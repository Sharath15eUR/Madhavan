#include <stdio.h>
#include <pthread.h>
#include <time.h>
#include <unistd.h>

int isprime(int x){
    int flag=0;
    for(int i=2;i<x;i++){
        if(x%i==0){
            flag=1;
        }
    }
    if(flag){
        return 0;
    }
    else{
        return 1;
    }
}

void* t1(void* args){
    static int s=2;
    int x=3;
    int count=0;
    while(count<=100){
        if(isprime(x)==1){
            s+=x;
            count++;
        }
        x++;
    }
    return (void*)&s;
}

void* t2(void* args){
    for(int i=1;i<=50;i++){
        printf("Thread 1 is running\n");
        sleep(2);
    }
}

void* t3(void* args){
    for(int i=1;i<=33;i++){
        printf("Thread 2 is running\n");
        sleep(3);
    }
}

int main() {
    // Write C code here
    struct timespec s,e;
    clock_t start = clock();

    pthread_t tid1,tid2,tid3;
    int N=12;
    void* primesum;
    pthread_create(&tid1,NULL,t1,&N);
    pthread_create(&tid2,NULL,t2,NULL);
    pthread_create(&tid3,NULL,t3,NULL);
    pthread_join(tid1,&primesum);
    pthread_join(tid2,NULL);
    pthread_join(tid3,NULL);
    printf("%d is the sum of first %d prime numbers",*((int*)(primesum)),N);
    clock_t end = clock();
    double ans = ((double)(end)-(double)(start))/(CLOCKS_PER_SEC);
    printf("\n%f sec",ans);
    return 0;
}
