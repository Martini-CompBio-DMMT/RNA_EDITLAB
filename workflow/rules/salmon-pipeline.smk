rule salmon_PE:
    input:
        find_exact_input_paths
    output:
        directory("results_{proj}/salmon_quantification/{sample_id}")
    params:
        dir= "results_{proj}/salmon_quantification/",
        tr_idx=config["tr_idx"],
        libtype=config["libtype"]
    threads: config["CPU"]
    conda: "../envs/samtools.yml"
    shell: 
        """
        mkdir -p {params.dir}
        salmon quant -i {params.tr_idx} \
            -l {params.libtype} -1 {input[0]} -2 {input[1]} \
            -p {threads} \
            --validateMappings -o {output}
        """