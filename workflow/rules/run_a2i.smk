rule rehead_bams:
    input:
        "results_{proj}/alignment/{sample_id}_Aligned.sortedByCoord.out.bam" # bam from above
    output:
        bam= "results_{proj}/bams_reheaded/{sample_id}_chr.bam",
    params:
        dir= "results_{proj}/bams_reheaded"
    conda: "../envs/samtools.yml"
    shell:
        """
        mkdir -p {params.dir}
        samtools view -H {input} >/tmp/header && \
        sed -r 's/SN:/SN:chr/' </tmp/header \
        | sed -r 's/SN:chrMT/SN:chrM/' >/tmp/header_new && \
        samtools reheader -P /tmp/header_new {input} >{output.bam} && samtools index {output.bam}
        """

rule RNAEI:
    input: 
        expand("results_{{proj}}/bams_reheaded/{sample_id}_chr.bam",sample_id=OUTPUT_NAMES)
    output:
        directory("results_{proj}/aluEditingIndex/summary_dir")
    params:
        input_dir= "results_{proj}/bams_reheaded",
        tmp_dir="/tmp/a2i-{proj}",
        RNAEI=config["RNAEI"],
        resource_dir=config["resource_dir"]
    conda: "../envs/RNAEditingIndexer.yml"
    threads: config["CPUS"]
    shell:
        """
        workdir=$PWD
        mkdir -p {params.tmp_dir}

        {params.RNAEI} \
            -d $workdir/{params.input_dir} \
            -f _chr.bam \
            -l {params.tmp_dir}/log_dir \
            -o {params.tmp_dir}/pileup_dir \
            -os {params.tmp_dir}/summary_dir \
            --genome hg38 \
            -rb {params.resource_dir}/Regions/HomoSapiens/ucscHg38Alu.bed.gz \
            --refseq {params.resource_dir}/RefSeqAnnotations/HomoSapiens/ucscHg38RefSeqCurated.bed.gz \
            --snps {params.resource_dir}/SNPs/HomoSapiens/ucscHg38CommonGenomicSNPs150.bed.gz \
            --genes_expression {params.resource_dir}/GenesExpression/HomoSapiens/ucscHg38GTExGeneExpression.bed.gz \
            --genome_fasta {params.resource_dir}/Genomes/HomoSapiens/ucscHg38Genome.fa \
            --ts {threads} --paired

            mv {params.tmp_dir}/summary_dir {output}
        """