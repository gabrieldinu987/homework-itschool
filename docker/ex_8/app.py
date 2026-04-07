import logging
import time
import os

# Creează directorul dacă nu există
os.makedirs("./log", exist_ok=True)

# Configurare logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(message)s",
    handlers=[
        logging.FileHandler("./log/app.log"),
        logging.StreamHandler()
    ]
)

while True:
    logging.info("Aplicația rulează...")
    time.sleep(1)