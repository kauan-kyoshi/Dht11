#include "DHT.h" // Inclui a biblioteca do DHT11

#define  TIPO_SENSOR DHT11 // Define que o sensor que está sendo utilizado é o DTH11
const int PINO_SENSOR_DHT11 = A0; // Define uma variavel que atribui o pino sensor na porta analágica A0

DHT sensorDHT(PINO_SENSOR_DHT11, TIPO_SENSOR); // Define que o sensor está na porta A0

void setup() {
  Serial.begin(9600); // Inicia uma comunicação via serial na velocidade de 9600 baud rate
  sensorDHT.begin(); //Sincroniza a taxa de comunicação do serial begin com o sensor
}

void loop() {
  float umidade = sensorDHT.readHumidity() + 25; // Cria uma váriavel chamada umidade que é atribuida o valor da umidade medido pelo sensor
  float temperatura = sensorDHT.readTemperature();// Cira uma váriavel chama temperatura que é atribuida o valor de temperatura medida pelo sensor

  if (isnan(temperatura) || isnan(umidade) )
  {
    
  }
  else
  {
    Serial.print("TemperaturaMaxima:");
    Serial.print(27);
    Serial.print(" ");
    Serial.print("Temperatura:");
    Serial.print(temperatura);
    Serial.print(" ");
    Serial.print("TemperaturaMinima:");
    Serial.print(18);
    Serial.print(" ");
    Serial.print("UmidadeMaxima:");
    Serial.print(60);
    Serial.print(" ");
    Serial.print("Umidade:");
    Serial.print(umidade);
    Serial.print(" ");
    Serial.print("UmidadeMinima:");
    Serial.println(30);
  }

  delay(1000); // cria um delay de 1000ms
 
}
