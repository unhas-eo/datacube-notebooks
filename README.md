# Introduction 
Working notebooks with UNHAS and CSIRO for Lake Tempe and surrounds. 

## Upload your notebooks

The "Outputs" that are embedded in a notebook can take up a lot of space. The code below will remove "Outputs" before pushing to the repository.

2. Run the `bin/apply_hooks.sh` script
   - `sh bin/apply_hooks.sh`
   - This will symlink a pre-commit git hook into your local `.git` directory.
   - The pre-commit git hook removes "outputs" from `*.ipynb` notebooks for future commits.
3. Git add and commit.
