#include <stdio.h>
#include <stdint.h>

#pragma pack(1)
typedef struct {
    uint16_t signature;      // "BM"
    uint32_t filesize;
    uint32_t reserved;
    uint32_t offset;         // Offset dos dados de pixel
} BMPHeader;

typedef struct {
    uint32_t size;
    int32_t width;
    int32_t height;
    uint16_t planes;
    uint16_t bitsPerPixel;
    uint32_t compression;
    uint32_t imageSize;
    int32_t xPixelsPerMeter;
    int32_t yPixelsPerMeter;
    uint32_t colorsUsed;
    uint32_t importantColors;
} DIBHeader;
#pragma pack()

int main(int argc, char *argv[]){
    if(argc < 2){
        printf("Uso: %s <arquivo.bmp>\n", argv[0]);
        return 1;
    }

    FILE *f = fopen(argv[1], "rb");
    if(!f){
        perror("Erro ao abrir arquivo");
        return 1;
    }

    BMPHeader bmp;
    DIBHeader dib;
    
    fread(&bmp, sizeof(BMPHeader), 1, f);
    fread(&dib, sizeof(DIBHeader), 1, f);

    // Verifica se é BMP válido
    if(bmp.signature != 0x4D42){ // "BM" em little endian
        printf("Erro: Não é um arquivo BMP válido\n");
        fclose(f);
        return 1;
    }

    int width = dib.width;
    int height = dib.height;
    int bitsPerPixel = dib.bitsPerPixel;

    printf("%d %d\n", width, height);

    // Se for grayscale 8-bit
    if(bitsPerPixel == 8){
        fseek(f, bmp.offset, SEEK_SET);
        
        int padding = (4 - (width % 4)) % 4; // BMP alinha em 4 bytes

        for(int y = height - 1; y >= 0; y--){
            for(int x = 0; x < width; x++){
                uint8_t pixel;
                fread(&pixel, 1, 1, f);
                printf("%d ", pixel);
            }
            fseek(f, padding, SEEK_CUR); // Pula padding
        }
    }
    // Se for RGB 24-bit, converte para grayscale
    else if(bitsPerPixel == 24){
        fseek(f, bmp.offset, SEEK_SET);
        
        int padding = (4 - ((width * 3) % 4)) % 4;

        for(int y = height - 1; y >= 0; y--){
            for(int x = 0; x < width; x++){
                uint8_t b, g, r;
                fread(&b, 1, 1, f);
                fread(&g, 1, 1, f);
                fread(&r, 1, 1, f);
                
                // Converte para grayscale (luminância)
                int gray = (r * 299 + g * 587 + b * 114) / 1000;
                printf("%d ", gray);
            }
            fseek(f, padding, SEEK_CUR);
        }
    }

    printf("\n");
    fclose(f);
    return 0;
}
