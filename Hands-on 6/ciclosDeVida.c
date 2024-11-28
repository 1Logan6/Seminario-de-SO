#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

void* worker_function(void* arg) {
    printf("Hilo en ejecución...\n");
    sleep(2); // Simula tiempo de trabajo
    printf("Hilo terminando.\n");
    return NULL;
}

int main() {
    pthread_t hilo;

    // Se crea el hilo
    pthread_create(&hilo, NULL, worker_function, NULL);

    // Administra el ciclo de vida
    printf("Esperando a que el hilo termine...\n");
    pthread_join(hilo, NULL);
    printf("El hilo ha terminado.\n");

    return 0;
}
