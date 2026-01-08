rule STAR:
    input:
        find_exact_input_paths
    output:
        "results_{proj}/alignment/{sample_id}_Aligned.sortedByCoord.out.bam"
    params:
        index=config["star_index"],
        star_redi=config["STAR_REDI"],
        dir="results_{proj}/alignment/"
    shell: 
        """
        workdir=$PWD
        mkdir -p {params.dir} && cd {params.dir}
        {params.star_redi} {params.index} {input[0]} {input[1]} {wildcards.sample_id}
        """

rule REDIscript:
    input:
        "results_{proj}/alignment/{sample_id}_Aligned.sortedByCoord.out.bam" # bam from above
    output:
        directory("results_{proj}/editing_quantification/{sample_id}_Aligned.sortedByCoord.out")
    params:
        REDIscript=config["REDIscript"],
        reference=config["reference"],
        known=config["known"],
        dir="results_{proj}/editing_quantification/"
    threads: config["CPUS"]
    conda: "../envs/reditools.yml"
    shell:
        """
        workdir=$PWD
        mkdir -p {params.dir} && cd {params.dir}
        bash {params.REDIscript} $workdir/{input} {params.reference} {params.known} {threads}
        """
