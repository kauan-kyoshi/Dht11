#include "DHT.h" // Inclui a biblioteca do DHT11

#define  TIPO_SENSOR DHT11 // Define que o sensor que está sendo utilizado é o DTH11
const int PINO_SENSOR_DHT11 = A0; // Define uma variavel que atribui o pino sensor na porta analágica A0

DHT sensorDHT(PINO_SENSOR_DHT11, TIPO_SENSOR); // Define que o sensor está na porta A0

void setup() {
  Serial.begin(9600); // Inicia uma comunicação via serial na velocidade de 9600 baud rate
  sensorDHT.begin();
}

void loop() {
  float umidade = sensorDHT.readHumidity(); // Cria uma váriavel chamada umidade que é atribuida o valor da umidade medido pelo sensor
  float temperatura = sensorDHT.readTemperature();// Cira uma váriavel chama temperatura que é atribuida o valor de temperatura medida pelo sensor

  if (isnan(temperatura) || isnan(umidade) )
  {
    Serial.println("Erro ao ler os dados do sensor");
  }
  else
  {
    Serial.print("Umidade: "); // Imprime umidade
    Serial.print(umidade);// Imprime valor da umidade
    Serial.print(" % ");// Imprime %
    Serial.print("Temperatura: "); // Imprime temperatura:
    Serial.print(temperatura);// Imprime valor de temperatura
    Serial.println(" ºC");// Imprime Cº
  }

  delay(1000); // cria um delay de 1000ms
 
}
