#include <stdio.h>
#include <pthread.h>

void* print_message(void* arg) {
    printf("Hola desde el hilo\n");
    return NULL;
}

int main() {
    pthread_t hilo; // Esta es la declaracion del hilo

    // Se crea e inicializa el hilo que llamara a la funcion
    if (pthread_create(&hilo, NULL, print_message, NULL) != 0) {
        perror("Error al crear el hilo");
        return 1;
    }

    // Esperar a que el hilo termine
    pthread_join(hilo, NULL);

    printf("Hilo terminado\n");
    return 0;
}
