import subprocess
import os

# Configuration
LIST_FILE = "tests.list"
TOP_MODULE = "dma_top" 
TOP_FILE = "dma_top.sv" 

# Directory Names
LOG_DIR = "log"
UCDB_DIR = "ucdb"

def run_command(cmd):
    try:
        subprocess.run(cmd, check=True)
        return True
    except subprocess.CalledProcessError:
        return False

def run_flow():
    # 0. PREPARE DIRECTORIES
    for folder in [LOG_DIR, UCDB_DIR]:
        if not os.path.exists(folder):
            os.makedirs(folder)

    # 1. COMPILE ONCE
    print(">>> Compiling...")
    if not run_command(["make", "compile_with_cov", f"top_file={TOP_FILE}"]):
        return

    # 2. RUN TESTS
    if not os.path.exists(LIST_FILE):
        print(f"Error: {LIST_FILE} not found.")
        return

    with open(LIST_FILE, "r") as f:
        tests = [line.strip().lstrip('#') for line in f if line.strip()]

    ucdb_files = []
    for test in tests:
        print(f"\n>>> Running Test: {test}")
        
        # Define paths for logs and UCDBs
        log_path = os.path.join(LOG_DIR, f"{test}.log")
        unique_ucdb = os.path.join(UCDB_DIR, f"{test}.ucdb")
        
        # KEY CHANGE: Updated log argument to point to the log directory
        run_cmd = [
            "make", "run_with_cov", 
            f"top_module={TOP_MODULE}", 
            f"arg=+UVM_TESTNAME={test} -l {log_path}"
        ]
        
        if run_command(run_cmd):
            # RENAME UCDB and move to UCDB directory
            if os.path.exists("coverage.ucdb"):
                os.rename("coverage.ucdb", unique_ucdb)
                ucdb_files.append(unique_ucdb)
                print(f"Coverage saved to {unique_ucdb}, Log saved to {log_path}")

    # 3. MERGE EVERYTHING
    if ucdb_files:
        print("\n>>> Merging all coverage databases...")
        # Merged file will be placed inside the ucdb directory
        total_ucdb = os.path.join(UCDB_DIR, "total_coverage.ucdb")
        merge_cmd = ["vcover", "merge", total_ucdb] + ucdb_files
        run_command(merge_cmd)
        
        print(">>> Generating Final HTML Report...")
        # Report remains in its own directory for easy browser access
        report_cmd = ["vcover", "report", "-html", total_ucdb, "-htmldir", "final_cov_report", "-details"]
        run_command(report_cmd)

if __name__ == "__main__":
    run_flow()
