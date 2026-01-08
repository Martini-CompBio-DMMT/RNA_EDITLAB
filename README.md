# RNA Editing Snakemake Pipeline
This pipeline provides a structured workflow for identifying RNA editing sites from sequencing data. It leverages Snakemake for reproducibility and Conda for automated software management.

## 1. Installation
It is recommended to install Snakemake within a dedicated Conda environment to avoid dependency conflicts.

```bash
# Create a new environment and install Snakemake
conda create -n snakemake_env -c bioconda -c conda-forge snakemake=9.11.3

# Activate the environment
conda activate snakemake_env
```

## 2. Configuration
Before running the pipeline, you must configure your project parameters:

Copy the template config/config.yml to your working directory.

Edit config.yml to specify your input file paths (FASTQ/BAM), reference genome, and tool-specific parameters.

## 3. Usage
Dry Run
Always perform a dry run first to validate the workflow logic and ensure all input files are present:

```bash
snakemake --cores 1 --dry-run -p \
  --configfile config.yml \
  --use-conda \
  -s workflow/Snakefile
```

## 4. Execution
Once you have verified that everything is set up correctly, remove the --dry-run flag to start the analysis:

```bash
snakemake --cores <N_CORES> --use-conda --configfile config.yml -s workflow/Snakefile
```
