#!/usr/bin/env bash
#BSUB -J RNAroids 
#BSUB -o logs/snakemake_%J.out
#BSUB -e logs/snakemake_%J.err
#BSUB -R "select[mem>4] rusage[mem=4] " 
#BSUB -q normal

set -o nounset -o pipefail -o errexit -x

args=' -q rna -o {log}.out -e {log}.err -J {params.job_name} -R " {params.memory} span[hosts=1] " -n {threads} '

snakemake --drmaa "$args" --snakefile Snakefile --jobs 8 \
  --latency-wait 50 --rerun-incomplete  --configfile config_rnaseq.yaml 
  
