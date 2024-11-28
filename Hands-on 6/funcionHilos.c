#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

void* print_numbers(void* arg) {
    int id = *(int*)arg; // Recibir el ID del hilo
    for (int i = 0; i < 5; i++) {
        printf("Hilo %d: %d\n", id, i);
        sleep(1); // Simular el trabajo
    }
    return NULL;
}

int main() {
    pthread_t hilos[3];
    int ids[3] = {1, 2, 3};

    // Crear e inicializar varios hilos
    for (int i = 0; i < 3; i++) {
        pthread_create(&hilos[i], NULL, print_numbers, &ids[i]);
    }

    // Esperar a que todos los hilos terminen
    for (int i = 0; i < 3; i++) {
        pthread_join(hilos[i], NULL);
    }

    printf("Todos los hilos han terminado.\n");
    return 0;
}
