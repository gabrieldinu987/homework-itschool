#!/usr/bin/env python3

# Faceți un script de python ce genereaza un log fake.
# Cerinte: scriptul primește ca argument cate linii de log să genereze fiecare linie este scrisă cu un level de logging random (INFO, WARNING, sau ERROR)
# Fiecare linie de log contine: 
#   - un mesaj random dintr-o lista de mesaje predefinite de voi 
#   - un request id random dintr-o lista fixa de 10 request id-uri generata la începutul scriptului (fiecare request id este un UUID)
#   - data și ora la care s-a printat mesajul 
#   - nivelul de logging

import logging
import random
import uuid
import argparse


def configure_logger():
    """Configurează sistemul de logging."""
    logging.basicConfig(
        filename="fake_app.log",
        level=logging.DEBUG,  # Permite toate nivelurile
        format="%(asctime)s | %(levelname)s | %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S"
    )


def generate_request_ids():
    """Generează o listă fixă de 10 request ID-uri UUID."""
    request_ids = [str(uuid.uuid4()) for _ in range(10)]
    logging.debug(f"Request ID-uri generate: {request_ids}")
    return request_ids


def generate_messages():
    """Returnează o listă de mesaje predefinite."""
    return [
        "User authenticated successfully",
        "Database connection established",
        "File uploaded successfully",
        "Invalid user credentials",
        "Resource not found",
        "Timeout while processing request",
        "Access denied",
        "Configuration loaded",
        "Service started successfully",
        "Unexpected server error occurred"
    ]


def generate_fake_logs(num_lines):
    """Generează loguri fictive."""
    logging.info("Pornire generare loguri fictive.")

    request_ids = generate_request_ids()
    messages = generate_messages()
    levels = ["INFO", "WARNING", "ERROR"]

    for i in range(num_lines):
        level = random.choice(levels)
        message = random.choice(messages)
        request_id = random.choice(request_ids)

        log_message = f"RequestID={request_id} | {message}"

        if level == "INFO":
            logging.info(log_message)
        elif level == "WARNING":
            logging.warning(log_message)
        elif level == "ERROR":
            logging.error(log_message)

        logging.debug(
            f"Linia {i + 1}: level={level}, request_id={request_id}"
        )

    logging.info("Generarea logurilor s-a încheiat cu succes.")


def parse_arguments():
    """Parsează argumentele din linia de comandă."""
    parser = argparse.ArgumentParser(
        description="Script Python pentru generarea de loguri fictive."
    )
    parser.add_argument(
        "num_lines",
        type=int,
        help="Numărul de linii de log ce vor fi generate."
    )
    return parser.parse_args()


def main():
    args = parse_arguments()
    configure_logger()

    if args.num_lines <= 0:
        logging.error("Numărul de linii trebuie să fie pozitiv.")
        raise ValueError("Numărul de linii trebuie să fie mai mare decât 0.")

    logging.debug(f"Argument primit: num_lines={args.num_lines}")
    generate_fake_logs(args.num_lines)


if __name__ == "__main__":
    main()