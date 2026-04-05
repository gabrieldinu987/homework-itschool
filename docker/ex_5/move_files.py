import os
import shutil
import time

INPUT_DIR = "/input"
OUTPUT_DIR = "/output"

def move_files():
    while True:
        files = os.listdir(INPUT_DIR)
        
        if not files:
            print("Nu sunt fisiere de mutat...")
        
        for file_name in files:
            src = os.path.join(INPUT_DIR, file_name)
            dst = os.path.join(OUTPUT_DIR, file_name)

            if os.path.isfile(src):
                print(f"Mut {file_name}...")
                shutil.move(src, dst)
                time.sleep(5)

        time.sleep(2)

if __name__ == "__main__":
    move_files()