RNA editing Snakemake pipeline.

To run copy the config in your work directory and modify with required parameters. Then run:
snakemake --cores 1 --dry-run -p --configfile config.yml --use-conda -s /mnt/resources/RNA_editLab/workflow/Snakefile
