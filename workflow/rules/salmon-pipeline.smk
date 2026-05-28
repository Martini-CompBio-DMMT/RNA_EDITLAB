rule salmon_PE:
    input:
        find_exact_input_paths
    output:
        directory("results_{proj}/salmon_quantification/{sample_id}")
    params:
        dir= "results_{proj}/salmon_quantification/",
        tr_idx=config["tr_idx"],
        libtype=config["libtype"],
        reads = lambda wildcards, input: f"-1 {input[0]} -2 {input[1]}" if len(input) == 2 else f"-r {input[0]}"
    threads: config["CPU"]
    conda: "../envs/samtools.yml"
    shell: 
        """
        mkdir -p {params.dir}
        salmon quant -i {params.tr_idx} \
            -l {params.libtype} \
            {params.reads} \
            -p {threads} \
            --validateMappings -o {output}
        """